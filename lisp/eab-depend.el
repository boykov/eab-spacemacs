;;; eab-depend.el --- 

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'view)
(require 'dbus)
(require 'log-edit)
(require 'top-mode)

(eab/bind-path savehist-file)
(savehist-mode 1)

(setq which-key-idle-delay 2)
(which-key-mode)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(setq ibuffer-formats '((mark modified read-only " "
                              (name 18 18 :left :elide))
                        (mark modified read-only " " (name 18 18 :left :elide) " "
                              (size 9 -1 :right) " " (mode 16 16 :left :elide) " " filename-and-process)))

(eab/bind-path eshell-history-file-name)

(setq 
 history-length 500
 kill-ring-max 500
 eshell-history-size 1000
 )

(setq max-lisp-eval-depth 10000)

(require 'epa)
(require 'epg)
(require 'epa-file)
(epa-file-enable)
(setq epa-file-select-keys 'silent) 
(setenv "GPG_AGENT_INFO" nil) ; use gpg without gui window
(setq epg-gpg-program "gpg")
(setq epa-pinentry-mode 'loopback)

(require 'comint)

(setq explicit-bash-args '("--noediting" "-i"))
(if (file-exists-p "/bin/bash") (setq shell-file-name "/bin/bash"))

(require 'nnir)

(require 'smtpmail-async)

(require 'ps-print)
(require 'ps-mule)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               __  __           _           
;;              |  \/  | ___   __| | ___  ___ 
;;              | |\/| |/ _ \ / _` |/ _ \/ __|
;;              | |  | | (_) | (_| |  __/\__ \
;;              |_|  |_|\___/ \__,_|\___||___/
;;                                            
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.cu\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.dired$" . dired-virtual-mode))
(add-to-list 'auto-mode-alist '("\\.tmpl$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("AUTOEXEC\\." . 'bat-mode))
(add-to-list 'auto-mode-alist '("CONFIG\\." . 'bat-mode))
(add-to-list 'auto-mode-alist '("\\.cuf\\'" . f90-mode))
(add-to-list 'auto-mode-alist '("\\.F90\\'" . f90-mode))
(add-to-list 'auto-mode-alist '("\\.[bB][aA][tT]$" . 'bat-mode))
(add-to-list 'auto-mode-alist '("\\.ahk$" . ahk-mode))
(add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode))
(add-to-list 'auto-mode-alist '("\\.lsp\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.max\\'" . maxima-mode))
(add-to-list 'auto-mode-alist '("\\.mpl\\'" . maplev-mode))
(add-to-list 'auto-mode-alist '("\\.rtf\\'" . rtf-mode))
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))

(add-to-list 'load-path (eab/bind-path eab/emaxima-path))

(autoload 'rtf-mode "rtf-mode" "RTF" t)
(autoload 'ahk-mode "ahk-mode")
(autoload 'bat-mode "bat-mode" "DOS and WIndows BAT files" t)
(autoload 'cmaple "maplev" "Start maple process" t)
(autoload 'ebib "ebib" "Ebib, a BibTeX database manager." t)
(autoload 'emaxima-mode "emaxima" "EMaxima mode" t)
(autoload 'maplev-mode "maplev" "Maple editing mode" t)
(autoload 'maxima "maxima" "Running Maxima interactively" t)
(autoload 'maxima-mode "maxima" "Maxima editing mode" t)

(defalias 'perl-mode 'cperl-mode)
(setq cperl-extra-newline-before-brace t
      cperl-brace-offset              -2
      cperl-merge-trailing-else        nil)

(add-hook 'ielm-mode-hook (lambda () (setq comint-process-echoes nil)))
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))

(provide 'eab-depend)
