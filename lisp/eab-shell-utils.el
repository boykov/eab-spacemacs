;;; eab-shell-utils.el --- 

;; Copyright (C) 2010, 2011, 2012, 2013, 2014, 2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: async-eval abbrev
;; Status: not intended to be distributed yet

;; (shell-command "xmodmap -e 'keycode 135 = Hyper_R'")
;; (shell-command "xmodmap -e 'keycode 95 = Hyper_R'")

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

(defun eab/maximize-window ()
  "Maximize active window"
  (interactive)
  (eab/shell-command "wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz"))

(defun eab/ido-firefox ()
  "Switch to firefox"
  (interactive)
  (eab/shell-command "wmctrl -a \"Firefox\""))

(defun eab/ido-servern ()
  "Switch to emacsserverN@"
  (interactive)
  (eab/shell-command "wmctrl -a \"emacsserverN\""))

(defun eab/ido-serverp ()
  "Switch to emacsserverP@"
  (interactive)
  (eab/shell-command "wmctrl -a \"emacsserverP\""))

(defun eab/ido-emacs ()
  "Switch to emacs@"
  (interactive)
  (eab/shell-command "wmctrl -a \"emacs@\""))

(defun eab/mcb (arg)
  (interactive "P")
  (if (and (fboundp 'eab/ondaemon) (eab/ondaemon "server"))
      (if (eq (call-process-shell-command "wmctrl -l | grep emacsserverP") 0)
	  (eab/ido-serverp)))
  (if arg
      (if (eq (call-process-shell-command "wmctrl -l | grep emacsserverN") 0)
	  (eab/ido-servern)
	(eab/ido-firefox))
    ;; (if (stringp (daemonp))
    ;; 	(eab/ido-firefox)
    ;;   )
    (eab/ido-firefox)
    ))

(eab/bind-path eab/translate-path)

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
	      (async-eval
		  (lambda (result)
		    (message "async result: <%s>" result)
		    (define-abbrev eab-abbrev-table ,phrase result))
		(progn
		  (require 'server)
		  (server-eval-at "serverN" '(eab/shell-translate ,phrase 't)))))))

(provide 'eab-shell-utils)
