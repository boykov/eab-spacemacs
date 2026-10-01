;;; eab-config-needorg.el --- eab-config needorg configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eab-bookmark
  :after (eab-minimal eab-workgroups2))
(use-package eab-gr
  :after (eab-compile eab-notify))
(use-package eab-workflow
  :config
  (general-define-key
   "<f7>"         'eab/fix-windows-coding
   "<f6>"         'eab/revert-buffer
   "C-c u"        'eab/unbound-var
   "C-c U"        'eab/unbound-fun
   ))
(use-package eab-ui
  :config
  (setq auto-save-list-file-prefix (eab/config (concat (eab/history-dir) "auto-save-list/.saves-")))
  (setq save-place-file (eab/config (concat (eab/history-dir) ".emacs-places")))
  (setq url-configuration-directory (eab/config (concat (eab/history-dir) "url/")))
  (eab/config
   (cond ((eab/onhost "kairos")       (setq source-directory "~/data/github/emacs/src"))
         ((eab/onhost "chronos")      (setq source-directory "~/data/github/emacs/src"))
         ((eab/onhost "kairos-emacs") (setq source-directory "~/data/github/emacs/src"))
         ((eab/onhost "chronos-emacs")(setq source-directory "~/data/github/emacs/src"))
         ((eab/onhost "cyclos-emacs") (setq source-directory "~/data/github/emacs/src"))))
  (setq find-function-C-source-directory source-directory)
  (setq custom-file (eab/config (concat (eab/history-dir) "custom.el"))))
(use-package eab-ido
  :after (projectile eab-minimal)
  :config
  (general-define-key
   "C-b"          'eab/cxb
   )
  (setq ido-save-directory-list-file
        (eab/config (concat (eab/history-dir) ".ido.last"))))
(use-package eab-desktop
  :after (autorevert eab-workgroups2))
(use-package eab-window)
(use-package eab-outline
  :after (eab-minimal))
(use-package eab-tramp)
(use-package eab-eepitch
  :config
  (general-define-key
   "C-,"          'eab/eepitch-this-line
   "C-r"          'eab/eepitch-this-line
   "C-M-r"        'eab/eepitch-paragraph
   )
  (setq eab/eeansi-path (eab/config (expand-file-name "~/.eev/eeansi.sh")))
  (setq eab/eegchannel-path
        (eab/config
         (expand-file-name (concat eab-spacemacs-path "local/eev-current/eegchannel"))))
  (setq vterm-shell eab/eeansi-path))

(use-package epa)
(use-package epa-file
  :after (epa)
  :config
  (epa-file-enable)
  (setq epa-file-select-keys 'silent))
(use-package epg
  :config
  (setenv "GPG_AGENT_INFO" nil)       ; use gpg without gui window
  ;; gpg --import ~/.ssh/key_*.gpg
  (setq epg-gpg-program "gpg")
  (setq epa-pinentry-mode 'loopback))

(use-package vterm
  :config
  (setq
   vterm-keymap-exceptions
   '(
     "C-c" "C-x" "C-u" "C-g" "C-h" "C-l" "M-x" "M-o" "C-v" "M-v"
     "C-y" "M-y" "M-s" "M-a" "M-i" "M-k" "M-j" "M-l" "C-a" "M-c" "M-p"))
  (defun vterm-send-meta-c-b ()
    "Send `M-<backspace>' to the libvterm."
    (interactive)
    (vterm-send-key "b" nil t t)))

;; (load "auctex.el" nil t t)
(use-package eab-tex)


(use-package eab-smex
  :after (helm eab-minimal)
  :config
  (general-define-key
   :keymaps 'minibuffer-local-map
   "M-a"          'eab/smex-extended
   "C-w"          'eab/smex-repeat)
  (general-define-key
   "M-a"          'eab/smex-limited-commands)
  (setq smex-save-file (eab/config (concat (eab/history-dir) ".smex-items"))))
(use-package undo-tree
  :config
  (general-define-key
   "M-z"          'undo-tree-undo
   "M-Z"          'undo-tree-redo
   )
  (global-undo-tree-mode))
(use-package which-key
  :defer
  :config
  (setq which-key-idle-delay 2)
  (which-key-mode))
(use-package diminish
  :after (undo-tree which-key)
  :config
  (diminish 'which-key-mode "WK")
  (diminish 'undo-tree-mode "UT"))
(use-package buffer-move
  :config
  (defun buf-move ()
    "Begin moving the current buffer to different windows.

Use the arrow keys to move in the desired direction.  Pressing
any other key exits this function."
    (interactive)
    (let ((map (make-sparse-keymap)))
      (dolist (x '(("M-i" . buf-move-up)
                   ("M-j" . buf-move-left)
                   ("M-k" . buf-move-down)
                   ("M-l" . buf-move-right)))
        (define-key map (read-kbd-macro (car x)) (cdr x)))
      (set-transient-map map t))))
(use-package guide-key
  :config
  (guide-key-mode 1))
(use-package string-edit-at-point)
(use-package redo+
  :config
  (general-define-key
   "M-z"          'undo))

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
 )

(provide 'eab-config-needorg)
