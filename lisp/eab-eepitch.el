;;; eab-eepitch.el ---  eab eev extension

;; Copyright (C) 2010-2022 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: eev vterm
;; Status: not intended to be distributed yet

(require 'eev-all)
(require 'eev-browse-url)
(require 'eev-mini-steps)

(defun eab/run-tmux (sym)
  (let ((default-directory "/ssh:kairos-host:/home/eab/"))
    (shell-command (concat "tmux select-window -t 13:" sym))))

(defun eab/run-ansi (prog buf)
  (let ((buffer (get-buffer (concat "*" buf "*")))
	(default-directory
	  (if (file-remote-p default-directory)
	      "~/"
	    default-directory)))
    (if buffer
        (switch-to-buffer-other-window buffer)
      (ansi-term prog buf))))

(defun eab/run-vterm (prog buf)
  (let ((buffer (get-buffer (concat "*" buf "*")))
	(default-directory
	  (if (file-remote-p default-directory)
	      "~/"
	    default-directory)))
    (if buffer
        (switch-to-buffer-other-window buffer)
      (vterm (concat "*" buf "*")))))

(defun eepitch-ansi-term (sym)
  (interactive)
  (let ((default-directory "~/"))
    (shell-command (concat "echo \"" eab/eegchannel-path " " sym " /bin/bash\" > " eab/eeansi-path)))
  (eechannel sym)
  (save-window-excursion
    (eepitch `(eab/run-ansi eab/eeansi-path (concat "ansi-term" ,sym))))
  (switch-to-buffer-other-window (concat "*ansi-term" sym "*")))

(defun eepitch-vterm-term (sym)
  (interactive)
  (let ((default-directory "~/"))
    (shell-command (concat "echo \"" eab/eegchannel-path " " sym " /bin/bash\" > " eab/eeansi-path)))
  (eechannel sym)
  (save-window-excursion
    (eepitch `(eab/run-vterm eab/eeansi-path (concat "ansi-term" ,sym))))
  (switch-to-buffer-other-window (concat "*ansi-term" sym "*")))

(defun eab/in-target-buffer? (str)
  (if (<= (+ (length str) 1) (length (buffer-name eepitch-target-buffer)))
      (string= (substring (buffer-name eepitch-target-buffer) 0 (+ (length str) 1))
               (concat "*" str))))

(defun eab/ansi-prepare (line)
  (if (or (string-match "^$ " line)
          (string-match "^~$ " line))
      (list (substring line 2) 't)
    (list line 't)))

(defun eab/this-line (line)
  (cond
   ((eab/in-target-buffer? "ansi")
    (eab/ansi-prepare line))
   (t (list line 't))))

(defun eab/wrap-eepitch-this (line)
  (interactive)
  (if (eab/in-target-buffer? "ansi")
      (eechannel-send nil (concat line "\n"))
    (progn
      (eepitch-prepare-target-buffer)	; for other lines reconstruct the
      (eepitch-display-target-buffer)	; target buffer, display it, make
      (eepitch-not-this-buffer)  ; sure it's a different buffer, and
      (eepitch-line line))))	   ; pitch the line to the target.

(defun eab/eepitch-buffer-end ()
  (save-window-excursion
    (let ((cur (current-buffer)))
      (switch-to-buffer-other-window eepitch-target-buffer)
      (goto-char (point-max))
      (switch-to-buffer-other-window cur))))

(defun eab/eepitch-this-line ()
  (interactive)
  (eab/eepitch-buffer-end)
  (let* ((prepare (eab/this-line (buffer-substring (ee-bol) (ee-eol))))
         (line (car prepare)))
    (if (cadr prepare)
	(eab/wrap-eepitch-this line))
      (ee-next-line 1)))

(defun eab/shell-execute-region (start end)
  (interactive "r")
  (save-excursion
    (goto-char start)
    (beginning-of-line)
    ;; Пропустить пустую строку.
    (while (and (looking-at "\\s *$")
                (< (point) end))
      (forward-line 1))
    (setq start (point))
    (or (< start end)
        (error "Region is empty"))
    (let ((cur (current-buffer)))
      (save-window-excursion
	(switch-to-buffer eepitch-target-buffer)
	(let* ((name-1 (concat default-directory "my.region"))
	       (name (if (file-remote-p name-1)
			 (file-remote-p name-1 'localname)
		       name-1)))
	  (switch-to-buffer name-1)
	  (insert-buffer-substring cur start end)
	  (insert (concat "\nrm " name))
	  (write-file name-1)
	  (kill-buffer)
	  (let ((line (concat "bash " name))) ; contents of this line
	    (eab/wrap-eepitch-this line)))))))

(defun eab/eepitch-paragraph ()
  (interactive)
  (backward-paragraph)
  (let ((st (point)))
    (forward-paragraph)
    (let ((en (point)))
      (eab/shell-execute-region st en))))

(provide 'eab-eepitch)
