
(electric-indent-mode)
(electric-pair-mode -1)

;; DONE похоже, переменная server-name здесь еще не становится serverN

(eab/bind-path eab/secrets-path)
; TODO create function and hook after first start frame
(defun eab/load-personal ()
  (interactive)
  (eab/load-personal-minimal)
  (require 'keyfreq)
  (eab/bind-path keyfreq-file)
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
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
  (sauron-org-start)
  (sauron-twittering-stop)
  (wg-change-modeline)
  )

(if (and (eab/ondaemon "server") (not noninteractive))
    (progn
      (load-theme 'spacemacs-dark 't)))

;; check inet connection first
(eab/bind-path eab/check-inet-path)
(if (eq (if (boundp 'eab/check-inet-path) (shell-command eab/check-inet-path)) 0)
    (auto-install-update-emacswiki-package-name t))
(auto-install-compatibility-setup) ;; for install-elisp users
;; 1. M-x auto-install-batch RET
;; 2. Input “anything”

;; DONE после перезагрузки firefox
;; about:config -> accesskeys -> toggle toggle
;; shell: ru (TAB) l (TAB)

(key-chord-mode 1) ; TODO заедает, если не в конце dotemacs, не включается по-умолчанию (или выключается из-за чего-то)
(yas-reload-all)


(provide 'eab-postload)
