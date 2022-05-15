;;; eab-postload.el ---  eab postload

;; Copyright (C) 2010-2022 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: none
;; Status: ready

(setq desktop-load-locked-desktop 't)
(if (and (not noninteractive))
    (progn
      (if configuration-layer-error-count
	  (add-to-list 'mode-line-modes '(t " [ERROR] ")))
      ;; TODO раньше был nil, потом стало глючить
      ;; из-за enable-local-variables
      (setq-default TeX-master t)))

(defun eab/test-dotemacs ()
  (if (not configuration-layer-error-count)
      (progn
	(eab/gotify "ok expectations" "OK Dotemacs is loaded! Expectations OK!" 0)
	(kill-emacs))
    (progn
	(eab/gotify "bad dotemacs" "Dotemacs is failed!" 5)
	(kill-emacs))))

(electric-indent-mode)
(electric-pair-mode -1)

;; DONE похоже, переменная server-name здесь еще не становится serverC

(if (and (or (eab/ondaemon "serverP") (eab/ondaemon "server")) (not noninteractive))
    (progn
      (load-theme 'spacemacs-dark 't)))

(eab/bind-path eab/secrets-path)
; TODO create function and hook after first start frame

(defun eab/load-desktop ()
  ;; TODO don't setup defadvice wg-switch-to-workgroup before it
  (eab/workgroups-save-file-load)
  (ignore-errors (let ((dir (eab/desktop-dir)))
		   (if (file-exists-p (concat dir ".emacs.desktop"))
		       (desktop-read dir)))))

(defun eab/load-personal ()
  (interactive)
  (disable-theme 'solarized-light)
  (if (fboundp 'grep-a-lot-clear-stack)
      (grep-a-lot-clear-stack))
  (winner-mode)
  ;; (if (= (shell-command "ps -A | grep Xorg") 0)
  ;;     (setq minibuffer-frame-alist
  ;; 	    `((top . ,(/ (x-display-pixel-height) 2))
  ;; 	      (left . ,(/ (* (x-display-pixel-width) 1) 4))
  ;; 	      (width . ,(/ (* 1on1-minibuffer-frame-width-percent (x-display-pixel-width))
  ;; 			   (* 100 (frame-char-width 1on1-minibuffer-frame)) 2)) (height . 2))))

  ;; (make-frame (append 1on1-minibuffer-frame-alist minibuffer-frame-alist))
  ;; (load-file eab/secrets-path)
  ;; (eab/check-smtp)
  ;; (gnus)
  ;; (erc :server "localhost")
  (wg-change-modeline)
  (require 'cl-macs)
  (cl-assert
   (equal (ido-completing-read-silent "prompt: " '("one" "two" "three" "four" "five") "t")
	  '("three" "two")))
  (global-eldoc-mode 0)
  (require 'yasnippet)
  (yas-reload-all)
  (require 'org-ql-search)
  (require 'org-sql)
  (require 'eab-helm)
  )

;; check inet connection first
(eab/bind-path eab/check-inet-path)


;; TODO приходится вручную еще раз запускать, почему?
;; может быть это связано с нововведением dbus-launch?
;; Наоборот, пришлось убрать dbus-launch, т.к. из-за него
;; накапливались лишние процессы, а все по-прежнему
;; (when (and
;;        (eq window-system 'x)
;;        (fboundp 'dbus-register-signal))
;;   (dbus-register-signal
;;    :session nil "/org/gnome/evince/Window/0"
;;    "org.gnome.evince.Window" "SyncSource"
;;    'th-evince-sync))

(setq default-input-method "russian-computer")

(provide 'eab-postload)
