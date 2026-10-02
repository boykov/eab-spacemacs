;;; eab-config-eab-org.el --- eab-config eab-org configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package org
  :load-path "~/.emacs.d/private/eab-spacemacs/local/org-mode/lisp"
  :init
  (eab/config
   (if (eab/ondaemon (eab/server-P))
       (setq org-directory "~/git/org-chronos/")
     (setq org-directory "/home/eab/git/org/")))
  :config
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (add-hook 'org-mode-hook (lambda () (setq indent-tabs-mode nil)))
  ;; fix org-element performance degradation
  (setq org-element--cache-self-verify 't)
  (setq org-element-use-cache 't)
  (if (string= (daemonp) "kairosC") (setq org-cycle-hide-drawer-startup nil))
  '((setq org-element-cache-persistent nil))
  '((setq org-element-use-cache nil))
  (defun eab/papers-eaf (tag)
    (eab/config (concat "/home/eab/pnt/data/read/papers/" tag ".pdf")))
  (defun eab/papers-firefox (tag)
    (eab/config (concat "https://share.eab.su/papers/" tag ".pdf")))
  (put 'eab/papers-eaf 'org-link-abbrev-safe t)
  (put 'eab/papers-firefox 'org-link-abbrev-safe t)

  ;; fix 'file is already exist' bug
  (setq org-babel-temporary-directory "/tmp/user/1000/babel-aa5I6G"))

(use-package org-clock)
(use-package org-crypt)
(use-package org-capture)
(use-package org-id)
(use-package org-archive)
(use-package ox-latex)
(use-package ox-html)
(use-package ol-bbdb)
(use-package org-agenda)
(use-package org-protocol)
(use-package org-src)
(use-package org-agenda-property
    :after (org-agenda)
    :config
    (setq org-agenda-property-list '("Custom_BIB")))

(use-package org-ql
  :load-path "~/.emacs.d/private/eab-spacemacs/local/org-ql")
(use-package org-ql-search
  :after (org-ql)
  :config
  (setq org-link-parameters
        (remove
         '("org-ql-search" :follow org-ql-view--link-follow
           :store org-ql-view--link-store)
         org-link-parameters)))

(use-package org-sql
  :defer)

(use-package org-transclusion)

(use-package org-link-minor-mode
  :load-path "~/.emacs.d/private/eab-spacemacs/local/org-link-minor-mode"
  :after (org))

(use-package ob-tmux)

(use-package org-table
  :config
  (eab/add-hook orgtbl-mode-hook eab/orgtbl-mode-hook
    (general-define-key
     :keymaps 'orgtbl-mode-map
     "M-a"        'nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eab-org
  :init
  (eab/config
   (if (eab/ondaemon (eab/server-P))
       (setq eab/org-publish-directory "/home/eab/pub/org/")
     (setq eab/org-publish-directory "~/pub/org/"))
   (setq eab/org-publish-directory-file "file:///home/eab/pub/org/"))
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
  (general-define-key
   "M-S-SPC"      'org-mark-paragraph
   "C-c RET"      'org-return
   "C-c a"        'org-agenda
   "C-c C-M-p"    'org-open-at-point-global
   "C-c C-l"      'org-insert-link
   "C-c l"        'org-store-link
   "C-c r"        'org-capture
   "C-x C-M-p"    'org-open-at-point-global
   )
  (eab/add-hook org-mode-hook eab/org-hook
    (general-define-key
     :keymaps 'org-mode-map
     "RET"                'eab/org-return
     "M-D"                'ace-link-org
     "C-d"                eab/compile-map
     "<f6>"               'eab/revert-buffer
     "C-y"                'nil
     "C-e"                'nil
     "C-,"                'nil
     "C-SPC"              'nil
     "M-a"                'nil
     "M-e"                'nil
     "C-a"                'nil
     "C-k"                'nil
     "M-h"                'org-beginning-of-line
     "M-p"                'org-end-of-line
     "M-g"                'org-kill-line
     "M-v"                'org-yank
     "M-RET"              (ilam (org-insert-heading nil))
     "C-M-n"              'org-backward-element
     "C-M-m"              'org-forward-element
     "M-n"                'sp-backward-sexp
     "M-m"                'sp-forward-sexp
     "M-N"                'org-backward-sentence
     "M-M"                'org-forward-sentence
     "M-U"                'eab/org-backward-paragraph
     "M-O"                'eab/org-forward-paragraph
     "M-u"                'eab/org-backward-page
     "M-o"                'eab/org-forward-page
     "C-M-S-u"            'org-backward-paragraph
     "C-M-S-o"            'org-forward-paragraph
     "C-M-u"              'outline-previous-visible-heading
     "C-M-o"              'outline-next-visible-heading
     "C-c C-x M-c"        'org-copy-special
     "C-c C-x M-x"        'org-cut-special
     "C-c C-x M-v"        'org-paste-special
     )

    (key-chord-define org-mode-map "jj" 'org-edit-src-code)
    (key-chord-define org-src-mode-map "jj" 'org-edit-src-exit)

    (general-define-key
     :keymaps 'org-src-mode-map
     "C-l '"      'org-edit-src-exit)

    (general-define-key
     :keymaps 'org-ql-view-map
     "q" #'eab/bury-buffer
     "g" #'eab/org-ql-view-refresh)

    (general-define-key
     :keymaps 'org-agenda-mode-map
     "M-j"        'nil
     "M-l"        'nil
     "C-p"        'nil
     "C-n"        'nil
     "C-k"        'nil
     "s"          'isearch-forward
     "h"          'eab/hron-todo
     "j"          'beginning-of-buffer
     "M-g"        'org-agenda-kill
     "M-k"        'org-agenda-next-line
     "M-i"        'org-agenda-previous-line))
  (general-define-key
   :keymaps 'eab/ctrl-l-map
   "."            (kbd "C-c . RET")
   "M-."          (ilam (execute-kbd-macro (read-kbd-macro "C-c . RET C-l RET C-l l")))
   "c"            'org-store-link
   "M-c"          'org-copy-special
   "M-x"          'org-cut-special
   "M-v"          'org-paste-special
   "p"            'org-priority-up
   "i"            'org-metaup
   "k"            'org-metadown
   "j"            'org-metaleft
   "l"            'org-metaright
   "<backtab>"    (ilam (org-content 6) (org-fold-hide-drawer-all))
   "M-k"          'org-shiftdown
   "M-i"          'org-shiftup
   "M-j"          'org-shiftleft
   "M-l"          'org-shiftright
   "K"            'org-shiftmetadown
   "I"            'org-shiftmetaup
   "J"            'org-shiftmetaleft
   "L"            'org-shiftmetaright
   "RET"          'org-meta-return
   "C-<return>"   'org-insert-heading-respect-content
   "C-j"          'org-insert-heading-respect-content
   "C-M-j"        'org-insert-heading-respect-content
   "o"            'org-open-at-point
   "'"            'org-edit-special
   "v"            'eab/org-insert-link-fast
   "V"            'org-insert-link
   "C-v"          'eab/org-insert-capture-from-clipboard
   "<tab>"        (ilam (progn (show-all) (run-hook-with-args 'org-cycle-hook 'all)))
   "z"            'org-archive-set-tag
   )
  (setq org-link-abbrev-alist
        (eab/config 
         `(("bib" . "~/git/lit/boykov.bib::%s")
           ("papers" . "%(eab/papers-firefox)")
           ("google" . "https://www.google.com/search?q=")
           )))
  ;; See also eab-header in ~/texmf/tex/latex/eab-styles/eab-header.sty
  (setq org-id-locations-file (eab/config (concat (eab/history-dir) ".org-id-locations")))
  (setq org-clock-persist-file (eab/config (concat (eab/history-dir) "org-clock-save.el")))
  (eab/add-hook bibtex-mode-hook eab/bibtex-hook
    (general-define-key
     :keymaps 'bibtex-mode-map
     "C-M-\\"     'bibtex-fill-entry))
  (setq bibtex-files (eab/config `("~/git/lit/boykov.bib")))
  (setq org-ditaa-jar-path (eab/config "/usr/bin/ditaa")))

(use-package eab-org-agenda
  :after (org org-agenda eab-org)
  :config
  (general-define-key
   "C-c s"        'eab/org-agenda-search
   )
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
  :after (eab-org org-protocol)
  :config
  (general-define-key
   "C-c O"        'eab/open-corresponding-html
   "C-c B"        'eab/open-heading-browser
   ))
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
  :after (eab-org eab-org-publish)
  :config
  (general-define-key
   :keymaps 'eab/ctrl-l-map
   "M-h"          'eab/jump-current-time
   "h"            'eab/hron-todo
   "C-h"          'eab/hron-todo
   ))

(provide 'eab-config-eab-org)
