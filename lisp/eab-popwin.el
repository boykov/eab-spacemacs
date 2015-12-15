(require 'popwin)
(popwin-mode 1)

(generate-new-buffer "special-buffer")

(setq eab/special-buffer-displaedp nil)
(setq eab/special-buffer "special-buffer")

(setq popwin:special-display-config nil)
(add-to-list 'popwin:special-display-config
	     `(,eab/special-buffer :width 20 :position left :stick t))

;; see also toggle-window-dedicated
(defun eab/special-buffer-toggle ()
  (interactive)
  (if eab/special-buffer-displaedp
      (progn
	;; (ignore-errors (delete-window (get-buffer-window eab/special-buffer)))
	(popwin:close-popup-window)
	(setq eab/special-buffer-displaedp nil))
    (progn
      (ignore-errors (popwin:display-buffer eab/special-buffer))
      (setq eab/special-buffer-displaedp 't))))

(global-set-key (kbd "<f3>") 'eab/special-buffer-toggle)

(provide 'eab-popwin)
