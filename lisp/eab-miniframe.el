(setq eab-minibuffer-frame nil)

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

(provide 'eab-miniframe)
