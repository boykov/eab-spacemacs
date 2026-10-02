;;; eab-minimal.el --- eab minimal configure -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package cl-macs)

(defvar eab/explore-map (make-sparse-keymap) "Keymap for minimal configuration")
(defvar eab/one-key-map (make-sparse-keymap)  "One-key keymap.")
(defvar eab/ctrl-l-map (make-sparse-keymap)  "C-l keymap.")
(defvar eab/compile-map (make-sparse-keymap) "Compile keymap.")
(defvar eab/wg-map (make-sparse-keymap) "Keymap for workgroups operations.")
(defvar eab/dired-map (make-sparse-keymap) "keymap for fast dired")
(defvar eab/grep-map (make-sparse-keymap) "Grep keymap.")

(defmacro eab/config (&rest body) (car `,@body))

(defmacro eab/add-hook (hookname funcname &rest body)
  "add-hook with lambda progn"
  (declare (indent defun))
  `(progn (add-hook ',hookname ',funcname)
          (defun ,funcname ()
            (progn ,@body))))

(defmacro ilam (&rest body)
  "Interactive lambda"
  `'(:def (lambda ()
            (interactive)
            ,@body)))

(defmacro ilam-no-def (&rest body)
  "Interactive lambda"
  `(lambda ()
     (interactive)
     ,@body))

;; DONE: timers depend on keboard speed
(defmacro eab/do-action (&rest body)
  ""
  `'(:def (lambda ()
            (interactive)
            (let ((executing-kbd-macro defining-kbd-macro))
              (run-with-timer 0.01 nil ,@body)
              (abort-recursive-edit)))))

(defun eab/kbd-macro-query ()
  (interactive)
  (let (executing-kbd-macro defining-kbd-macro)
    (run-with-timer 0.01 nil (ilam-no-def (execute-kbd-macro (read-kbd-macro "C-]"))))
    (run-with-timer 0.02 nil (ilam-no-def (execute-kbd-macro (read-kbd-macro "M-g"))
                                          (pop kill-ring)
                                          (setq kill-ring-yank-pointer kill-ring)))
    (recursive-edit)))


(defun eab/or-self-insert (command)
  (if (use-region-p)
      (call-interactively command)
    (call-interactively 'self-insert-command)))

(defmacro eab/or-self-insert-body (&rest body)
  `(if (use-region-p)
         ,@body
     (call-interactively 'self-insert-command)))

(defmacro eab/search-word (funcname name function &optional funargs)
  "Wrapper for search word interface."
  `(defun ,funcname (&optional arg)
     (interactive "P")
     (let ((word (if arg
                     (read-string (concat ,name " word: ") (current-word))
                   (current-word))))
       (,function ,@funargs))))

(defun eab/replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(defun eab/print-0 (body)
  "Insert value of body in current-buffer."
  (let ((print-length nil)
        (eval-expression-print-length nil))
    (prin1 `,body (current-buffer))))

(defun nthcar (n list)
  "Return first N elements of LIST.
If LIST length below N, return entire list.
If LIST is nil, return nil."
  (reverse (nthcdr (- (length list) n) (reverse list))))

(defun file-only-use-package-p (&optional file)
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-only-use-package-p)))

