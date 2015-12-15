(defun eab/ido-wmctrl-1 ()
  (eab/shell-command
   (concat "wmctrl -i -a "
	   (anything-c-wmctrl-wmctrl-to-id
	    (gethash
	     (ido-completing-read "Wmctrl: "
				  (mapcar (lambda (x) (car x)) (eab/wmctrl-pairs)))
	     (eab/wmctrl-hash))))))

(defun eab/ido-wmctrl-pdf-1 ()
  (eab/shell-command
   (concat "wmctrl -i -a "
	   (anything-c-wmctrl-wmctrl-to-id
	    (gethash
	     (ido-completing-read "Wmctrl: "
				  (remove-if-not (lambda (s) (string-match "pdf" s))
						 (mapcar (lambda (x) (car x)) (eab/wmctrl-pairs))))
	     (eab/wmctrl-hash))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (lambda ()
;;   (interactive)
;;   (bookmark-jump
;;    (ido-completing-read "Jump to bookmark: " (bookmark-all-names))))

(defun eab/ido-at-point-1 (word)
  (insert (ido-completing-read "Ido at point: " (ac-symbol-candidates) nil nil word)))

(defun eab/ido-complete ()
  (interactive)
  (let ((word (current-word)))
    (set-mark-command nil)
    (backward-word)
    (call-interactively 'delete-region)
    (eab/ido-at-point word)))

(defun eab/wrap-ido-completing-read ()
  (interactive)
  (ido-completing-read prompt choices nil nil initial-input)
  't)

(defun ido-completing-read-silent (prompt choices initial-input)
  (execute-kbd-macro (read-kbd-macro "C-S-a (eab/wrap-ido-completing-read) RET RET"))
  ido-matches)

;; (setq my-desired-list
;;       (mapcar
;;        (lambda (x)
;; 	 (flx-propertize x nil))
;;        (ido-completing-read-silent "prompt: " '("one" "two" "three" "four" "five") "t")))

;; TODO open pdf if it isn't opened
;; TODO need to generalize with defmacro
(defun eab/switch-wmctrl-window (name)
  "Fast switch to name pdf window."
  (interactive)
  (eab/shell-command
   (concat  "wmctrl -i -a "
	    (anything-c-wmctrl-wmctrl-to-id
	     (gethash
	      (car (ido-completing-read-silent
		    ""
		    (mapcar
		     (lambda (x) (car x))
		     (eab/wmctrl-pairs))
		    name))
	      (eab/wmctrl-hash))))))


;; is used in miniframe and ido-minibuffer
(defun eab/ido-wmctrl ()
  (interactive)
  (eab/ido-wmctrl-1)
  (minibuffer-keyboard-quit))

(defun eab/ido-wmctrl-pdf ()
  (interactive)
  (eab/ido-wmctrl-pdf-1)
  (minibuffer-keyboard-quit))

(provide 'eab-ido-utils)
