;;; eab-shell.el ---  eab shell extension

;; Copyright (C) 2010-2022 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: async abbrev
;; Status: ready

(defvar eab/translate-path nil)

(defun eab/over-bash (comhead comstr)
  "Run comhead with comstr over bash -i -c."
  (concat "bash -i -c \"" comhead " '" (expand-file-name comstr) "'&\""))

(defun eab/sh-over-bash (com fname &optional async)
  "Run com with fname over bash -i -c."
  (save-window-excursion
    (let ((comstr (eab/over-bash com fname)))
      (shell-command (if async
			 (concat comstr "&")
		       comstr))
      (sleep-for 1)
      (when async
	(switch-to-buffer "*Async Shell Command*")
	(kill-buffer)))))

(defun eab/shell-command (command &optional output-buffer error-buffer)
  "Run command by `call-process-shell-command' in separate
process: e.g. nautilus or gnome-terminals"
  (interactive
   (list
    (read-shell-command "EAB Shell command: " nil nil
			(let ((filename
			       (cond
				(buffer-file-name)
				((eq major-mode 'dired-mode)
				 (dired-get-filename nil t)))))
			  (and filename (file-relative-name filename))))
    current-prefix-arg
    shell-command-default-error-buffer))
  (call-process-shell-command command nil 0))

(defun eab/call-shell-command (&optional arg)
  "Command for manual running (thru M-A): with different settings"
  (interactive "P")
  (cond ((or (if (listp arg) (eq (car arg) 4)) (eq arg 4))
	 (call-interactively 'eab/shell-command))
	((eq arg 1)
	 (let ((shell-command-switch "-ic")
	       (current-prefix-arg nil))
	     (call-interactively 'shell-command)))
	(t
	 (call-interactively 'shell-command))))

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
  (eab/sh-over-bash eab/xdg-open
		    (replace-regexp-in-string "`" "\\\\`" (dired-get-filename)) 't))

(defun eab/ido-see-file ()
  "See file by external application with ido."
  (interactive)
  (progn
    (eab/sh-over-bash eab/xdg-open (concat ido-current-directory
                                         (if ido-matches
                                             (ido-name (car ido-matches))
                                           ido-text)) 't)
    (abort-recursive-edit)))

(defun eab/see-file ()
  "See current file by external application."
  (interactive)
  (progn
    (eab/sh-over-bash eab/xdg-open buffer-file-name 't)
    (abort-recursive-edit)))

(defun eab/minibuffer-see-file ()
  "See current file in minibuffer by external application."
  (interactive)
  (progn
    (eab/sh-over-bash
     eab/xdg-open
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
  (unless not-abbrevp
    (define-abbrev eab-abbrev-table phrase (car eab/tmp-str)))
  (message "%s" (car eab/tmp-str)))

(defun eab/latinize (str)
  (substring (shell-command-to-string (concat "python " eab/trans-path " \"" str "\"")) 0 -1))

(defun eab/latinize-region (start end)
  (interactive "r")
  (let ((str (filter-buffer-substring start end)))
    (kill-region start end)
    (insert (eab/latinize str))))

;; DONE
;; xset dpms force off/on
;; gnome-screensaver-command -a

(defun eab/screen-off ()
  (interactive)
  (sleep-for 0.2)
  (eab/shell-command "xset dpms force off" nil 0)
  (suspend-frame))

(defun eab/gnome-terminal ()
  (eab/shell-command "gnome-terminal" nil 0))

(provide 'eab-shell)
