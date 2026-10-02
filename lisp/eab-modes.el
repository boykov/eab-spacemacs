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
