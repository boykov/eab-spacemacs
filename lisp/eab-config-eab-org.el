;;; eab-config-eab-org.el --- eab-config eab-org configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eab-org
  :init
  (eab/bind-path eab/org-publish-directory-file)
  (eab/bind-path eab/org-publish-directory)
  :after (org
          org-clock
          org-crypt
          org-capture
          org-id
          org-archive
          ol-bbdb
          ox-latex
          ox-extra
          ox-html
          eab-minimal)
  :config
  (eab/bind-path org-link-abbrev-alist)
  (eab/bind-path org-id-locations-file)
  (eab/bind-path org-clock-persist-file)
  (eab/add-hook bibtex-mode-hook eab/bibtex-hook
    (general-define-key
     :keymaps 'bibtex-mode-map
     "C-M-\\"     'bibtex-fill-entry))
  (eab/bind-path bibtex-files)
  (eab/bind-path org-ditaa-jar-path))
(use-package eab-org-agenda
  :after (org org-agenda eab-org)
  :config
  (add-hook 'org-agenda-mode-hook (lambda () (hl-line-mode 1)))
  (setq org-sort-agenda-notime-is-late nil)
  (setq org-agenda-sorting-strategy
        '((agenda habit-down time-up priority-down category-keep)
          (todo timestamp-down)
          (tags priority-down category-keep)
          (search category-keep)))
  (setq org-agenda-hide-tags-regexp nil)
  (org-toggle-sticky-agenda t)
  (setq org-agenda-include-diary nil)
  (setq org-agenda-archives-mode 't)
  (setq org-agenda-text-search-extra-files (quote (agenda-archives)))
  (setq org-agenda-clockreport-parameter-plist (quote (:link nil :maxlevel 2))))
(use-package eab-org-publish
  :after (eab-org))
(use-package eab-org-protocol
  :after (eab-org org-protocol))
(use-package eab-org-src-babel
  :after (org-src ob-tmux eab-org))
(use-package eab-org-todo
  :after (eab-org))
(use-package eab-org-latex
  :after (eab-org)
  :config
  (add-hook 'LaTeX-mode-hook 
            (lambda ()
              (general-define-key
               :keymaps 'LaTeX-mode-map
               "M-m"        'forward-sexp
               "C-d"        'nil
               "C-S-d"      eab/compile-map))))
(use-package eab-greek-to-latex :disabled)
(use-package eab-org-reftex :disabled)
(use-package eab-org-extension
  :after (eab-org))
(use-package eab-hron-lib
  :after (eab-org))

