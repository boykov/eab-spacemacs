;;; eab-helm.el --- eab helm configure -*- lexical-binding: t -*-

;; Copyright (C) 2010-2023 Evgeny Boykov
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
  (eab/sh-over-bash eab/xdg-open (helm-get-selection) 't)
  (abort-recursive-edit))

(eab/bind-path helm-locate-command)

(setq helm-idle-delay 0.01)
(setq helm-input-idle-delay 0.01)
(setq helm-candidate-number-limit 100)

(setq helm-sources '(helm-source-buffers-list
		     helm-source-file-name-history
		     helm-source-files-in-current-dir
		     helm-source-complex-command-history
		     ))

(defun eab/helm-org-agenda-files-headings (&optional arg)
  "Preconfigured helm for org files headings."
  (interactive "P")
  (let ((files eab/clocktable-scope))
      (helm :sources (helm-org-build-sources files nil arg)
            :truncate-lines helm-org-truncate-lines
            :buffer "*helm org headings*")))

(provide 'eab-helm)
