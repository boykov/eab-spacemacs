;;; eab-config-mode.el --- eab-config mode configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eab-ui
  :config
  (eab/add-hook help-mode-hook eab/help-hook
    (general-define-key
     :keymaps 'help-mode-map
     "o"  'ace-link-help
     "B"  'help-go-back
     "M-n" 'nil
     "F"  'help-go-forward))
  (unless window-system ;; Only use in tty-sessions.
    (defvar arrow-keys-map (make-sparse-keymap) "Keymap for arrow keys")
    (define-key esc-map "O" arrow-keys-map)
    (define-key arrow-keys-map "A" 'previous-line)
    (define-key arrow-keys-map "B" 'next-line)
    (define-key arrow-keys-map "C" 'forward-char)
    (define-key arrow-keys-map "D" 'backward-char))
  (general-define-key
   "M-O"          'forward-paragraph
   "M-U"          'backward-paragraph
   )
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

(use-package eab-tramp)

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

;; (load "auctex.el" nil t t)
(use-package eab-tex)

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

(use-package eab-modes
  :config
  (eab/add-hook fortran-mode-hook eab/fortran-hook
    (general-define-key
     :keymaps 'fortran-mode-map
     "C-d"        eab/compile-map))

  (eab/add-hook text-mode-hook eab/text-hook
    (general-define-key
     :keymaps 'text-mode-map
     "C-c C-c"    'server-edit))

  (define-advice artist-mode (:before (&rest args) eab-artist-mode)
    (general-define-key
     :keymaps 'artist-mode-map
     "C-b"        'nil))

  (eab/add-hook nroff-mode-hook eab/nroff-hook
    (general-define-key
     :keymaps 'nroff-mode-map
     "M-s"        'nil
     "M-n"        'nil
     "M-p"        'nil))

  (eab/add-hook f90-mode-hook eab/f90-hook
    (general-define-key
     :keymaps 'f90-mode-map
     "C-j"        'nil
     "C-d"        eab/compile-map))

  (eab/add-hook message-mode-hook eab/message-hook
    (general-define-key
     :keymaps 'message-mode-map
     "C-c C-c"    'eab/message-send
     "M-;"        'nil
     "M-n"        'nil))

  (eab/add-hook makefile-gmake-mode-hook eab/makefile-gmake-mode
    (general-define-key
     :keymaps 'makefile-gmake-mode-map
     "\C-d"       eab/compile-map
     "M-n"        'nil
     "M-p"        'nil))

  (eab/add-hook java-mode-hook eab/java-hook
    (general-define-key
     :keymaps 'java-mode-map
     "M-M"        'c-end-of-defun
     "M-N"        'c-beginning-of-defun
     "M-j"        'nil
     "M-a"        'nil
     "M-e"        'nil))

  (eab/add-hook c-mode-hook eab/c-hook
    (general-define-key
     :keymaps 'c-mode-map
     "C-d"        eab/compile-map
     "C-M-a"      'nil
     "C-M-e"      'nil
     "M-a"        'nil
     "M-M"        'nil
     "M-N"        'nil
     "M-j"        'nil
     "M-q"        'nil
     "M-M"        'c-end-of-defun
     "M-N"        'c-beginning-of-defun
     "M-e"        'nil))

  (eab/add-hook c++-mode-hook eab/c++-hook
    (general-define-key
     :keymaps 'c++-mode-map
     "C-d"        eab/compile-map
     "C-M-a"      'nil
     "C-M-e"      'nil
     "M-a"        'nil
     "M-M"        'nil
     "M-N"        'nil
     "M-j"        'nil
     "M-q"        'nil
     "M-M"        'c-end-of-defun
     "M-N"        'c-beginning-of-defun
     "M-e"        'nil))

  (eab/add-hook ruby-mode-hook eab/ruby-hook
    (general-define-key
     :keymaps 'ruby-mode-map
     "C-d"        eab/compile-map
     "C-M-b"      'nil))

  (eab/add-hook graphviz-dot-mode-hook eab/graphviz-hook
    (general-define-key
     :keymaps 'graphviz-dot-mode-map
     "C-d"        eab/compile-map)
    (set (make-local-variable 'compile-command) nil)))

(use-package typescript-mode)
(use-package idle-highlight-mode) ;; + no melpa

(use-package bbdb
  :load-path "~/.emacs.d/private/eab-spacemacs/local/bbdb/lisp"
  :config
  (setq bbdb-file (eab/config (concat user-emacs-directory "eab-private/.bbdb")))
  (bbdb-initialize 'gnus 'message 'sc) ;; 'w3m)
  (setq bbdb-north-american-phone-numbers-p nil))
(use-package bbdb-loaddefs)
(use-package bbdb-anniv)

(use-package ansible-vault
  :config
  (setq ansible-vault-pass-file (eab/config "/home/eab/.ansible/passwd_cc"))
  (setq ansible-vault-pass-file (eab/config "/home/eab/.ansible/passwd_fz"))
  (with-temp-buffer (ansible-vault-mode))
  (add-hook 'ansible-vault-mode-hook (lambda () (setq indent-tabs-mode nil)))
  (add-to-list 'auto-mode-alist '("/keys.yml" . ansible-vault-mode)))

(use-package python
  :config
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (autoload 'python-mode "python-mode" "Python Mode." t)
  (add-hook 'python-mode-hook
            (lambda ()
              (general-define-key
               :keymaps 'python-mode-map
               "C-d"        eab/compile-map
               "C-j"        'nil
               "M-RET"      'newline
               "RET"        'newline))))

(use-package go-mode
  :config
  (add-hook 'go-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (setq-local tab-width 2)
              ))
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))

(use-package groovy-mode
  :config
  (eab/add-hook groovy-mode-hook eab/groovy-hook
    (general-define-key
     :keymaps 'groovy-mode-map
     "C-i"        'eab/outline-toggle-children
     "<backtab>"  'eab/outline-toggle-all))
  (add-hook 'groovy-mode-hook (lambda () (setq indent-tabs-mode nil))))

(use-package comint
  :config
  (add-hook 'ielm-mode-hook (lambda () (setq comint-process-echoes nil)))
  (add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))
  (general-define-key
   :keymaps 'comint-mode-map
   "M-p"        'comint-previous-matching-input-from-input
   "M-n"        'comint-next-matching-input-from-input
   "C-M-n"      'comint-next-input
   "C-M-p"      'comint-previous-input
   "M-s"        'nil
   "M-p"        'nil
   "M-n"        'nil
   "M-r"        'nil
   "C-p"        'comint-previous-input
   "C-n"        'comint-next-input))

(use-package consult-omni
  :load-path "~/.emacs.d/private/eab-spacemacs/local/consult-omni"
  :init
  (add-to-list 'load-path (eab/config (concat eab-spacemacs-path "local/consult-omni/sources")))
  :config
  (setq consult-omni-multi-sources '("DuckDuckGo API")))

(use-package ssh-config-mode
  :config
  (eab/add-hook ssh-config-mode-hook eab/ssh-config-hook
    (general-define-key
     :keymaps 'ssh-config-mode-map
     "C-i"        'eab/outline-toggle-children
     "<backtab>"  'eab/outline-toggle-all))
  (add-to-list 'auto-mode-alist '("/\\.ssh/config\\'"     . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/sshd?_config\\'"      . ssh-config-mode))
  (add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
  (add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode)))

(use-package textile-mode
  :config
  (eab/add-hook textile-mode-hook eab/textile-hook
    (general-define-key
     :keymaps 'textile-mode-map
     "C-i"        'eab/outline-toggle-children
     "<backtab>"  'eab/outline-toggle-all))
  (add-hook 'textile-mode-hook (lambda () (toggle-truncate-lines -1)))
  (add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
  (set-face-foreground 'textile-link-face "deep sky blue")
  (set-face-foreground 'textile-code-face "ivory4")
  (set-face-foreground 'textile-style-face "orange red")
  (set-face-foreground 'textile-ul-bullet-face "deep sky blue"))

(use-package yaml-mode
  :config
  (eab/add-hook yaml-mode-hook eab/yaml-hook
    (general-define-key
     :keymaps 'yaml-mode-map
     "C-i"        'eab/outline-toggle-children
     "<backtab>"  'eab/outline-toggle-all))
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))

(use-package markdown-mode
  :config
  (eab/add-hook markdown-mode-hook eab/markdown-hook
    (general-define-key
     :keymaps 'markdown-mode-map
     "C-M-b"      'nil
     "C-M-f"      'nil
     "M-l"        'nil
     "M-i"        'nil
     "M-n"        'nil
     "M-p"        'nil
     "<tab>"      'nil))
  (push '("\\.md\\'" . markdown-mode) auto-mode-alist)
  (add-hook 'markdown-mode-hook (lambda () (setq indent-tabs-mode nil)))
  (add-to-list 'auto-mode-alist
               '("stack\\(exchange\\|overflow\\)\\.com\\.[a-z0-9]+\\.txt"
                 . markdown-mode)))

(use-package so-long
    :config
    (global-so-long-mode 1))

(use-package restclient
  :config
  (add-to-list 'auto-mode-alist '("\\.redmine\\'" . restclient-mode)))

(use-package achievements
  :config
  (setq achievements-file (eab/config (concat (eab/history-dir) ".achievements"))))

(use-package keyfreq
  :config
  (setq keyfreq-file (eab/config (concat (eab/history-dir) ".emacs.keyfreq." system-name)))
  (setq keyfreq-file-lock (eab/config (concat (eab/history-dir) ".emacs.keyfreq.lock." system-name)))
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package puppet-mode
  :disabled
  :config
  (add-to-list 'auto-mode-alist '("\\.pp\\'" . puppet-mode)))

(use-package god-mode
  :disabled
  :config
  (setq god-mod-alist
        '(("g" . "C-")
          (nil . "M-")
          ("G" . "C-M-"))))

(use-package eab-gnus :disabled
  :config
  (add-hook 'gnus-summary-prepared-hook 'gnus-summary-hide-all-threads)
  (add-hook 'gnus-summary-prepare-hook 'gnus-summary-sort-by-most-recent-date))

(use-package cask
  :disabled
  :config
  (cask-initialize))

(use-package pallet
  :disabled
  :config
  (pallet-init))

(use-package ignoramus
  :disabled
  :config
  (ignoramus-setup))

(use-package auto-install
  :disabled
  :config
  (setq auto-install-directory
        (eab/config (concat user-emacs-directory "auto-install/"))))

(provide 'eab-config-mode)