(defun buffer-only-use-package-p (&optional buffer)
  "Return non-nil if BUFFER contains only `use-package' and `provide' forms.
BUFFER defaults to the current buffer.  Comments and whitespace are
ignored.  An empty buffer or unreadable contents count as invalid."
  (with-current-buffer (or buffer (current-buffer))
    (save-excursion
      (save-restriction
        (widen)
        (goto-char (point-min))
        (catch 'done
          (let ((count 0) form)
            (while t
              ;; (message (number-to-string count))
              (condition-case nil
                  (setq form (read (current-buffer)))
                (end-of-file (throw 'done (> count 0)))
                (scan-error  (throw 'done nil)))
              (unless (and (consp form)
                           (memq (car form) '(use-package provide)))
                (throw 'done nil))
              (setq count (1+ count)))))))))

(defun eab/config-files ()
  "Return the list of eab-config-*.el files."
  (file-expand-wildcards (concat eab-spacemacs-path "lisp/eab-config-*.el")))

(defun eab/config-file-to-package (file)
  "Return the package name (symbol) for eab-config FILE."
  (intern (replace-regexp-in-string
           (concat eab-spacemacs-path "lisp/") ""
           (replace-regexp-in-string ".el$" "" file))))

(defun eab/load-configs ()
  "Load all eab-config-* packages after `eab-minimal'."
  (dolist (p (mapcar #'eab/config-file-to-package (eab/config-files)))
    (eval `(use-package ,p
             :after (eab-minimal)))))

(defun eab/check-only-use-package ()
  "Signal an error if eab-config-* files contain wrong forms."
  (let ((check-only-use-package 't))
    (dolist (f (eab/config-files))
      (setq check-only-use-package
            (and check-only-use-package (file-only-use-package-p f))))
    (if (not check-only-use-package)
        (error "eab-config-* files contain wrong forms: use-package and
 provide are only permitted"))))

;; TODO для многих патчей требуется одновременно несколько замен
;; значит, если продолжать в этом направлении, надо заменить пару
;; (regexp rep) на список пар
;; лучше использовать el-patch
(cl-defun eab/patch-this-code (func-name rpairs &optional &key lexical native)
  (let* ((overriding-terminal-local-map (make-sparse-keymap))
         (func-string (save-window-excursion
                        (find-function-do-it func-name nil 'switch-to-buffer)
                        (let ((bgn (point)))
                          (forward-sexp)
                          (let ((end (point)))
                            (buffer-substring-no-properties bgn end)))))
         (func-code (read
                     (seq-reduce
                      (lambda (string regexp-replacement-pair)
                        (replace-regexp-in-string
                         (car regexp-replacement-pair)
                         (cdr regexp-replacement-pair)
                         string))
                      rpairs
                      func-string))))
    (if native
        (native-compile (eval func-code lexical))
      (eval func-code lexical))))

(defun eab/loaded-ok (instance)
  (let* ((aaorg
          (if (string= (locate-library "org")
                       "/home/eab/.emacs.d/private/eab-spacemacs/local/org-mode/lisp/org.elc")
              0
            1))
         (numerrors
          (save-window-excursion
            (switch-to-buffer "*Messages*")
            (goto-char (point-min))
            (+ aaorg
               (count-matches "error")
               (count-matches "is void")
               (count-matches "Invalid")))))
    (if (or (and
             (boundp 'configuration-layer-error-count)
             configuration-layer-error-count)
            (< 0 numerrors))
        (progn
          (add-to-list 'mode-line-modes '(t " [ERROR] "))
          (eab/gotify
           (concat instance " errors "
                   (if (and (boundp 'configuration-layer-error-count)
                            configuration-layer-error-count)
                       (number-to-string configuration-layer-error-count) "0")
                   " " (number-to-string numerrors))
           "bad" 5))
      (progn
        (eab/gotify instance "OK" 0)
        (setq-default TeX-master t)))))

(defun display-startup-echo-area-message ()
  "Change the default welcome message of minibuffer to another one."
  (message "eab-spacemacs is ready."))

(defun eab/test-dotemacs ()
  (eab/loaded-ok "test-dotemacs")
  (sleep-for 0.5)
  (kill-emacs))

(defun eab/load-personal ()
  (interactive)
  ;; (if (fboundp 'grep-a-lot-clear-stack)
  ;;     (grep-a-lot-clear-stack))
  (winner-mode)
  ;; (setq eab/secrets-path (concat user-emacs-directory "eab-private/eab-secrets.el.gpg"))
  ;; (load-file eab/secrets-path)
  (cl-assert
   (equal (ido-completing-read-silent
           "prompt: " '("one" "two" "three" "four" "five") "t")
          '("two" "three")))
  (general-define-key "C-f"          eab/explore-map)
  (general-define-key "C-e"          eab/one-key-map)
  (general-define-key "C-l"          eab/ctrl-l-map)
  (general-define-key "C-d"          eab/compile-map)
  (general-define-key "C-a"          eab/wg-map)
  (general-define-key "C-x d"        eab/dired-map)
  (general-define-key "C-x G"        eab/grep-map)

  (if (file-exists-p power-macros-file) (load power-macros-file))
  (global-eldoc-mode 0)
  (electric-indent-mode -1)
  (electric-pair-mode -1)
  (yas-reload-all)
  (setq default-input-method "russian-computer")
  (setq system-time-locale "ru_RU.utf8")
  (setq desktop-load-locked-desktop 't)
  (if (and (or
            (eab/ondaemon (eab/server-P))
            (eab/ondaemon "server"))
           (not noninteractive))
      (progn
        (setq spacemacs-theme-comment-bg nil)
        (disable-theme 'solarized-light)
        (load-theme 'spacemacs-dark 't)))
  (if (and
       (eab/ondaemon (eab/server-C))
       (not noninteractive))
      (load-theme 'solarized-light 't))
  (setq eab/org-file (concat org-directory "clock/current-time.el"))
  (if (file-exists-p eab/org-file)
      (load eab/org-file)) ;; (setq eab/hron-current-time ..
  (eab/renew-agenda-files-1)
  
  (eab/loaded-ok (concat (daemonp) " dotemacs"))
  )

(defvar eab/first-emacsclient 't "nil if run again")

;; TODO: create function and hook after first start frame
(defun eab/load-gui ()
  (interactive)
  (if eab/first-emacsclient
      (progn
        (setq eab/first-emacsclient nil)
        (iconify-frame)
        (eab/load-personal)
        ;; (eab/load-desktop)
        (wg-change-modeline)
        (eab/create-workgroups)
        (eab/wg-switch-to-workgroup ":clock:")
        (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
        (iconify-frame)
        (execute-kbd-macro (read-kbd-macro "C-a h C-g"))
        )
    (eab/loaded-ok (concat (daemonp) " dotemacs")))
  (set-face-attribute 'default nil
                      :family "Source Code Pro"
                      :height (if (eq (display-pixel-width) 1920) 130 150)
                      :weight 'normal
                      :width 'normal))

(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'eab-minimal)
