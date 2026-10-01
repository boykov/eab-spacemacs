;;; eab-config-needorg.el --- eab-config needorg configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

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

(use-package eab-outline
  :after (eab-minimal))
(use-package eab-tramp)
(use-package eab-eepitch
  :config
  (eab/redefine-keymap "C-e" 'move-end-of-line)
  (general-define-key
   :prefix "C-e"
   "a"    (ilam (eepitch-ansi-term "1"))
   "1"    (ilam (eepitch-ansi-term "1"))
   "2"    (ilam (eepitch-ansi-term "2"))
   "3"    (ilam (eepitch-ansi-term "3"))
   "4"    (ilam (eepitch-ansi-term "4"))
   "5"    (ilam (eepitch-ansi-term "5"))
   "6"    (ilam (eepitch-ansi-term "6"))
   "7"    (ilam (eepitch-ansi-term "7"))
   "8"    (ilam (eepitch-ansi-term "8"))
   "9"    (ilam (eepitch-ansi-term "9"))
   "k"    (ilam (eepitch-kill))
   )
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
  (eab/redefine-keymap "C-e" 'move-end-of-line)
  (general-define-key
   :prefix "C-e"
   "z"    'undo-tree-visualize
   )
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
(use-package guide-key
  :config
  (guide-key-mode 1))
(use-package string-edit-at-point)
(use-package redo+
  :config
  (general-define-key
   "M-z"          'undo))

(provide 'eab-config-needorg)
