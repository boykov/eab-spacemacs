(defun eab/el-get-installed ()
  "Get the list of el-get installed packages."
  (let ((packages (el-get-read-all-recipes)))
    (remove-if-not (lambda (l) (car l))
		   (mapcar (lambda (p)
			     (let* ((package-name (el-get-as-string (plist-get p :name)))
				    (package-status (el-get-read-package-status package-name)))
			       (if (string= package-status "installed")
				   (list package-name )))) packages))))

(defun eab/el-get-installed ()
  "Get the list of el-get installed packages."
  (mapcar 'intern
	  (el-get-list-package-names-with-status "installed")))

(defun eab/package-installed ()
  "Get the list of installed ELPA packages."
  (mapcar (lambda (x) (car x)) package-alist))

(defun custom-set-difference (a b)
  (remove-if
   (lambda (x) (and (member x a) (member x b)))
   (append a b)))

(defun eab/print-el-get-installed ()
  (insert "(setq eab/el-get-sources \n'")
  (funcall '(lambda () (eab/print-0 (eab/el-get-installed))))
  (eab/indent-list-packages))

(defun eab/print-package-installed ()
  (insert "(setq eab/package-sources \n'")
  (funcall '(lambda () (eab/print-0 (eab/package-installed))))
  (eab/indent-list-packages))

(defun eab/indent-list-packages ()
  (backward-sexp)
  (execute-kbd-macro
   (read-kbd-macro
    "M-l M-l RET M-SPC M-p M-5 SPC RET C-q LFD RET ! M-p ) M-SPC M-n"))
  (call-interactively 'indent-region))

(defun eab/print-installed ()
  (interactive)
  (eab/print-package-installed)
  (newline)
  (newline)
  (previous-line)
  (previous-line)
  (eab/print-el-get-installed))


(provide 'eab-packages)
