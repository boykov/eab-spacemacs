;;; eab-server.el ---  eab server extension

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: none
;; Status: not intended to be distributed yet

(defun eab/eval-last-sexp-serverM ()
  "Evaluate sexp before point on serverM; print value in minibuffer."
  (interactive)
  (let ((sexp (call-interactively (lambda () (interactive) (preceding-sexp)))))
    (server-eval-at "serverM"
		    `(eval ',sexp))))

(defun eab/eval-last-sexp-serverC ()
  "Evaluate sexp before point on serverC; print value in minibuffer."
  (interactive)
  (let ((sexp (call-interactively (lambda () (interactive) (preceding-sexp)))))
    (server-eval-at "serverC"
		    `(eval ',sexp))))

;; TODO обобщить формирование body и выполнение remote
(defun eab/org-publish-current-file-remote ()
  (interactive)
  (let* ((name (buffer-file-name))
	 (body `(lambda ()
		  (require 'server)
		  (server-eval-at "serverC" '(progn
					       (shell-command "cd /home/eab/git/org && git pull")
					       (auto-revert-buffers)
					       (org-publish-file ,name)))
		  )))
    (eval `(async-start
	       ,body
	     (lambda (result) (message "async result: <%s>" result))))))

(defun eab/batch-publish-remote ()
  (interactive)
  (async-start
   (lambda ()
     (require 'server)
     (server-eval-at "serverC" '(progn
				  (eab/batch-publish)
				  )))))

(defun eab/shell-translate-remote (phrase)
  (interactive)
  (funcall `(lambda ()
	      (async-start
	       (lambda ()
		 (require 'server)
		 (server-eval-at "serverC" '(eab/shell-translate ,phrase 't)))
	       (lambda (result)
		 (message "async result: <%s>" result)
		 (define-abbrev eab-abbrev-table ,phrase result))))))

(defun eab/org-publish-html ()
  (interactive)
  (org-publish-remove-all-timestamps)
  (async-start
   (lambda ()
     (require 'server)
     (server-eval-at "serverC" '(progn
				  (org-publish-project "html" 't)
				  (org-publish-project "html-clock" 't))))
   (lambda (result) (sauron-add-event 'eab 3 (concat "async result: <" result ">")))))

(provide 'eab-server)
