;;; eab-config-ergoemacs.el --- eab-config ergoemacs-mode configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package ergoemacs-functions
  :after (facemenu eab-depend)
  :init
  (defun ergoemacs-handle-M-O ()
    "Handle meta+O input.
In a terminal, this can be either arrow keys (e.g. meta+O A == <up>) or regular meta+O keybinding."
    (interactive)
    (if (input-pending-p)
        (let ((second-char (read-char)))
          (cond
           ((eq second-char 65) ;; A
            (execute-kbd-macro (kbd "<up>")))
           ((eq second-char 66) ;; B
            (execute-kbd-macro (kbd "<down>")))
           ((eq second-char 67) ;; C
            (execute-kbd-macro (kbd "<right>")))
           ((eq second-char 68) ;; D
            (execute-kbd-macro (kbd "<left>")))
           ((eq second-char 72) ;; H
            (execute-kbd-macro (kbd "<home>")))
           ((eq second-char 70) ;; F
            (execute-kbd-macro (kbd "<end>")))
           (t
            (beep))))
      (call-interactively (key-binding [ergoemacs-meta-O]))))
  (defun ergoemacs-fix-arrow-keys (keymap)
    "Fix arrow keys for KEYMAP."
    (let (ergoemacs-M-O-binding)
      (setq ergoemacs-M-O-binding (lookup-key keymap (kbd "M-O")))
      (define-key keymap (kbd "M-O") 'ergoemacs-handle-M-O)
      (define-key keymap [ergoemacs-meta-O] ergoemacs-M-O-binding)))
  :config
  (general-define-key
   "C-n"  'eab/ergoemacs-new-empty-buffer
   "C-w"  'eab/ergoemacs-compact-uncompact-block
   "M-G"  'ergoemacs-kill-line-backward
   "M-Q"  'ergoemacs-close-current-buffer
   "M-`"  'ergoemacs-switch-to-next-frame
   "M-S"  'ergoemacs-move-cursor-previous-pane
   "M-s"  (ilam (ergoemacs-move-cursor-previous-pane -1))
   "M-w"  'ergoemacs-shrink-whitespaces
   "M-~"  'ergoemacs-switch-to-previous-frame
   "C-/"  'ergoemacs-toggle-letter-case
   "M-*"  'ergoemacs-select-text-in-quote
   "M-8"  'ergoemacs-extend-selection))
