;;; eab-window.el ---  eab window extension

;; Copyright (C) 2010-2024 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: projectile grep-a-lot
;; Status: ready

(defun window-search ()
  "Interactive search, limited to the visible portion of the buffer."
  (interactive)
  (save-restriction
    (narrow-to-region (window-start) (window-end))
    (isearch-forward)))

(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))

(defun esc-toggle-window-selectability ()
  "Ignore/recognize a window from `other-window'."
  (interactive)
  (if (window-parameter (selected-window) 'no-other-window)
      (progn
        (set-window-parameter (selected-window) 'no-other-window nil)
        (message "Window will now be recognized by `other-window'"))
    (set-window-parameter (selected-window) 'no-other-window t)
    (message "Window will now be ignored by `other-window'")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           ____          _ _       _
;;          / ___|_      _(_) |_ ___| |__
;;          \___ \ \ /\ / / | __/ __| '_ \
;;           ___) \ V  V /| | || (__| | | |
;;          |____/ \_/\_/ |_|\__\___|_| |_|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Switch

(defun eab/switch-window (name)
  (when (= (length (window-list)) 1)
    (split-window-right))
  (switch-to-buffer-other-window name))

(defun eab/magit-status ()
  (interactive)
  (when (= (length (window-list)) 1)
    (split-window-right))
  (magit-status))

(defun eab/switch-async () (interactive) (eab/switch-window "*Async Shell Command*"))
(defun eab/switch-shell () (interactive) (eab/switch-window "*Shell Command Output*"))
(defun eab/switch-message () (interactive) (eab/switch-window "*Messages*"))
(defun eab/switch-help () (interactive) (eab/switch-window "*Help*"))
(defun eab/switch-compile (&optional arg)
  (interactive)
  (eab/with-git-toplevel
   (eab/switch-window (concat "*compilation*<" (projectile-project-name) ">")))
  (unless (eq major-mode 'compilation-mode)
    (compilation-mode)))

(defun eab/switch-grep ()
  (interactive)
  (grep-a-lot-set-current-buffer (grep-a-lot-last-buffer))
  (eab/switch-window (grep-a-lot-last-buffer)))

(defun eab/kill-last-grep ()
  (interactive)
  (kill-buffer (grep-a-lot-last-buffer)))

(defun eab/switch-grep-next ()
  (interactive)
  (switch-to-buffer (grep-a-lot-next-buffer) nil 't)
  (grep-a-lot-set-current-buffer))

(defun eab/switch-grep-prev (arg)
  (interactive "P")
  (let ((buf (grep-a-lot-prev-buffer)))
    (if arg (kill-buffer))
    (switch-to-buffer buf nil 't))
  (grep-a-lot-set-current-buffer))

(defun eab/switch-or-clone-indirect-buffer ()
  (interactive)
  (let* ((basename (buffer-name))
         (newname
          (if (string-match "<[0-9]+>\\'" basename)
              (substring basename 0 (match-beginning 0))
            basename))
         (name (generate-new-buffer-name newname)))
    (if (eq (clone-a-lot-next-buffer) (get-buffer newname))
        (call-interactively 'eab/wg-clone-indirect-buffer)
      (call-interactively 'clone-a-lot-goto-next))))

(defun eab/switch-eepitch-target ()
  (interactive)
  (switch-to-buffer-other-window eepitch-target-buffer))

;;;;;;;;;;;;;;;;;

(defun clone-a-lot-buffer-p (&optional buffer)
  "Return non-nil if BUFFER is a clone-a-lot search result buffer.
The buffer name must match `clone-a-lot-buffer-name-regexp'.
With no argument or nil as argument, check current buffer."
  (let ((name (buffer-name buffer)))
    (if (or (string-match (concat (buffer-name (buffer-base-buffer (current-buffer))) "<[0-9]+>\\'") name)
            (string-match (buffer-name (buffer-base-buffer (current-buffer))) name))
        (get-buffer name)
      nil)))

(defun clone-a-lot-buffers (&optional reverse)
  "Return a sorted list of clone-a-lot search result buffers.
With REVERSE non-nil the sort order is reversed."
  (let* ((buffers nil)
         (all-buffers (buffer-list)))
    ;; filter out non clone-a-lot buffers
    (while all-buffers
      (let ((buffer (car all-buffers)))
        (if (clone-a-lot-buffer-p buffer)
            (setq buffers (append buffers (list buffer))))
        (setq all-buffers (cdr all-buffers))))
    (sort buffers (lambda (a b)
                    (let ((pos-a (buffer-name a))
                          (pos-b (buffer-name b)))
                      (if reverse
                          (string< pos-b pos-a)
                        (string< pos-a pos-b)))))))

(defun clone-a-lot-next-buffer (&optional reverse)
  "Return next clone-a-lot buffer.
When REVERSE is non-nil, return previous buffer.
If current buffer is last then return first buffer.
Returns nil if there is no clone-a-lot buffer to select."
  (let* ((buffers (clone-a-lot-buffers reverse))
         (current (current-buffer))
         (head (car buffers))
         (next (car (cdr (member current buffers)))))
    (and current (or next head))))

(defun clone-a-lot-prev-buffer ()
  "Return next clone-a-lot buffer.
Actually calls `clone-a-lot-next-buffer'."
  (clone-a-lot-next-buffer 't))

(defun clone-a-lot-goto-prev (arg)
  "Goto previous search results buffer."
  (interactive "P")
  (let ((buf (clone-a-lot-prev-buffer)))
    (if arg (kill-buffer))
    (switch-to-buffer-other-window buf)))

(defun clone-a-lot-goto-next (arg)
  "Goto next search results buffer."
  (interactive "P")
  (let ((buf (clone-a-lot-next-buffer)))
    (if arg (kill-buffer))
    (switch-to-buffer-other-window buf)))

;;;;;;;;;;;;;;;;;

(defconst compilation-a-lot-buffer-name-regexp "^\\*compilation*<\\(.+\\)>$"
  "Buffer name regular expression for extracting `projectile-project-name' name.")

(defun compilation-a-lot-buffer-p (&optional buffer)
  "Return non-nil if BUFFER is a compilation-a-lot search result buffer.
The buffer name must match `compilation-a-lot-buffer-name-regexp'.
With no argument or nil as argument, check current buffer."
  (let ((name (buffer-name buffer)))
    (if (string-match compilation-a-lot-buffer-name-regexp name)
        (get-buffer name)
      nil)))

(defun compilation-a-lot-buffers (&optional reverse)
  "Return a sorted list of compilation-a-lot search result buffers.
With REVERSE non-nil the sort order is reversed."
  (let* ((buffers nil)
         (all-buffers (buffer-list)))
    ;; filter out non compilation-a-lot buffers
    (while all-buffers
      (let ((buffer (car all-buffers)))
        (if (compilation-a-lot-buffer-p buffer)
            (setq buffers (append buffers (list buffer))))
        (setq all-buffers (cdr all-buffers))))
    (sort buffers (lambda (a b)
                    (let ((pos-a (buffer-name a))
                          (pos-b (buffer-name b)))
                      (if reverse
                          (string< pos-b pos-a)
                        (string< pos-a pos-b)))))))

(defun compilation-a-lot-next-buffer (&optional reverse)
  "Return next compilation-a-lot buffer.
When REVERSE is non-nil, return previous buffer.
If current buffer is last then return first buffer.
Returns nil if there is no compilation-a-lot buffer to select."
  (let* ((buffers (compilation-a-lot-buffers reverse))
         (current (current-buffer))
         (head (car buffers))
         (next (car (cdr (member current buffers)))))
    (and current (or next head))))

(defun compilation-a-lot-prev-buffer ()
  "Return next compilation-a-lot buffer.
Actually calls `compilation-a-lot-next-buffer'."
  (compilation-a-lot-next-buffer 't))

(defun compilation-a-lot-goto-prev (arg)
  "Goto previous search results buffer."
  (interactive "P")
  (let ((buf (compilation-a-lot-prev-buffer)))
    (if arg (kill-buffer))
    (switch-to-buffer buf nil 't)))

(defun compilation-a-lot-goto-next (arg)
  "Goto next search results buffer."
  (interactive "P")
  (let ((buf (compilation-a-lot-next-buffer)))
    (if arg (kill-buffer))
    (switch-to-buffer buf nil 't)))

(provide 'eab-window)
