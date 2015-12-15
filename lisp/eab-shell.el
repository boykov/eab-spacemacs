;;; eab-shell.el --- 

;; Copyright (C) 2010, 2011, 2012, 2013, 2014, 2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

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
      (if async
	  (progn
	    (switch-to-buffer "*Async Shell Command*")
	    (kill-buffer))))))

(defun eab/shell-command (command &optional output-buffer error-buffer)
  "Run command by `call-process-shell-command' in separate proces: e.g. nautilus or gnome-terminals"
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

(provide 'eab-shell)
