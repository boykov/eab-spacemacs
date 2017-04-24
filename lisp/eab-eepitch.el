(require 'eev-all)
(require 'eev-browse-url)
(require 'eev-mini-steps)

(eab/bind-path eab/eeansi-path)
(eab/bind-path eab/eegchannel-path)

(defun eab/run-ansi (prog buf)
  (let ((buffer (get-buffer (concat "*" buf "*")))
	(default-directory
	  (if (file-remote-p default-directory)
	      "~/"
	    default-directory)))
    (if buffer
        (switch-to-buffer-other-window buffer)
      (ansi-term prog buf))))

(defun eepitch-ansi-term (sym)
  (interactive)
  (let ((default-directory "~/"))
    (shell-command (concat "echo \"" eab/eegchannel-path " " sym " /bin/bash\" > " eab/eeansi-path)))
  (eechannel sym)
  (save-window-excursion
    (eepitch `(eab/run-ansi eab/eeansi-path (concat "ansi-term" ,sym))))
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
	(eab/wrap-eepitch-this line)
      (ee-next-line 1))))

(provide 'eab-eepitch)
