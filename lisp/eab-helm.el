;;; eab-helm.el --- eab helm configure

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: helm
;; Status: not intended to be distributed yet

(require 'helm) ;; fix boundp helm-map
(require 'helm-elisp)
(require 'helm-locate)
(require 'helm-config)
(require 'helm-multi-match)
;;(require 'helm-match-plugin)
;; (helm-match-plugin-mode 0) ;; bug in terminal mode
(remove-hook 'helm-update-hook 'helm-mp-highlight-match)

(eab/bind-path helm-c-adaptative-history-file)

(defun eab/helm-select-action ()
  (interactive)
  (eab/sh-over-bash "xdg-open" (helm-get-selection) 't)
  (minibuffer-keyboard-quit))

(setq helm-locate-command "locate %s -e -r %s")


(setq helm-idle-delay 0.01)
(setq helm-input-idle-delay 0.01)
(setq helm-candidate-number-limit 100)

(setq helm-sources '(helm-source-buffers-list
		     helm-source-file-name-history
		     helm-source-files-in-current-dir
		     helm-source-complex-command-history
		     ))

(eab/bind-path eab/downloads-path)

(eab/bind-path eab/musicdb-path)

(provide 'eab-helm)