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
;;	     ____      	   _ _ 	     _
;;	    / ___|_    	 _(_) |_ ___| |__
;;	    \___ \ \ /\	/ / | __/ __| '_ \
;;	     ___) \ V  V /| | || (__| |	| |
;;	    |____/ \_/\_/ |_|\__\___|_|	|_|
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Switch

(defun eab/switch-window (name)
  (switch-to-buffer-other-window name))

(defun eab/switch-async () (interactive) (eab/switch-window "*Async Shell Command*"))
(defun eab/switch-message () (interactive) (eab/switch-window "*Messages*"))
(defun eab/switch-compile () (interactive) (eab/switch-window (concat "*compilation: " (projectile-project-name) "*")))
(defun eab/switch-help () (interactive) (eab/switch-window "*Help*"))

(defun eab/switch-grep ()
  (interactive)
  (grep-a-lot-set-current-buffer (grep-a-lot-last-buffer))
  (eab/switch-window (grep-a-lot-last-buffer)))

(defun eab/switch-grep-next ()
  (interactive)
  (switch-to-buffer (grep-a-lot-next-buffer) nil 't)
  (grep-a-lot-set-current-buffer))

(defun eab/switch-grep-prev (arg)
  (interactive "P")
  (if arg (kill-buffer))
  (switch-to-buffer (grep-a-lot-prev-buffer) nil 't)
  (grep-a-lot-set-current-buffer))

(defun eab/switch-eepitch-target ()
  (interactive)
  (switch-to-buffer-other-window eepitch-target-buffer))

(provide 'eab-window)
