;;; eab-config-ergoemacs.el --- eab-config ergoemacs-mode configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package ergoemacs-functions
  :after (facemenu eab-minimal)
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
   "M-8"  'ergoemacs-extend-selection)
  (general-define-key
   "C-t"          'transpose-sexps
   "M-m"          'forward-sexp
   "M-n"          'backward-sexp
   "M-q"          'kill-current-buffer
   "C-i"          'indent-for-tab-command
   "C-m"          'newline
   "C-@"          'set-mark-command
   "C-S-a"        'eval-expression
   "C-S-b"        'select-frame-by-name
   "C-S-s"        'write-file
   "C-SPC"        'set-mark-command
   "S-SPC"        'nil
   "C-c M-f"      'find-file-at-point
   "C-k"          'toggle-input-method
   "C-o"          'find-file
   "C-x C-e"      'eval-defun
   "C-x C-k k"    'kill-region
   "C-x M-f"      'find-file-at-point
   "C-x c"        'customize-variable
   "C-x e"        'eval-last-sexp
   "C-x j"        'comment-region
   "C-x o"        'other-window
   "C-z"          'repeat
   "M-!"          'delete-window
   "M-%"          'query-replace-regexp
   "M-&"          'count-matches
   "M-'"          'comment-dwim
   "M-/"          'dabbrev-expand
   "M-1"          'delete-other-windows
   "M-2"          'split-window-vertically
   "M-5"          'query-replace
   "M-@"          'split-window-horizontally
   "M-B"          'backward-kill-sexp
   "M-C"          'copy-all
   "M-H"          'move-end-of-line
   "M-I"          'scroll-down
   "M-J"          'beginning-of-buffer
   "M-K"          'scroll-up
   "M-L"          'end-of-buffer
   "M-M"          'end-of-defun
   "M-N"          'beginning-of-defun
   "M-O"          'forward-paragraph
   "C-S-SPC"      'mark-defun
   "M-SPC"        'set-mark-command
   "C-M-@"        'set-rectangular-region-anchor
   "M-U"          'backward-paragraph
   "M-X"          'delete-region
   "M-b"          'kill-sexp
   "M-c"          'kill-ring-save
   "M-e"          'backward-kill-word
   "M-f"          'delete-char
   "M-F"          'delete-backward-char
   "M-g"          'kill-line
   "M-h"          'move-beginning-of-line
   "M-i"          'previous-line
   "M-j"          'backward-char
   "C-M-j"        'delete-backward-char
   "M-k"          'next-line
   "M-l"          'forward-char
   "M-o"          'forward-word
   "M-p"          'move-end-of-line
   "M-r"          'kill-word
   "M-u"          'backward-word
   "M-v"          'yank
   "M-x"          'kill-region
   "C-c d"        'nil
   "C-c v"        'nil
   "C-c w"        'nil
   "C-x b"        'switch-to-buffer
   "M-."          'nil
   ))

(provide 'eab-config-ergoemacs)
