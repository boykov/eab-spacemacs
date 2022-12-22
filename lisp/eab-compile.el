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
    (if arg
	(recompile arg)
      (recompile)
      )
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
    (unless (string= cmd "")
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

(setq eab/gr-buffer "*gr status*")
(setq eab/gr-ready? nil)
(defun eab/gr-status ()
  (interactive)
  (let* ((compilation-buffer-name-function
	  `(lambda (mode) ,eab/gr-buffer)))
    (unless eab/gr-ready?
      (save-window-excursion
	(eab/compile eab/gr-command))
      (setq eab/gr-ready? 't))
    (eab/async-update-gr :recompile 't :notify 't)
    (switch-to-buffer eab/gr-buffer nil 't)))

(cl-defun eab/async-update-gr (&optional &key recompile notify)
  (async-start
   `(lambda ()
      (with-temp-buffer
	(shell-command-to-string ,eab/update-gr-command))
      "@fz updated")
   `(lambda (result)
      (if ,recompile
	  (save-window-excursion
	    (switch-to-buffer eab/gr-buffer)
	    (let ((compilation-buffer-name-function nil))
	      (recompile))))
      '(if ,notify
	  (if (> (string-to-number (shell-command-to-string eab/check-gr-command)) 6)
	      (eab/gotify "fz" "updated" 0)))
      (message "async result: <%s>" result))))

(defun eab/update-gr-status-on-idle ()
  (eab/async-update-gr :recompile 't))

(setq eab/gotify-ready? nil)
(defvar eab/gotify-websocket nil "gotify websocket")
(defun eab/gotify-status (&optional arg)
  (interactive)
  (let ((gotify-buffer "*compilation: gotify*"))
    (unless (websocket-openp eab/gotify-websocket)
      (setq eab/gotify-websocket
            (websocket-open
	     eab/gotify-ws
             :on-message `(lambda (_websocket frame)
			    (let ((text (websocket-frame-text frame)))
			      (save-window-excursion
				(switch-to-buffer ,gotify-buffer)
				(let ((compilation-buffer-name-function nil))
				  (recompile)))))
             :on-close (lambda (_websocket) (message "websocket closed")))))
    (if eab/gotify-ready?
	(switch-to-buffer gotify-buffer nil 't)
      (progn
	(let ((compilation-buffer-name-function
	       `(lambda (mode) ,gotify-buffer)))
	  (save-window-excursion
	    (eab/compile eab/gotify-command)))
	(setq eab/gotify-ready? 't)
	(switch-to-buffer gotify-buffer nil 't)))))

'((websocket-send-text eab/gotify-websocket "hello from emacs")
  (websocket-close eab/gotify-websocket)
  (websocket-openp eab/gotify-websocket)
  )

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
