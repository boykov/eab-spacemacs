;;; eab-postload.el ---  eab postload

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: none
;; Status: ready

(electric-indent-mode)
(electric-pair-mode -1)
(setq default-input-method "russian-computer")
(setq system-time-locale "ru_RU.utf8")
(setq desktop-load-locked-desktop 't)
(when (and (not noninteractive))
  (if configuration-layer-error-count
      (add-to-list 'mode-line-modes '(t " [ERROR] ")))
  ;; TODO раньше был nil, потом стало глючить
  ;; из-за enable-local-variables
  (setq-default TeX-master t))

(if (and (or
          (eab/ondaemon (eab/server-P))
          (eab/ondaemon "server"))
         (not noninteractive))
    (load-theme 'spacemacs-dark 't))

(setq eab/org-file (concat org-directory "clock/current-time.el"))
(if (file-exists-p eab/org-file)
    (load eab/org-file)) ;; (setq eab/hron-current-time ..

(eab/renew-agenda-files-1)

; TODO create function and hook after first start frame

(global-set-key (kbd "C-h c") 'describe-key-briefly)
(global-set-key (kbd "M-O") 'forward-paragraph)

;; (eab/loaded-ok (concat (daemonp) " postload"))
;; (if (eab/ondaemon "chronosC")
;;     (eab/sh-over-bash eab/emacs-client-command "" 't))

(provide 'eab-postload)
