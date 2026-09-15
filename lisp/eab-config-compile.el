;;; eab-config-compile.el --- eab-config compile configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(eab/add-hook compilation-mode-hook eab/compilation-hook
  (general-define-key
   :keymaps 'compilation-button-map
   "M-RET"      'eab/compile-goto-error-same-window
   "RET"        'eab/compile-goto-error)
  (general-define-key
   :keymaps 'compilation-mode-map
   "g"          'eab/recompile
   "B"          'compilation-a-lot-goto-prev
   "F"          'compilation-a-lot-goto-next
   "\C-d"       eab/compile-map
   "\C-o"       'nil
   "M-k"        'nil
   "M-p"        'nil
   "M-i"        'nil
   "M-n"        'nil))
(use-package eab-compile
  :after (ansi-color eab-depend)
  :config
  (defvar eab/compile-map (make-sparse-keymap)
    "Compile keymap.")
  (global-set-key (kbd "C-d") nil)
  (general-define-key
   :prefix "C-d"
   "q"    'eab/nocommand
   "a"    'eab/compile-helm
   "e"    eab/explore-map
   "d"    'eab/projectile-compile-project
   "C-d"    'eab/projectile-compile-project
   "s"    (ilam (smart-compile 4))
   "S"    (ilam (eab/projectile-compile-project-custom "make push_unstaged"))
   "l"    (ilam (TeX-command "LaTeX"   'TeX-master-file))
   "b"    (ilam (TeX-command "BibTeX"  'TeX-master-file))
   "L"    (ilam (TeX-command "LaTeX"   'TeX-master-file))
   "p"    (ilam (eab/projectile-compile-project-custom "make push_all"))
   "c"    (ilam (eab/projectile-compile-project-custom "make clear"))
   "t"    (ilam (eab/projectile-compile-project-custom "make test"))
   "2"    (ilam (eab/projectile-compile-project-custom "make test2")))
  (setq eab/compile-map (lookup-key global-map (kbd "C-d")))
  (setq compile-command "make ")
  (setq compilation-exit-message-function 'compilation-exit-autoclose)
  (setq compilation-exit-message-function nil)
  (setq compilation-scroll-output 't))
