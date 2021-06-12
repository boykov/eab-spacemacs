;;; eab-shell-utils.el --- eab shell utilities

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: async abbrev
;; Status: ready

(defvar eab/translate-path nil)

(defun eab/xmodmap-set-hyper ()
  (interactive)
  (shell-command "xmodmap -e 'keycode 135 = Hyper_R'"))

(defun eab/gconf-set-keyboard-rate ()
  (interactive)
  (shell-command "gconftool-2 --type int --set /desktop/gnome/peripherals/keyboard/rate 120"))

(defun eab/gr-tag-default-directory ()
  (interactive)
  (shell-command (concat "gr +#emacs " default-directory)))

;; CANCELLED: Add
(defun eab/dired-see-file ()
  "See file by external application with dired."
  (interactive)
  (eab/sh-over-bash "xdg-open"
		    (replace-regexp-in-string "`" "\\\\`" (dired-get-filename)) 't))

(defun eab/ido-see-file ()
  "See file by external application with ido."
  (interactive)
  (progn
    (eab/sh-over-bash "xdg-open" (concat ido-current-directory
                                         (if ido-matches
                                             (ido-name (car ido-matches))
                                           ido-text)) 't)
    (abort-recursive-edit)))

(defun eab/see-file ()
  "See current file by external application."
  (interactive)
  (progn
    (eab/sh-over-bash "xdg-open" buffer-file-name 't)
    (abort-recursive-edit)))

(defun eab/minibuffer-see-file ()
  "See current file in minibuffer by external application."
  (interactive)
  (progn
    (eab/sh-over-bash
     "xdg-open"
     (concat eab/homedir
	     (substring (minibuffer-contents)
			1 (length (minibuffer-contents)))) 't)
    (abort-recursive-edit)))

(defun eab/add-drop (name)
  (concat "http://dl.getdropbox.com/u/1897885/" name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO баг: зацикливание (много bash процессов) trying with detected language
;; пример со словом hunchentoot
;; убить можно pkill -f bash
(defun eab/shell-translate (phrase &optional not-abbrevp)
  (interactive)
  (setq eab/tmp-str
	(split-string
	 (ansi-color-filter-apply
	  (shell-command-to-string
	   (concat "export TERM=eterm-color && " eab/translate-path " " phrase)))
	 "\n"))
  (if (not not-abbrevp)
      (define-abbrev eab-abbrev-table phrase (car eab/tmp-str)))
  (message "%s" (car eab/tmp-str)))

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

(defun eab/batch-publish-remote ()
  (interactive)
  (async-start
   (lambda ()
     (require 'server)
     (server-eval-at "serverC" '(progn
				  (eab/batch-publish)
				  )))))

(defmacro eab/with-git-toplevel (&rest body)
  "Set default-directory as git superproject or toplevel."
  `(let* ((remote-prefix
	   (if (file-remote-p default-directory)
	       (file-remote-p default-directory)
	     ""))
	  (try (shell-command-to-string "git rev-parse --show-superproject-working-tree --show-toplevel | head -1"))
	  (fatal (if (and (> (length try) 10) (string= (substring try 0 5) "fatal"))
		     't
		   nil))
	  (git-toplevel (shell-command-to-string "git rev-parse --show-toplevel"))
	  (git-superproject (if fatal
			   git-toplevel
			 try))
	  (git-nothing (if (file-remote-p default-directory)
			     (file-remote-p default-directory 'localname)
			   default-directory))
	  (top-level (cond
		      ((equal arg 2)
		       (substring git-superproject 0 -1))
		      ((not arg)
		       (substring git-toplevel 0 -1))
		      ((equal arg '(4))
		       git-nothing)))
	  (default-directory
	    (concat remote-prefix top-level))
	  (projectile-cached-buffer-file-name nil))
     ,@body))

(provide 'eab-shell-utils)
