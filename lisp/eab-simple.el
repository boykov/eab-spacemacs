;;; eab-simple.el --- eab simple configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(column-number-mode 1)
(setq 
 mark-ring-max 64
 global-mark-ring-max 64
 indent-tabs-mode nil
 )
(eab/bind-path eshell-history-file-name)
(setq
 history-length 500
 kill-ring-max 500
 max-lisp-eval-depth 10000
 eshell-history-size 1000
 )
(mapc (lambda (x) (add-to-list 'extended-command-history x))
      '(
        "tramp-cleanup-this-connection"
        "eab/create-workgroups"
        "eab/clear-extended-history"
        "eab/load-personal"
        ))
(mapc (lambda (x) (add-to-list 'read-expression-history x))
      '(
        "(setq input-method-function 'key-chord-input-method)"
        "(tramp-term--initialize \"jupiter\")"
        ))
(use-package eab-shell
  :init
  (eab/bind-path eab/translate-path)
  (eab/bind-path eab/trans-path))
