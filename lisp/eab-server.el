(defun eab/eval-last-sexp-serverM ()
  "Evaluate sexp before point on serverN; print value in minibuffer."
  (interactive)
  (let ((sexp (call-interactively (lambda () (interactive) (preceding-sexp)))))
    (server-eval-at "serverM"
		    `(eval ',sexp))))

(defun eab/eval-last-sexp-serverN ()
  "Evaluate sexp before point on serverN; print value in minibuffer."
  (interactive)
  (let ((sexp (call-interactively (lambda () (interactive) (preceding-sexp)))))
    (server-eval-at "serverN"
		    `(eval ',sexp))))

;; TODO обобщить формирование body и выполнение remote
(defun eab/org-publish-current-file-remote ()
  (interactive)
  (let* ((name (buffer-file-name))
	 (body `(progn
		  (require 'server)
		  (server-eval-at "serverN" '(progn
					       (auto-revert-buffers)
					       (org-publish-file ,name)))
		  )))
    (eval `(async-eval
	       (lambda (result) (message "async result: <%s>" result))
	     ,body))))

(defun eab/org-publish-html ()
  (interactive)
  (org-publish-remove-all-timestamps)
  (async-eval
      (lambda (result) (message "async result: <%s>" result))
    (progn
      (require 'server)
      (server-eval-at "serverN" '(progn
				   (org-publish-project "html" 't)
				   (org-publish-project "html-clock" 't))))))

(provide 'eab-server)
