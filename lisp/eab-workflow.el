;;; eab-workflow.el ---  eab workflow extension

;; Copyright (C) 2010-2022 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: projectile
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
  (unless (buffer-modified-p)
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

(defmacro eab/with-git-toplevel (&rest body)
  "Set default-directory as git superproject or toplevel."
  `(let* ((remote-prefix
	   (if (file-remote-p default-directory)
	       (file-remote-p default-directory)
	     ""))
	  (check-fatal
	   (lambda (s)
	     (if (and (> (length s) 10) (string= (substring s 0 5) "fatal")) 't nil)))
	  (try-super
	   (shell-command-to-string
	    "git rev-parse --show-superproject-working-tree --show-toplevel | head -1"))
	  (fatal-super (funcall check-fatal try-super))
	  (try-toplevel
	   (shell-command-to-string
	    "git rev-parse --show-toplevel"))
	  (fatal-toplevel (funcall check-fatal try-toplevel))
	  (git-superproject (if fatal-super
				(if fatal-toplevel
				    nil
				  try-toplevel)
			      try-super))
	  (git-nothing (if (file-remote-p default-directory)
			   (file-remote-p default-directory 'localname)
			 default-directory))
	  (top-level (cond
		      ((equal arg 2)
		       (if git-superproject
			   (substring git-superproject 0 -1)
			 git-nothing))
		      ((not arg)
		       (if fatal-toplevel
			   git-nothing
			 (substring try-toplevel 0 -1)))
		      ((equal arg '(4))
		       git-nothing)))
	  (default-directory
	    (concat remote-prefix top-level))
	  (projectile-cached-buffer-file-name nil))
     ,@body))

(provide 'eab-workflow)
