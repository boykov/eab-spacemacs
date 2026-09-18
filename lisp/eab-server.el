;;; eab-server.el ---  eab server extension -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: none
;; Status: not intended to be distributed yet

'((let ((server-use-tcp 't))
    (server-eval-at "kairosP" '(symbol-function 'eab/eval-last-sexp-server-M)))
  )

(defun eab/eval-last-sexp-remote (server &optional use-tcp)
  "Evaluate sexp before point on SERVER; print value in minibuffer.
If USE-TCP is non-nil, bind `server-use-tcp' to USE-TCP.
When called interactively, USE-TCP is determined automatically for
known servers."
  (let ((sexp (call-interactively
               (lambda () (interactive) (preceding-sexp)))))
    (message "%s" (if use-tcp
                      (let ((server-use-tcp use-tcp))
                        (server-eval-at server `(eval ',sexp)))
                    (server-eval-at server `(eval ',sexp))))))

(defun eab/eval-last-sexp-kairos-C ()  (interactive) (eab/eval-last-sexp-remote "kairosC" server-C-use-tcp))
(defun eab/eval-last-sexp-kairos-P ()  (interactive) (eab/eval-last-sexp-remote "kairosP"))
(defun eab/eval-last-sexp-chronos-C () (interactive) (eab/eval-last-sexp-remote "chronosC" server-C-use-tcp))
(defun eab/eval-last-sexp-chronos-P () (interactive) (eab/eval-last-sexp-remote "chronosP"))
(defun eab/eval-last-sexp-server-M ()  (interactive) (eab/eval-last-sexp-remote "serverM"))

;; TODO обобщить формирование body и выполнение remote
(defun eab/org-publish-current-file-remote ()
  (interactive)
  (let* ((name (replace-regexp-in-string
                "git/org-chronos"
                "git/org"
                (file-truename (buffer-file-name))))
         (body `(lambda ()
                  (require 'server)
                  (let ((server-use-tcp ,server-C-use-tcp))
                    (server-eval-at
                     ,(eab/target-C)
                     '(progn
                        (shell-command (concat "cd " org-directory))
                        (eab/rsync-org-directory "cyclos:")
                        (revert-all-buffers)
                        (let ((org-publish-use-timestamps-flag nil)
                              (org-confirm-babel-evaluate nil))
                          (org-publish-file ,name))
                        (eab/update-site))))
                  )))
    (eval `(async-start
            ,body
            (lambda (result) (message "async result: <%s>" result))))))

(defun eab/shell-translate-remote (phrase)
  (interactive)
  (funcall
   `(lambda ()
      (async-start
       (lambda ()
         (require 'server)
         (let ((server-use-tcp ,server-C-use-tcp))
           (server-eval-at ,(eab/target-C)
                           '(eab/shell-translate ,phrase 't))))
       (lambda (result)
         (message "async result: <%s>" result)
         (define-abbrev eab-abbrev-table ,phrase result))))))

;; not used
(defun eab/org-publish-html ()
  (interactive)
  (org-publish-remove-all-timestamps)
  (async-start
   `(lambda ()
     (require 'server)
     (let ((server-use-tcp ,server-C-use-tcp))
       (server-eval-at ,(eab/target-C)
                       '(progn
                          (let ((org-confirm-babel-evaluate nil))
                            (org-publish-project "html-base" 't)
                            (org-publish-project "html-scale" 't)
                            (org-publish-project "html-clock" 't))))))
   (lambda (result)
     (eab/gotify "eab/org-publish-html"
                 (concat "async result: <" result ">") 0))))

(provide 'eab-server)
