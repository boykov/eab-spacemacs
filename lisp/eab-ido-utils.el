
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;; (require 'cl-macs)
;; (cl-assert
;;  (equal (mapcar
;; 	 (lambda (x)
;; 	   (flx-propertize x nil))
;; 	 (ido-completing-read-silent "prompt: " '("one" "two" "three" "four" "five") "t"))
;; 	'("three" "two")))

(provide 'eab-ido-utils)
