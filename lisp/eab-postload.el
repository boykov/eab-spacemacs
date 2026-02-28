;;; eab-postload.el ---  eab postload

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: none
;; Status: ready

(setq desktop-load-locked-desktop 't)
(when (and (not noninteractive))
  (if configuration-layer-error-count
      (add-to-list 'mode-line-modes '(t " [ERROR] ")))
  ;; TODO раньше был nil, потом стало глючить
  ;; из-за enable-local-variables
  (setq-default TeX-master t))

(electric-indent-mode)
(electric-pair-mode -1)

;; DONE похоже, переменная server-name здесь еще не становится server-C

(if (and (or
          (eab/ondaemon (eab/server-P))
          (eab/ondaemon "server"))
         (not noninteractive))
    (load-theme 'spacemacs-dark 't))

(setq eab/org-file (concat org-directory "clock/current-time.el"))
(if (file-exists-p eab/org-file)
    (load eab/org-file)) ;; (setq eab/hron-current-time ..

(eab/renew-agenda-files-1)

(when (eab/ondaemon (eab/server-C))
  ;; (eab/check-csum-day)
  (setq system-time-locale "ru_RU.utf8"))

(eab/bind-path eab/secrets-path)
; TODO create function and hook after first start frame

(defun eab/load-personal ()
  (interactive)
  (if (fboundp 'grep-a-lot-clear-stack)
      (grep-a-lot-clear-stack))
  (winner-mode)
  ;; (load-file eab/secrets-path)
  (wg-change-modeline)
  (require 'cl-macs)
  (cl-assert
   (equal (ido-completing-read-silent
           "prompt: " '("one" "two" "three" "four" "five") "t")
          '("two" "three")))
  (global-eldoc-mode 0)
  (require 'yasnippet)
  (yas-reload-all)
  (require 'org-ql-search)
  (require 'org-depend)
  (require 'org-sql)
  (require 'eab-helm)
  (eab/loaded-ok (concat (daemonp) " dotemacs"))
  )

;; TODO move to eab-minimal?
(defun eab/load-gui ()
  (interactive)
  (when eab/first-emacsclient
    (iconify-frame)
    (disable-theme 'solarized-light)
    (eab/load-personal)
    ;; (eab/load-desktop)
    (eab/create-workgroups)
    (eab/wg-switch-to-workgroup ":clock:")
    ;; (toggle-frame-maximized)
    (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
    (iconify-frame)
    (execute-kbd-macro (read-kbd-macro "C-a H"))
    (setq eab/first-emacsclient nil))
  (set-face-attribute 'default nil
                      :family "Source Code Pro"
                      :height (if (eq (display-pixel-width) 1680) 130 150)
                      :weight 'normal
                      :width 'normal))

(setq default-input-method "russian-computer")

(global-set-key (kbd "C-h c") 'describe-key-briefly)
(global-set-key (kbd "M-O") 'forward-paragraph)
;; (general-define-key
;;  :prefix "C-e"
;;  "d" docker-command-map)

(provide 'eab-postload)
