;;; eab-minimal.el ---

;; Copyright (C) 2010-2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements: cl
;; Status: not intended to be distributed yet

(require 'cl)

(defmacro ilam (&rest body)
  "Interactive lambda"
  `(lambda ()
     (interactive)
     ,@body))

(defmacro eab/add-hook (hookname funcname &rest body)
  "add-hook with lambda progn"
  (declare (indent defun))
  `(progn (add-hook ',hookname ',funcname)
	  (defun ,funcname ()
	    (progn ,@body))))

(defun eab/or-self-insert (command)
  (if (use-region-p)
      (call-interactively command)
    (call-interactively 'self-insert-command)))

(defmacro eab/or-self-insert-body (&rest body)
  `(if (use-region-p)
	 ,@body
     (call-interactively 'self-insert-command)))

;; TODO сделать eab-kbd независимым от моих символов
;; использовать какой-то вид переназначения?

(setq eab/replace-command (make-hash-table :test 'equal))

;; TODO опять таки плохо, некоторые системы учитывают предыдущую
;; команду, а в данном случае это будет (ilam (rcmd 'some-name))
(defun rcmd (cmd)
  (interactive)
  (let ((new-cmd (gethash cmd eab/replace-command)))
    (if (fboundp new-cmd)
	(call-interactively new-cmd)
      (call-interactively cmd))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'eab-minimal)
