;;; owui-run.el --- Run a prompt through Open WebUI with server-side tool calling -*- lexical-binding: t; -*-

;; Package-Requires: ((emacs "27.1"))
;; SPDX-License-Identifier: MIT

;;; Commentary:

;; Elisp port of a Python script that runs a prompt through Open WebUI
;; with server-side tool calling:
;;
;;   1. POST /api/v1/chats/new      create a stub chat (user message +
;;                                  empty assistant message in history)
;;   2. POST /api/chat/completions  run the prompt.  Streaming is required
;;                                  because the native tool loop is
;;                                  streaming-only; the request blocks
;;                                  until the server closes the stream
;;                                  (same as the Python original, where
;;                                  requests buffers the whole response).
;;   3. GET  /api/tasks/chat/:id    poll until no background tasks are
;;                                  left, or :timeout is reached
;;   4. GET  /api/v1/chats/:id      fetch the finished assistant message
;;   5. DELETE /api/v1/chats/:id    optional cleanup
;;
;; Configuration:
;;
;;   (setq owui-url   "http://localhost:3000"
;;         owui-key   "sk-..."
;;         owui-model "gpt-5.6-sol")
;;
;; Usage:
;;
;;   (owui-run "What is 6 * 7?")
;;   => alist of the assistant message ("content", "output", "usage",
;;      "sources", ...)
;;
;;   ;; just the reply text:
;;   (cdr (assoc "content" (owui-run "What is 6 * 7?")))
;;
;;   ;; with options (mirrors the Python keyword arguments):
;;   (owui-run "Summarize this"
;;             :system "Be terse."
;;             :tool-ids '("tools.example")
;;             :terminal-id "abc123"
;;             :features '((web_search . :json-false)
;;                         (code_interpreter . t)
;;                         (image_generation . :json-false)
;;                         (memory . :json-false))
;;             :builtin-tools t
;;             :timeout 120)
;;
;; Interactive: M-x owui-run-prompt RET.
;;
;; Notes on the port:
;;   * HTTP uses the built-in url.el; JSON encoding uses json.el, JSON
;;     parsing uses the native `json-parse-string' (Emacs 27+).
;;   * In :features and flag alists, JSON false is `:json-false';
;;     nil would encode as JSON null.
;;   * Requests send "Connection: close" so url.el reliably treats the
;;     end of the SSE stream as the end of the response.

;;; Code:

