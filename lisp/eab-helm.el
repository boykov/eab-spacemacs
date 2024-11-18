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
  (helm-org-rifle-files (eab/clocktable-scope)))
  ;; (eab/helm-org-ql))

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

(defun eab/cmp-helm-property ()
  "Compare two org-mode headers, `A' and `B', by their :HE_SORT property.
  If a is before b, return nil, otherwise t."
  (lambda (a b)
    (let* ((a1 (get-text-property 0 'sort-he a))
           (b1 (get-text-property 0 'sort-he b))
           (a2 (get-text-property 0 'sort-priority a))
           (b2 (get-text-property 0 'sort-priority b))
           (a3 (get-text-property 0 'sort-todo a))
           (b3 (get-text-property 0 'sort-todo b))
           )
      (if (or (and (< (if (not a1) 2000 (string-to-number a1))
                      (if (not b1) 2000 (string-to-number b1)))
                   (= (if (not a2) 2000 (org-priority-to-value a2))
                      (if (not b2) 2000 (org-priority-to-value b2)))
                   (string= (if (not a3) "" a3)
                            (if (not b3) "" b3)))
              (and
               (< (if (not a2) 2000 (org-priority-to-value a2))
                  (if (not b2) 2000 (org-priority-to-value b2)))
               (string= (if (not a3) "" a3)
                        (if (not b3) "" b3)))
              (string> (if (not a3) "" a3)
                       (if (not b3) "" b3))) t nil))))

(defun h-candidate-transformer (candidates)
  (sort candidates (eab/cmp-helm-property)))

(defun eab/helm-org-build-sources (filenames &optional parents force-refresh)
  (helm-build-sync-source (format "Org headings (%s)" "eab/clocktable-scope")
    :candidates (helm-dynamic-completion
                 (remove-if
                  (lambda (s) (string-match ".*virtual.*" s))
                  (org-ql-select eab/clocktable-scope '(not (tags "nohelm"))
                    :action `(eab/helm-org-ql--heading 100)))
                 'stringp
                 nil nil
                 nil helm-org-completion-styles)
    ;; :match-dynamic t
    :candidate-transformer #'h-candidate-transformer
    :action 'helm-org-headings-actions
    :help-message 'helm-org-headings-help-message
    :keymap helm-org-headings-map
    :group 'helm-org))

;; org-revert-all-org-buffers
;; (completion-metadata-get
;;  '(metadata (display-sort-function
;;              .
;;              (lambda (candidates)
;;                (sort candidates
;;                      (eab/cmp-helm-property))))) 'display-sort-function)

(defun eab/helm-org-ql--heading (window-width)
  "Return string for Helm for heading at point.
WINDOW-WIDTH should be the width of the Helm window."
  (font-lock-ensure (point-at-bol) (point-at-eol))
  (let* ((prefix (concat (buffer-name) ":"))
         (width (- window-width (length prefix)))
         (heading (org-get-heading)))
    (propertize (concat heading)
                'sort-he (org-entry-get nil "HE_SORT")
                'sort-todo (org-entry-get nil "TODO")
                'helm-realvalue (point-marker)
                'sort-priority (org-entry-get nil "PRIORITY")
                )))

;; (get-text-property 0 'sort-he (propertize "str" 'sort-he "test" 'sort-p "test"))
;; (get-text-property 0 'sort-priority (car (org-ql-select eab/clocktable-scope '(not (tags "nohelm")) :action `(eab/helm-org-ql--heading9 100))))
;; (get-text-property 0 'sort-he (car (org-ql-select eab/clocktable-scope '(not (tags "nohelm")) :action `(eab/helm-org-ql--heading9 100))))

(provide 'eab-helm)
