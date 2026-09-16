;;; eab-config-dired.el --- eab-config dired configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(eab/add-hook dired-mode-hook eab/dired-hook
  (general-define-key
   :keymaps 'dired-mode-map
   "C-M-b"      'nil
   "M-a"        'nil
   "M-i"        'nil
   "M-j"        'nil
   "C-n"        'nil
   "M-c"        'nil
   "M-g"        'nil
   "M-G"        'nil
   "M-v"        'nil
   "M-!"        'nil
   "M-l"        'nil
   "M-p"        'nil
   "M-o"        'nil
   "M-s"        'nil
   "M-u"        'nil
   "M-m"        'nil
   "C-o"        'nil
   "C-p"        'nil
   "C-k"        'nil
   "C-S-a"      'nil
   "C-c C-w"    'dired-do-rename
   "C-w"        'wdired-change-to-wdired-mode
   "b"          'browse-url-of-dired-file
   "o"          'dired-find-file-other-window
   "C-|"        'eab/dired-see-file
   "s-SPC"      'eab/dired-see-file
   "E"          'ediff-files
   "SPC"        'open-in-external-app))
(eab/add-hook wdired-mode-hook eab/wdired-hook
  (general-define-key
   :keymaps 'wdired-mode-map
   "s-w"        'wdired-finish-edit))
(use-package dired-async)
(use-package dired-x)
(use-package eab-dired
  :after (dired eab-tramp eab-org eab-minimal)
  :config
  (defvar eab/dired-map (make-sparse-keymap)
    "keymap for fast dired")
  (global-set-key (kbd "C-x d") nil)
  (eab/bind-path eab/downloads-path)
  (general-define-key
   :prefix "C-x d"
   "d" '(ido-dired :which-key "ido-dired")
   "o" (ilam (dired eab/org-publish-directory))
   "h" (ilam (dired "~/desktop"))
   "s" (ilam (dired "~/share"))
   "p" (ilam (dired eab/downloads-path))
   "t" (ilam (dired "~/tmp")))
  (setq eab/dired-map (lookup-key global-map (kbd "C-x d")))
  (add-to-list 'auto-mode-alist '("\\.dired$" . dired-virtual-mode)))
