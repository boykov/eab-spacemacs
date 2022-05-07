;;; eab-compile.el --- eab compile extension

;; Copyright (C) 2010-2022 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: projectile helm
;; Status: ready

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
    (setq-local compilation-finish-functions
		`((lambda
		    (buffer msg)
		    (switch-to-buffer buffer)
		    (goto-line ,pos)
		    (goto-char ,point))))))

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

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
;; (add-hook 'compilation-mode-hook 'rename-uniquely)

(defun eab/gr-status ()
  (interactive)
  (let ((compilation-buffer-name-function
	 (lambda (mode) (concat "*" "gr status" "*"))))
    (eab/compile (concat "ssh chronos docker exec eab-gr gr status "))))

(defun eab/gotify-status ()
  (interactive)
  (let ((compilation-buffer-name-function
	 (lambda (mode) (concat "*" "compilation: gotify" "*"))))
    (eab/compile (concat "ssh chronos 'sqlite3 -column /var/gotify/data/gotify.db \"select datetime(date,\\\"localtime\\\"),title,message from messages order by date desc limit 10;\"'"))))

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

;; - TODO это closure, let over lambda? зачем здесь funcall? похоже, чтобы сразу выполнить lambda
;; - а почему тогда не использовать просто defun? ясно, отложенные вычисления
;; - оператор compile-goto-error разрывает контекст: cwc нужен в одном
;;   окне, а после мы уже находимся в другом
;; - как обойтись без глоабльной функции ? можно compile-goto-error внутри let?

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
