;;; eab-eepitch.el ---  eab eev extension

;; Copyright (C) 2010-2025 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: eev vterm
;; Status: not intended to be distributed yet

(require 'eev-all)
(require 'eev-browse-url)
(require 'eev-mini-steps)

(defvar eab/run-ansi-kind "eat" "Choose eat/ansi")

(defun eab/run-tmux (sym)
  (let ((default-directory "/ssh:kairos-host:/home/eab/"))
    (shell-command (concat "tmux select-window -t 13:" sym))))

(defun eab/run-ansi (kind prog sym)
  (let* ((buf (concat "ansi-term" sym))
         (buffer (get-buffer (concat "*" buf "*")))
         (default-directory
           (if (file-remote-p default-directory)
               "~/"
             default-directory)))
    (if buffer
        (switch-to-buffer-other-window buffer)
      (progn
        (if (string= kind "ansi")
            (ansi-term prog buf))
        (if (string= kind "eat")
            (eat prog (string-to-number sym)))))))

(defun eepitch-ansi-term (sym)
  (interactive)
  (let ((default-directory "~/"))
    (shell-command (concat "echo \"" eab/eegchannel-path " " sym " /bin/bash\" > " eab/eeansi-path)))
  (eechannel sym)
  (save-window-excursion
    (eepitch `(eab/run-ansi eab/run-ansi-kind eab/eeansi-path ,sym))
    (setq eepitch-target-buffer (get-buffer (concat "*ansi-term" sym "*"))))
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

(defun eab/wrap-eepitch-this (region)
  (interactive)
  (if (eab/in-target-buffer? "ansi")
      (eechannel-send nil region)
    (error "There isn't target buffer")))

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
         (line (concat (car prepare) "\n")))
    (if (cadr prepare)
        (eab/wrap-eepitch-this line))
    (ee-next-line 1)))

(defun eab/eepitch-paragraph ()
  (interactive)
  (flet ((forward ()
                  (search-forward-regexp "^ *$"))
         (backward ()
                   (backward-char)
                   (search-backward-regexp "^ *$")))
    (let ((region
           (save-excursion
             (forward)
             (let ((st (point)))
               (backward)
               (let ((en (point)))
                 (ee-se-to-string st en))))))
      (eab/eepitch-buffer-end)
      (eechannel-send nil region)
      (forward)
      (if (eq major-mode 'python-mode)
          (eab/eepitch-this-line)))))

(provide 'eab-eepitch)
