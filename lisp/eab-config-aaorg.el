;;; eab-config-aaorg.el --- eab-config aaorg configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package org
  :config
  (eab/bind-path org-directory)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (add-hook 'org-mode-hook (lambda () (setq indent-tabs-mode nil)))
  ;; fix org-element performance degradation
  (setq org-element--cache-self-verify 't)
  (setq org-element-use-cache 't)
  (if (string= (daemonp) "kairosC") (setq org-cycle-hide-drawer-startup nil))
  '((setq org-element-cache-persistent nil))
  '((setq org-element-use-cache nil))
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

(eab/add-hook orgtbl-mode-hook eab/orgtbl-mode-hook
  (general-define-key
   :keymaps 'orgtbl-mode-map
   "M-a"        'nil))

(eab/add-hook org-mode-hook eab/org-hook
  (general-define-key
   :keymaps 'org-mode-map
   "RET"                'eab/org-return
   "M-D"                'ace-link-org
   "C-d"                eab/compile-map
   "<f6>"               'eab/revert-buffer
   "s-'"                'org-edit-src-code
   "s-k"                'undefined
   "s-i"                'org-metaup
   "s-p"                'org-priority-up
   "s-j"                'org-metaleft
   "s-l"                'org-metaright
   "s-K"                'undefined
   "s-I"                'org-shiftmetaup
   "s-J"                'org-shiftmetaleft
   "s-L"                'org-shiftmetaright
   "s-<return>"         'org-insert-heading
   "s-S-<return>"       'org-insert-todo-heading
   "M-s-k"              'org-shiftdown
   "M-s-i"              'org-shiftup
   "M-s-j"              'org-shiftleft
   "M-s-l"              'org-shiftright
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
   "s-u"                'org-preview-latex-fragment
   "C-c C-x M-c"        'org-copy-special
   "C-c C-x M-x"        'org-cut-special
   "C-c C-x M-v"        'org-paste-special
   "s-x M-c"            'org-copy-special
   "s-x M-x"            'org-cut-special
   "s-x M-v"            'org-paste-special
   "s-."                (kbd "C-c . RET"))

  (key-chord-define org-mode-map "jj" 'org-edit-src-code)
  (key-chord-define org-src-mode-map "jj" 'org-edit-src-exit)

  (general-define-key
   :keymaps 'org-src-mode-map
   "s-'"        'org-edit-src-exit
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

