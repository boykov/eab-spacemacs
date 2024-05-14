;;; eab-helm.el --- eab helm configure -*- lexical-binding: t -*-

;; Copyright (C) 2010-2024 Evgeny Boykov
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
  (load eab/org-file nil 't)
  (eab/helm-org arg))

(defun eab/helm-org-switch-ql (marker)
  (eab/helm-org-ql))

(defun eab/helm-org (arg)
  (let ((files eab/clocktable-scope)
        (timestamp (eab/hron-current-time-stamp))
        (helm-input-idle-delay helm-org-ql-input-idle-delay))
    (helm :sources
          (eab/helm-org-build-sources files nil arg)
          :truncate-lines helm-org-truncate-lines
          :prompt (concat timestamp " pattern: "))))

(cl-defun eab/helm-org-ql ()
  (interactive)
  (let ((files eab/clocktable-scope)
        (timestamp (eab/hron-current-time-stamp))
        (helm-input-idle-delay helm-org-ql-input-idle-delay))
    (helm :prompt (concat timestamp " pattern: ")
          :truncate-lines helm-org-truncate-lines
          :sources (eab/helm-org-ql-source files :name "helm-org-ql"))))

(cl-defun eab/helm-org-ql-source (buffers-files &key (name "helm-org-ql"))
  "Return Helm source named NAME that searches BUFFERS-FILES with `helm-org-ql'."
  ;; Expansion of `helm-build-sync-source' macro.
  (helm-make-source name 'helm-source-sync
    :candidates (lambda ()
                  (let* ((query (if (equal helm-pattern "") nil `(regexp ,helm-pattern)))
                         (window-width (window-width (helm-window))))
                    (when query
                      (with-current-buffer (helm-buffer-get)
                        (setq helm-org-ql-buffers-files buffers-files))
                      (ignore-errors
                        ;; Ignore errors that might be caused by partially typed queries.
                        (org-ql-select buffers-files query
                          :action `(helm-org-ql--heading ,window-width))))))
    :match #'identity
    :fuzzy-match nil
    :multimatch nil
    :nohighlight t
    :volatile t
    :keymap helm-org-ql-map
    :action helm-org-ql-actions))

(defun eab/helm-org-build-sources (filenames &optional parents force-refresh)
  (unwind-protect
      (cl-loop for file in filenames
               for name = (if (bufferp file)
                              (buffer-name file)
                            (helm-basename file))
               collect
               (helm-build-sync-source (format "Org headings (%s)" name)
                 :candidates (helm-dynamic-completion
                              (remove-if
                               (lambda (s) (string-match ".*:nohelm:.*" s))
                               (helm-org--get-candidates-in-file
                                file
                                helm-org-headings-fontify
                                t
                                parents (or force-refresh
                                            helm-org--force-refresh)))
                              'stringp
                              nil '(metadata (display-sort-function
                                              .
                                              (lambda (candidates)
                                                (sort candidates
                                                      #'helm-generic-sort-fn))))
                              nil helm-org-completion-styles)
                 :match-dynamic t
                 :filtered-candidate-transformer
                 #'helm-org-indent-headings
                 :action 'helm-org-headings-actions
                 :help-message 'helm-org-headings-help-message
                 :keymap helm-org-headings-map
                 :group 'helm-org))
    (setq helm-org--force-refresh nil)))

(provide 'eab-helm)
