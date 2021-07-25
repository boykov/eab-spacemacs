
(electric-indent-mode)
(electric-pair-mode -1)

;; DONE похоже, переменная server-name здесь еще не становится serverC

(eab/bind-path eab/secrets-path)
; TODO create function and hook after first start frame
(defun eab/load-personal ()
  (interactive)
  (eab/load-personal-minimal)
  (if (= (shell-command "ps -A | grep Xorg") 0)
      (setq minibuffer-frame-alist
	    `((top . ,(/ (x-display-pixel-height) 2))
	      (left . ,(/ (* (x-display-pixel-width) 1) 4))
	      (width . ,(/ (* 1on1-minibuffer-frame-width-percent (x-display-pixel-width))
			   (* 100 (frame-char-width 1on1-minibuffer-frame)) 2)) (height . 2))))

  ;; (make-frame (append 1on1-minibuffer-frame-alist minibuffer-frame-alist))
  (load-file eab/secrets-path)
  (eab/check-smtp)
  (gnus)
  ;; (erc :server "localhost")
  (sauron-start)
  (sauron-notifications-start)
  ;; (sauron-org-start)
  (sauron-twittering-stop)
  (wg-change-modeline)
  (require 'cl-macs)
  (cl-assert
   (equal (ido-completing-read-silent "prompt: " '("one" "two" "three" "four" "five") "t")
	  '("three" "two")))
  )

;; check inet connection first
(eab/bind-path eab/check-inet-path)

(yas-reload-all)


(provide 'eab-postload)
