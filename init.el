;;; init.el --- eab Layer packages -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defconst eab-spacemacs-path (concat user-emacs-directory "private/eab-spacemacs/"))

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'load-path (concat eab-spacemacs-path "lisp"))
(add-to-list 'load-path (concat eab-spacemacs-path "features"))

;; (setq load-path (remove "/usr/local/share/emacs/31.1/lisp/org" load-path))

(require 'use-package)

(use-package eab-notify)
(use-package eab-server
  :after (eab-notify))
(use-package general)
(use-package eab-minimal
  :after (eab-server)
  :config
  (general-define-key
   "M-<"          'kmacro-start-macro
   "M-."          'kmacro-edit-macro
   "M-,"          'eab/kmacro-end-or-call-macro
   "C-x Q"        'eab/kbd-macro-query)
  )

(dolist
    (p
     (mapcar (lambda (x)
               (intern (replace-regexp-in-string
                        (concat eab-spacemacs-path "lisp/") ""
                        (replace-regexp-in-string ".el$" "" x))))
             (file-expand-wildcards (concat eab-spacemacs-path "lisp/eab-config-*.el"))))
  (eval `(use-package ,p
           :after (eab-minimal))))

(require 'server)
(unless (server-running-p) (server-start))
