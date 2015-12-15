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

;; Ubuntu: Alt + super + tab
;; /home/eab/git/auto/femacs.sh (eab/show-wmctrl-minibuffer) &
(defun eab/show-wmctrl-minibuffer ()
  (interactive)
    (if (frame-live-p eab-minibuffer-frame)
	(progn
	  (shell-command "wmctrl -a \"minibuffer\"")
	  (select-frame eab-minibuffer-frame)
	  (eab/ido-wmctrl-1)
	  (suspend-frame))
      (setq eab-minibuffer-frame
	    (make-frame (append minibuffer-frame-alist 1on1-minibuffer-frame-alist)))))

;; TODO можно ускорить выполнение, вызывая wmctrl напрямую
;; Ubuntu: Alt + t
;; /home/eab/git/auto/femacs.sh (eab/show-minibuffer-frame) &
;; TODO если закрыть минибуфер, то frame-alive-p по-прежнему
;; возвращает 't
;; пришлось создать вручную, вызвав команду напрямую
(defun eab/show-minibuffer-frame ()
  (interactive)
  ;; (eab/shell-command "setxkbmap us,ru")
  (if (frame-live-p eab-minibuffer-frame)
      (eab/shell-command "wmctrl -a \"minibuffer\"")
    (setq eab-minibuffer-frame
	  (make-frame (append minibuffer-frame-alist 1on1-minibuffer-frame-alist)))))

(provide 'eab-miniframe)
