;;; eab-helm.el --- eab helm configure -*- lexical-binding: t -*-

;; Copyright (C) 2010-2022 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: helm
;; Status: not intended to be distributed yet

(use-package helm) ;; fix boundp helm-map
(use-package helm-elisp)
(use-package helm-locate)
(use-package helm-config)
(use-package helm-multi-match)
;;(require 'helm-match-plugin)
;; (helm-match-plugin-mode 0) ;; bug in terminal mode
(remove-hook 'helm-update-hook 'helm-mp-highlight-match)

(eab/bind-path helm-c-adaptative-history-file)

(defun eab/helm-select-action ()
  (interactive)
  (eab/sh-over-bash "xdg-open" (helm-get-selection) 't)
  (minibuffer-keyboard-quit))

(setq helm-locate-command "ssh chronos locate %s -e -r %s")


(setq helm-idle-delay 0.01)
(setq helm-input-idle-delay 0.01)
(setq helm-candidate-number-limit 100)

(setq helm-sources '(helm-source-buffers-list
		     helm-source-file-name-history
		     helm-source-files-in-current-dir
		     helm-source-complex-command-history
		     ))

(provide 'eab-helm)
