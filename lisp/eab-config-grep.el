;;; eab-config-grep.el --- eab-config grep configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(general-define-key  "C-x M-g"    (ilam (eab/grep 2)))

(eab/add-hook grep-mode-hook eab/grep-hook
  (general-define-key
   :keymaps 'grep-mode-map
   "B"          'eab/switch-grep-prev
   "F"          'eab/switch-grep-next
   "C-o"        'nil
   "M-p"        'nil
   "C-l b"      'eab/kill-last-grep
   "b"          (ilam (eab/switch-grep-prev 't))
   "M-RET"      'eab/compile-goto-error-same-window
   "C-M-j"      'eab/compile-goto-error-same-window
   "RET"        'eab/compile-goto-error
   "g"          'eab/recompile
   "u"          'eab/grep-utf
   "s"          'eab/grep-switch
   "l"          (ilam (so-long-minor-mode 1) (toggle-truncate-lines 1))
   "M-n"        'nil
   "C-w"        'eab/wgrep-change-to-wgrep-mode))
(use-package eab-grep
  :after (grep-a-lot wgrep eab-minimal)
  :config
  (defvar eab/grep-map (make-sparse-keymap)
    "Grep keymap.")
  (global-set-key (kbd "C-x G") nil)
  (general-define-key
   :prefix "C-x G"
   "f"    'eab/find-grep
   "g"    'eab/find-grep
   "c"    'eab/clock-grep
   "s"    (ilam
           (call-interactively 'eab/grep)
           (call-interactively 'eab/switch-grep)
           ;; (setq-local eab/grep-switch-cycle 'full)
           (sleep-for 0.4)
           (progn
             (eab/grep-switch-0 eab/grep-clock-left eab/grep-clock-right)
             (setq-local eab/grep-switch-cycle 'full)))
   "G"    'eab/clock-grep)
  (setq eab/grep-map (lookup-key global-map (kbd "C-x G")))
  )
