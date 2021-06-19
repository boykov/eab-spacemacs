;;; eab-workflow.el ---  eab workflow extension

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements:
;; Status: ready

(defvar eab/revert-buffer "u")

(defun eab/unbound-var ()
  (interactive)
  (let ((sym (symbol-at-point)))
    (setq eab/unbound-var-temp (list sym (symbol-value sym)))
    (makunbound sym)))

(defun eab/unbound-fun ()
  (interactive)
  (let ((sym (symbol-at-point)))
    (setq eab/unbound-fun-temp (list sym (symbol-function sym)))
    (fmakunbound sym)))

(defun eab/find-function-at-point ()
  (interactive)
  (let ((function (symbol-at-point)))
    (if (fboundp function)
	(find-function-do-it function nil 'switch-to-buffer))))

(defun eab/find-variable-at-point ()
  (interactive)
  (let ((variable (symbol-at-point)))
    (if (boundp variable)
	(find-function-do-it variable 'defvar 'switch-to-buffer))))

;; a la symbol-to-string, string-to-symbol:
;;      symbol-name,      intern
;; intern и read связаны с obarray
(defun eab/describe-key-find (&optional key)
  (interactive)
  (find-function-do-it
   (intern (car (last (split-string (command-execute 'describe-key-briefly) " "))))
   nil
   'switch-to-buffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/revert-buffer ()
  (interactive)
  (if (not (buffer-modified-p))
      (cond ((string= eab/revert-buffer "u")
             (progn
	       (let ((revert-without-query (list (buffer-file-name))))
		 (revert-buffer-with-coding-system 'cp1251))
	       (setq eab/revert-buffer "w")))
            ((string= eab/revert-buffer "w")
             (progn (let ((revert-without-query (list (buffer-file-name))))
		      (revert-buffer-with-coding-system 'utf-8))
                    (setq eab/revert-buffer "d")))
            ((string= eab/revert-buffer "d")
             (progn (let ((revert-without-query (list (buffer-file-name))))
		      (revert-buffer-with-coding-system 'cp866))
                    (setq eab/revert-buffer "u"))))))

(defun eab/fix-windows-coding ()
  (interactive)
  (shell-command (concat "sed -i 's/\r$//g' " (buffer-file-name)))
  (revert-buffer 't 't))


(provide 'eab-workflow)
