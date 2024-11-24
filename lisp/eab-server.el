;;; eab-server.el ---  eab server extension

;; Copyright (C) 2010-2024 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: none
;; Status: not intended to be distributed yet

(defun eab/eval-last-sexp-server-M ()
  "Evaluate sexp before point on serverM; print value in minibuffer."
  (interactive)
  (let ((sexp (call-interactively (lambda () (interactive) (preceding-sexp)))))
    (message "%s" (server-eval-at "serverM"
                                  `(eval ',sexp)))))

'((let ((server-use-tcp 't))
    (server-eval-at "serverP" '(symbol-function 'eab/eval-last-sexp-server-M)))
  )

(defun eab/eval-last-sexp-server-P ()
  "Evaluate sexp before point on serverM; print value in minibuffer."
  (interactive)
  (let ((sexp (call-interactively (lambda () (interactive) (preceding-sexp)))))
    (message "%s" (let ((server-use-tcp 't))
                    (server-eval-at "serverP"
                                    `(eval ',sexp))))))

(defun eab/eval-last-sexp-chronos-C ()
  "Evaluate sexp before point on server-C; print value in minibuffer."
  (interactive)
  (let ((sexp (call-interactively (lambda () (interactive) (preceding-sexp)))))
    (let ((server-use-tcp server-C-use-tcp))
      (message "%s" (server-eval-at "chronosC"
                                    `(eval ',sexp))))))

(defun eab/eval-last-sexp-kairos-C ()
  "Evaluate sexp before point on server-C; print value in minibuffer."
  (interactive)
  (let ((sexp (call-interactively (lambda () (interactive) (preceding-sexp)))))
    (let ((server-use-tcp server-C-use-tcp))
      (message "%s" (server-eval-at "kairosC"
                                    `(eval ',sexp))))))

;; TODO обобщить формирование body и выполнение remote
(defun eab/org-publish-current-file-remote ()
  (interactive)
  (let* ((name (replace-regexp-in-string "git/org-chronos" "git/org" (file-truename (buffer-file-name))))
         (body `(lambda ()
                  (require 'server)
                  (let ((server-use-tcp ,server-C-use-tcp))
                    (server-eval-at ,(eab/target-C) '(progn
                                                       (shell-command (concat "cd " org-directory))
                                                       (let ((eab/ssh-host "ssh -o ConnectTimeout=10 chronos"))
                                                         (eab/rsync-org-directory))
                                                       (revert-all-buffers)
                                                       (let ((org-publish-use-timestamps-flag nil))
                                                         (org-publish-file ,name))
                                                       (eab/update-site))))
                  )))
    (eval `(async-start
               ,body
             (lambda (result) (message "async result: <%s>" result))))))

(defun eab/shell-translate-remote (phrase)
  (interactive)
  (funcall `(lambda ()
              (async-start
               (lambda ()
                 (require 'server)
                 (let ((server-use-tcp ,server-C-use-tcp))
                   (server-eval-at ,(eab/target-C) '(eab/shell-translate ,phrase 't))))
               (lambda (result)
                 (message "async result: <%s>" result)
                 (define-abbrev eab-abbrev-table ,phrase result))))))

;; not used
(defun eab/org-publish-html ()
  (interactive)
  (org-publish-remove-all-timestamps)
  (async-start
   (lambda ()
     (require 'server)
     (let ((server-use-tcp ,server-C-use-tcp))
       (server-eval-at ,(eab/target-C) '(progn
                                          (org-publish-project "html-base" 't)
                                          (org-publish-project "html-scale" 't)
                                          (org-publish-project "html-clock" 't)))))
   (lambda (result) (eab/gotify "eab/org-publish-html" (concat "async result: <" result ">") 0))))

(provide 'eab-server)
