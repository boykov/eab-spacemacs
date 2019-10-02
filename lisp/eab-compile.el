(require 'smart-compile)
(setq-default smart-compile-check-makefile nil)

(setq compile-command "make ")
(setq compilation-buffer-name-function (lambda (mode) (concat "*" (downcase mode) ": " (projectile-project-name) "*")))

(defun eab/projectile-compile-project (&optional arg)
  (interactive)
  (eab/with-git-toplevel
    (call-interactively 'projectile-compile-project)))

(defun eab/projectile-compile-project-custom (CMD)
  "Run project compilation command CMD."
  (interactive "P")
  (let* ((project-root (projectile-project-root)))
    (save-some-buffers (not compilation-ask-about-save)
                       (lambda ()
                         (projectile-project-buffer-p (current-buffer)
                                                      project-root)))
    (projectile-run-compilation CMD)))

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

(defun eab/recompile (&optional arg)
  (interactive "P")
  (let ((pos (line-at-pos))
	(point (point))
	(compilation-buffer-name-function nil))
    (if (not arg)
	(recompile)
      (recompile arg))
    (run-with-idle-timer 0.2 nil
			 `(lambda ()
			    ;; (while (< (point-max) ,point)
			    ;; 	(sleep-for 0.2))
			    (goto-line ,pos)
			    (goto-char ,point)))))

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
(add-to-list 'smart-compile-alist '(textile-mode . "make push id=%f"))
(add-to-list 'smart-compile-alist '("\\.xml\\'" . "cd ../../.. && make push id=%F"))
(add-to-list 'smart-compile-alist '("\\.jira\\'" . "make push id=%n"))
(add-to-list 'smart-compile-alist '("\\.html\\'" . "make push id=%n"))

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
  (let ((istc? truncate-lines))
    (toggle-truncate-lines t)
    (let ((buf (current-buffer))
	  (line (- (count-lines (window-start) (point))
		   (if (eq (point) (point-at-bol)) 0 1)))
	  (point (point)))
      (compile-goto-error)
      (run-with-timer 0.01 nil `(lambda ()
				 (let ((cb (current-buffer)))
				       (pop-to-buffer ,buf)
				       (recenter ,line)
				       (goto-char ,point)
				       (toggle-truncate-lines ,istc?)
				       (pop-to-buffer cb)))))))

(defun eab/compile-goto-error-same-window ()
  (interactive)
  (let ((cwc (current-window-configuration)))
    (funcall
     `(lambda ()
	(defun eab/compile-goto-error-same-window-internal ()
	  (let ((cb (current-buffer))
		(p (point)))
	    (set-window-configuration ,cwc)
	    (switch-to-buffer cb)
	    (goto-char p ))))))
  (compile-goto-error)
  (run-with-timer 0.01 nil 'eab/compile-goto-error-same-window-internal))

(provide 'eab-compile)
