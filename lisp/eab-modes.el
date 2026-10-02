;;; eab-modes.el --- eab modes extension -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 _     _       _                 _
;;        __ _  __| | __| |     | |__   ___   ___ | | __
;;       / _` |/ _` |/ _` |_____| '_ \ / _ \ / _ \| |/ /
;;      | (_| | (_| | (_| |_____| | | | (_) | (_) |   <
;;       \__,_|\__,_|\__,_|     |_| |_|\___/ \___/|_|\_\
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add-hook

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
  (set (make-local-variable 'compile-command) nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               __  __           _           
;;              |  \/  | ___   __| | ___  ___ 
;;              | |\/| |/ _ \ / _` |/ _ \/ __|
;;              | |  | | (_) | (_| |  __/\__ \
;;              |_|  |_|\___/ \__,_|\___||___/
;;                                            
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.tmpl$" . conf-mode))
(add-to-list 'auto-mode-alist '("AUTOEXEC\\." . 'bat-mode))
(add-to-list 'auto-mode-alist '("CONFIG\\." . 'bat-mode))
(add-to-list 'auto-mode-alist '("\\.F90\\'" . f90-mode))
(add-to-list 'auto-mode-alist '("\\.[bB][aA][tT]$" . 'bat-mode))
(add-to-list 'auto-mode-alist '("\\.lsp\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.rtf\\'" . rtf-mode))
(add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode))
(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))
(add-to-list 'auto-mode-alist '("\\.spec\\|\\.spec\\.in" . rpm-spec-mode))
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."    . crontab-mode))
(add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode))

(autoload 'rtf-mode "rtf-mode" "RTF" t)
(autoload 'bat-mode "bat-mode" "DOS and WIndows BAT files" t)

(provide 'eab-modes)