(require 'cl-lib)
(require 'json)
(require 'url)

(unless (fboundp 'json-parse-string)
  (error "owui-run requires Emacs 27.1 or newer (native JSON)"))

(defgroup owui nil
  "Run prompts through an Open WebUI server."
  :prefix "owui-"
  :group 'applications)

(defcustom owui-url "http://192.168.2.18:3003"
  "Base URL of the Open WebUI server."
  :type 'string)

(defcustom owui-key (eab/webui-token)
  "Open WebUI API key, sent as a bearer token."
  :type 'string)

(defcustom owui-model "z-ai/glm-5.3-flash"
  "Model used for the run."
  :type 'string)

(defcustom owui-delete-chat-when-done t
  "When non-nil, delete the chat when finished.
nil keeps the conversation in the user's chat list."
  :type 'boolean)

(defconst owui--default-features
  '((web_search . t)
    (code_interpreter . t)
    (image_generation . :json-false)
    (memory . :json-false))
  "Feature flags sent unless overridden with the :features argument.
Values must be t or :json-false (nil would encode as JSON null).")

(defun owui--headers ()
  "HTTP headers for Open WebUI API requests."
  `(("Content-Type" . "application/json")
    ("Authorization" . ,(format "Bearer %s" owui-key))
    ;; One connection per request: url.el then ends the response at EOF,
    ;; which makes the streaming /api/chat/completions call terminate
    ;; reliably even while the server keeps the HTTP connection open.
    ("Connection" . "close")))

(defun owui--uuid ()
  "Return a random version 4 UUID string (stand-in for Python's uuid4)."
  (format "%08x-%04x-4%03x-%04x-%012x"
          (random #x100000000)
          (random #x10000)
          (random #x1000)
          (logior #x8000 (logand #x3fff (random #x4000)))
          (random #x1000000000000)))

(defun owui--get (key alist)
  "Value of string KEY in a JSON-parsed ALIST."
  (cdr (assoc key alist)))

(defun owui--request (method url &optional payload timeout)
  "Send METHOD request to URL, with JSON-encoded PAYLOAD when given.
Return (STATUS . BODY); BODY is the JSON body parsed into
alists/lists, or the raw response string if it is not JSON (the
/api/chat/completions endpoint answers with an SSE stream).
STATUS is the integer HTTP response code.  Transport errors are
signaled; callers check STATUS with `owui--raise-for-status'.
TIMEOUT, when non-nil, bounds the whole request in seconds."
  (let* ((url-request-method method)
         (url-request-extra-headers (owui--headers))
         (url-request-data (and payload
                                 (encode-coding-string (json-encode payload)
                                                       'utf-8)))
         (url-mime-encoding-string "identity") ; url.el cannot gunzip itself
         buf)
    (unwind-protect
        (progn
          (setq buf (url-retrieve-synchronously url nil nil timeout))
          (unless (buffer-live-p buf)
            (error "OWUI: no response from %s" url))
          (with-current-buffer buf
            (goto-char (point-min))
            (unless (re-search-forward "\r?\n\r?\n" nil t)
              (error "OWUI: malformed HTTP response from %s" url))
            (let* ((status (or (bound-and-true-p url-http-response-status) 0))
                   (raw (decode-coding-string
                         (buffer-substring-no-properties (point) (point-max))
                         'utf-8))
                   (body (condition-case nil
                             (json-parse-string raw
                                                :object-type 'alist
                                                :array-type 'list
                                                :null-object nil
                                                :false-object :json-false)
                           (error raw))))
              (cons status body))))
      (when (buffer-live-p buf)
        (kill-buffer buf)))))

(defun owui--raise-for-status (status url body)
  "Raise an error unless STATUS is a 2xx code (requests.raise_for_status)."
  (unless (and (>= status 200) (< status 300))
    (let ((excerpt (format "%s" body)))
      (when (> (length excerpt) 200)
        (setq excerpt (concat (substring excerpt 0 200) "...")))
      (error "OWUI: HTTP %d from %s: %s" status url excerpt))))

(defun owui--chat-payload (prompt user-id assistant-id now)
  "Payload for POST /api/v1/chats/new."
  `((chat . ((title . "API run")
             (models . (,owui-model))
             (history . ((currentId . ,assistant-id)
                         (messages . ((,user-id . ((id . ,user-id)
                                                   (role . "user")
                                                   (content . ,prompt)
                                                   (timestamp . ,now)
                                                   (models . (,owui-model))
                                                   (childrenIds . (,assistant-id))))
                                      (,assistant-id . ((id . ,assistant-id)
                                                        (role . "assistant")
                                                        (content . "")
                                                        (parentId . ,user-id)
                                                        (childrenIds . [])
                                                        (model . ,owui-model)
                                                        (modelName . ,owui-model)
                                                        (modelIdx . 0)
                                                        (done . :json-false)
                                                        (timestamp . ,(1+ now))))))))))))

(defun owui--new-chat (prompt user-id assistant-id now)
  "Create the stub chat on the server; return its id."
  (let* ((url (concat owui-url "/api/v1/chats/new"))
         (resp (owui--request "POST" url
                              (owui--chat-payload prompt user-id
                                                  assistant-id now))))
    (owui--raise-for-status (car resp) url (cdr resp))
    (or (owui--get 'id (cdr resp))
        (error "OWUI: %s returned no chat id" url))))

(defun owui--completion-body (chat-id assistant-id messages
                                      features builtin-tools tool-ids
                                      terminal-id)
  "Payload for POST /api/chat/completions."
  `((model . ,owui-model)
    (messages . ,messages)
    ;; Required: the native tool loop is streaming-only.
    (stream . t)
    (chat_id . ,chat-id)
    (id . ,assistant-id)
    (background_tasks . ((title_generation . :json-false)
                         (tags_generation . :json-false)
                         (follow_up_generation . :json-false)))
    (features . ,(or features owui--default-features))
    ,@(when builtin-tools               ; unlocks the built-in tools
        `((session_id . ,(concat "api-" (owui--uuid)))))
    ,@(when tool-ids `((tool_ids . ,tool-ids)))
    ,@(when terminal-id `((terminal_id . ,terminal-id)))))

(cl-defun owui-run (prompt
                    &key
                    tool-ids          ; e.g. '("tools.my_tool")
                    terminal-id       ; id of a terminal session
                    features          ; alist overriding owui--default-features
                    system            ; optional system prompt
                    (builtin-tools t) ; nil to not request built-in tools
                    (timeout 600))    ; seconds
  "Run PROMPT through Open WebUI with server-side tool calling.
Returns the finished assistant message as an alist (\"content\",
\"output\", \"usage\", \"sources\", ...), like the Python original.

See the Commentary header for the available keyword arguments."
  (let* ((now (time-convert nil 'integer))
         (user-id (owui--uuid))
         (assistant-id (owui--uuid))
         (chat-id (owui--new-chat prompt user-id assistant-id now))
         (messages (append (when system
                             (list `((role . "system") (content . ,system))))
                           (list `((role . "user") (content . ,prompt)))))
         (completions-url (concat owui-url "/api/chat/completions"))
         (started (owui--request
                   "POST" completions-url
                   (owui--completion-body chat-id assistant-id messages
                                          features builtin-tools
                                          tool-ids terminal-id)
                   timeout)))
    (owui--raise-for-status (car started) completions-url (cdr started))
    ;; Poll until the server reports no outstanding background tasks.
    (let ((tasks-url (format "%s/api/tasks/chat/%s" owui-url chat-id))
          (deadline (+ (float-time) timeout))
          clear)
      (while (not clear)
        (when (> (float-time) deadline)
          (error "OWUI: chat %s did not finish within %ds" chat-id timeout))
        (let ((resp (owui--request "GET" tasks-url)))
          (owui--raise-for-status (car resp) tasks-url (cdr resp))
          (setq clear (not (owui--get 'task_ids (cdr resp)))))
        (unless clear
          (sleep-for 2))))
    ;; Fetch the finished assistant message.
    (let* ((final-url (format "%s/api/v1/chats/%s" owui-url chat-id))
           (resp (owui--request "GET" final-url)))
      (owui--raise-for-status (car resp) final-url (cdr resp))
      (let ((message (owui--get
                      (intern assistant-id)
                      (owui--get 'messages
                                 (owui--get 'history
                                            (owui--get 'chat (cdr resp)))))))
        (when owui-delete-chat-when-done
          (owui--request "DELETE" final-url))
        (or message
            (error "OWUI: assistant message %s not found in chat %s"
                   assistant-id chat-id))))))

(defun owui-run-prompt (prompt)
  "Ask PROMPT interactively and show the reply in a read-only buffer."
  (interactive "sOpen WebUI prompt: ")
  (let ((message (owui-run prompt)))
    (with-current-buffer (get-buffer-create "*Open WebUI*")
      (special-mode)
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert (or (owui--get 'content message) "")))
      (goto-char (point-min))
      (pop-to-buffer (current-buffer)))))

(provide 'owui-run)
;;; owui-run.el ends here
