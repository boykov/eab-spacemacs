;;; quickly-hacked window manipulation, loosely inspired by Quicksilver activate

;; TODO replace it by ewmctrl

(defvar anything-c-wmctrl-cmd "wmctrl")

(defvar anything-c-wmctrl-list-opt " -l ") ; space-padded

(defvar anything-c-splitter-regexp
  "\\([[:graph:]]+\\)[[:blank:]]+\\([[:graph:]]+\\)[[:blank:]]+\\([[:graph:]]+\\)[[:blank:]]+\\(.+\\)")

(defun anything-c-wmctrl-get-windows nil
  (split-string (shell-command-to-string
		 (concat anything-c-wmctrl-cmd
			 anything-c-wmctrl-list-opt))
		"[\n]" t))

(defun anything-c-wmctrl-wmctrl-to-id (line)
  (string-match anything-c-splitter-regexp line)
  (match-string 1 line))

(defun anything-c-wmctrl-wmctrl-to-display (line)
  (string-match anything-c-splitter-regexp x)
  (match-string 4 line))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/wmctrl-pairs ()
  (remove-if (lambda (s) (or (string= (car s) "launcher")
			     (string= (car s) "panel")
			     (string= (ignore-errors (substring (car s) 0 6)) "emacs@")
			     (string= (ignore-errors (substring (car s) 0 6)) "emacss")
			     (string= (car s) "Dash")
			     (string= (car s) "Hud")
			     (string= (car s) "Switcher")
			     (string= (car s) "DNDCollectionWindow")))
	     (mapcar (function
		      (lambda (x)
			`(,(anything-c-wmctrl-wmctrl-to-display x)
			  . ,x)))
		     (cdr (anything-c-wmctrl-get-windows)) ;; remove Рабочий стол
		     )))

(defvar eab/wmctrl-hash)

;; вот пример табличного задания логики в переменной eab/make-ext-hash
;; CANCELLED: need more good interface to list (mode-name command) instead (car ..) (cadr ..)

(defun eab/wmctrl-hash ()
  (setq eab/wmctrl-hash (make-hash-table :test 'equal))
  (mapcar
   (lambda (lst)
     (puthash (car lst) (cdr lst) eab/wmctrl-hash))
   (eab/wmctrl-pairs))
  eab/wmctrl-hash)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'eab-wmctrl)
