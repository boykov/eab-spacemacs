;;; eab-minimal.el ---

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements: cl
;; Status: not intended to be distributed yet

(defmacro ilam (&rest body)
  "Interactive lambda"
  `(lambda ()
     (interactive)
     ,@body))

(defmacro eab/do-action (&rest body)
  ""
  `(lambda ()
     (interactive)
     (let ((executing-kbd-macro defining-kbd-macro))
       (run-with-timer 0.1 nil ,@body)
       (abort-recursive-edit))))

(defun eab/kbd-macro-query ()
  (interactive)
  (let (executing-kbd-macro defining-kbd-macro)
    (run-with-timer 0.1 nil (ilam (execute-kbd-macro (read-kbd-macro "C-g"))))
    (run-with-timer 0.2 nil (ilam (execute-kbd-macro (read-kbd-macro "M-g"))
                                  (setq kill-ring (cdr kill-ring))))
    (recursive-edit)))

(defmacro eab/add-hook (hookname funcname &rest body)
  "add-hook with lambda progn"
  (declare (indent defun))
  `(progn (add-hook ',hookname ',funcname)
          (defun ,funcname ()
            (progn ,@body))))

(defun eab/or-self-insert (command)
  (if (use-region-p)
      (call-interactively command)
    (call-interactively 'self-insert-command)))

(defmacro eab/or-self-insert-body (&rest body)
  `(if (use-region-p)
         ,@body
     (call-interactively 'self-insert-command)))

(define-advice kmacro-end-macro (:after (&rest args) fix-kmacro-input)
  (setq last-kbd-macro (cl-remove 'with-input-method last-kbd-macro)))

(defun eab/kmacro-end-or-call-macro ()
  (interactive)
  (let ((inhibit-redisplay 't))
    (call-interactively 'kmacro-end-or-call-macro)))

(defun eab/replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(defun eab/print-0 (body)
  "Insert value of body in current-buffer."
  (let ((print-length nil)
        (eval-expression-print-length nil))
    (prin1 `,body (current-buffer))))

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

(defun eab/load-personal ()
  (interactive)
  (if (fboundp 'grep-a-lot-clear-stack)
      (grep-a-lot-clear-stack))
  (winner-mode)
  (eab/bind-path eab/secrets-path)
  ;; (load-file eab/secrets-path)
  (require 'cl-macs)
  (cl-assert
   (equal (ido-completing-read-silent
           "prompt: " '("one" "two" "three" "four" "five") "t")
          '("two" "three")))
  (global-eldoc-mode 0)
  (require 'yasnippet)
  (yas-reload-all)
  (require 'org-ql-search)
  (require 'org-depend)
  (require 'org-sql)
  (require 'eab-helm)
  (eab/loaded-ok (concat (daemonp) " dotemacs"))
  )

(defun eab/load-gui ()
  (interactive)
  (when eab/first-emacsclient
    (iconify-frame)
    (disable-theme 'solarized-light)
    (eab/load-personal)
    ;; (eab/load-desktop)
    (require 'workgroups2)
    (require 'eab-workgroups2)
    (wg-change-modeline)
    (eab/create-workgroups)
    (eab/wg-switch-to-workgroup ":clock:")
    (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
    (iconify-frame)
    (execute-kbd-macro (read-kbd-macro "C-a h C-g"))
    (setq eab/first-emacsclient nil))
  (set-face-attribute 'default nil
                      :family "Source Code Pro"
                      :height (if (eq (display-pixel-width) 1680) 130 150)
                      :weight 'normal
                      :width 'normal))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'eab-minimal)
