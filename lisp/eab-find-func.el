;;; eab-find-func.el ---  eab find-function extension

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: none
;; Status: ready

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

(provide 'eab-find-func)
