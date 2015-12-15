(require 'smart-compile)

(setq compile-command "make ")
(setq compilation-buffer-name-function (lambda (mode) (concat "*" (downcase mode) ": " (projectile-project-name) "*")))

;; TODO This variable may be risky if used as a file-local variable.
(defun eab/toggle-recompile-on-save ()
  (interactive)
  (if (member 'recompile after-save-hook)
      (progn
	(setq after-save-hook
	      (remove 'recompile after-save-hook))
	(message "No longer recompiling after saving."))
    (progn
      (add-to-list 'after-save-hook 'recompile)
      (message "Recompiling after saving."))))

(defun eab/compile (&optional cmd)
  (interactive)
  (compile cmd)
  (setq compile-command "make "))

(defun eab/compile-helm ()
  (interactive)
  (let ((cmd
	 (with-temp-buffer
	   (let ((minibuffer-history-variable 'compile-history))
	     (helm-minibuffer-history))
	   (buffer-substring (point-min) (point-max)))))
    (if (not (string= cmd ""))
	(compile cmd))))

(add-to-list 'smart-compile-alist '(graphviz-dot-mode . "xdot.py %F"))
(add-to-list 'smart-compile-alist '(python-mode . "python %F"))

;; Helper for compilation. Close the compilation window if
;; there was no error at all.
(defun compilation-exit-autoclose (status code msg)
  ;; If M-x compile exists with a 0
  (when (and (eq status 'exit) (zerop code))
    ;; then bury the *compilation* buffer, so that C-x b doesn't go there
    (bury-buffer)
    ;; (quit-window nil (get-buffer-window (get-buffer "*compilation*")))
    ;; and delete the *compilation* window
    (replace-buffer-in-windows "*compilation*"))
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))

;; Specify my function (maybe I should have done a lambda function)
(setq compilation-exit-message-function 'compilation-exit-autoclose)
(setq compilation-exit-message-function nil)
(setq compilation-scroll-output 't)

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
;; (add-hook 'compilation-mode-hook 'rename-uniquely)

(defun eab/gr-status ()
  (interactive)
  (let ((compilation-buffer-name-function
	 (lambda (mode) (concat "*" "gr status" "*"))))
    (eab/compile (concat "gr status "))))

(defun eab/compile-goto-error ()
  (interactive)
  (let ((cwc (current-window-configuration)))
    (funcall
     `(lambda ()
	(defun eab/compile-goto-error-internal ()
	  (let ((cb (current-buffer))
		(p (point)))
	    (set-window-configuration ,cwc)
	    (switch-to-buffer cb)
	    (goto-char p ))))))
  (compile-goto-error)
  (run-with-timer 0 nil 'eab/compile-goto-error-internal))

(provide 'eab-compile)
