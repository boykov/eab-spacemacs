;;; eab-minimal.el ---

;; Copyright (C) 2010-2020 Evgeny Boykov
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

(defmacro eab/do-action (&rest body)
  ""
  `(lambda ()
     (interactive)
     (let ((executing-kbd-macro defining-kbd-macro))
       (run-with-timer 0.1 nil ,@body)
       (abort-recursive-edit))))

(defun eab/kbd-macro-query ()
  (interactive)
  (let (executing-kbd-macro defining-kbd-macro)
    (run-with-timer 0.1 nil (ilam (execute-kbd-macro (read-kbd-macro "C-g"))))
    (run-with-timer 0.2 nil (ilam (execute-kbd-macro (read-kbd-macro "M-g"))
				  (setq kill-ring (cdr kill-ring))))
    (recursive-edit)))

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
