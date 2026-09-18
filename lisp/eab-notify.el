;;; eab-notify.el --- eab notify extension -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defvar eab/gotify-token-cache "" "")
(defun eab/gotify-token ()
  (if (not (equal (length eab/gotify-token-cache) 15))
      (setq eab/gotify-token-cache
            (substring (shell-command-to-string
                        (eab/config (concat eab/ssh-host " bash <<'END'
~/git/auto/keepass.sh \"portal/gotify\" -a app-test-token
END
" ))) 0 -1)))
  eab/gotify-token-cache)

;; TODO: not in eab/config due to async-start and args
;; maybe ,(eab/config ...)?
(defun eab/gotify (title message priority)
  (async-start
   `(lambda ()
      (call-process-shell-command
       (concat
        "/home/eab/git/auto/notify.sh -a " ,(eab/gotify-token)
        " -t \"" ,title "\""
        " -m \"" ,message "\""
        " -p " ,(number-to-string priority))) nil 0)))

(defvar eab/gotify-client-token-cache "" "")
(defun eab/gotify-client-token ()
  (if (not (equal (length eab/gotify-client-token-cache) 15))
      (setq eab/gotify-client-token-cache
            (substring
             (shell-command-to-string
              (eab/config (concat eab/ssh-host " bash <<'END'
~/git/auto/keepass.sh \"portal/gotify\" -a client-token
END
" ))) 0 -1)))
  eab/gotify-client-token-cache)
(setq eab/gotify-command
      (eab/config
       (concat
        "ssh kairos"
        " 'sqlite3 -column /var/gotify/data/gotify.db \"select datetime(date,\\\"localtime\\\"),title,message from messages order by date desc limit 20;\"'")))
;; (eab/gotify "test" "test" 0)


(setq eab/gotify-ready? nil)
(defvar eab/gotify-websocket nil "gotify websocket")
(defun eab/gotify-status (&optional arg)
  (interactive)
  (unless (websocket-openp eab/gotify-websocket)
    (eab/gotify-create))
  (let ((gotify-buffer "*compilation*<gotify>"))
    (if eab/gotify-ready?
        (progn
          (if (not (eab/gotify-check))
              (progn
                (websocket-close eab/gotify-websocket)
                (eab/gotify-create)
                (switch-to-buffer gotify-buffer nil 't)
                (let ((compilation-buffer-name-function nil))
                  (recompile)))
            (switch-to-buffer gotify-buffer nil 't)))
      (progn
        (let ((compilation-buffer-name-function
               `(lambda (mode) ,gotify-buffer)))
          (save-window-excursion
            (eab/compile eab/gotify-command)))
        (setq eab/gotify-ready? 't)
        (switch-to-buffer gotify-buffer nil 't)))))

(defun eab/gotify-create ()
  (let ((gotify-buffer "*compilation*<gotify>"))
    (setq eab/gotify-websocket
          (websocket-open
           (concat "wss://notify.eab.su/stream?token=" (eab/gotify-client-token))
           :on-message `(lambda (_websocket frame)
                          (let ((text (websocket-frame-text frame)))
                            (save-window-excursion
                              (switch-to-buffer ,gotify-buffer)
                              (let ((compilation-buffer-name-function nil)
                                    (compilation-ask-about-save nil))
                                (recompile)))))
           :on-close (lambda (_websocket) (message "websocket closed"))))))

(defun eab/gotify-check ()
  (let ((event (car
                (split-string
                 (shell-command-to-string eab/gotify-command) "         "))))
    (with-current-buffer "*compilation*<gotify>"
      (s-contains? event
                   (buffer-substring-no-properties (point-min) (point-max))))))


'((let ((server-use-tcp server-C-use-tcp))
    (list (server-eval-at "chronosC" '(eab/gotify-token))
          (server-eval-at "chronosC" '(eab/gotify-client-token))
          (server-eval-at "kairosC" '(eab/gotify-token))
          (server-eval-at "kairosC" '(eab/gotify-client-token))))
  )

'((let ((server-use-tcp 't))
    (list (server-eval-at "kairosP" '(eab/gotify-token))
          (server-eval-at "kairosP" '(eab/gotify-client-token))))
  )

'((eab/gotify "Hello" "from emacs" 0)
  (websocket-close eab/gotify-websocket)
  (websocket-openp eab/gotify-websocket)
  )

(provide 'eab-notify)
