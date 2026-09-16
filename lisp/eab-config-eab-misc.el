;;; eab-config-eab-misc.el --- eab-config eab-misc configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package org-depend
  :after (org))
(use-package power-macros
  :after (eab-config-term) ;; keybindings.el C-l vs eab-pmacros.el
  :config
  (eab/bind-path pm-macro-files)
  (eab/bind-path power-macros-file)
  (if (file-exists-p power-macros-file)
      (load power-macros-file))
  (defun eab/pm-write-last-kbd-macro (name)
    (interactive "MName of macro: ")
    (with-temp-buffer
      (insert (format "

(pm-def-macro
 '%s
 nil nil
 \"\"
 %s)
" name (prin1-to-string (concat "C-l C-k " (format-kbd-macro)))))
      (write-region (point-min) (point-max) power-macros-file t)))
  (defun eab/pm-set-last-kbd-macro ()
    (interactive)
    (setq last-kbd-macro
          (copy-sequence
           (symbol-function
            (intern
             (ido-completing-read "Macro: "
                                  (mapcar
                                   (lambda (x) (symbol-name x))
                                   (pm-get-available-macros)))))))))

;; dired+ нужен для привычной подсветки
(use-package dired+
  :init
  (setq diredp-hide-details-initially-flag nil))
(use-package dired-details)
(use-package alossage)
(use-package shell-command-queue)
(use-package one-key)
(use-package json-pretty-print)
(use-package rec-mode)

(use-package color-moccur)
(use-package moccur-edit)
(eab/add-hook moccur-mode eab/moccur-hook
  (general-define-key
   :keymaps 'moccur-mode-map
   "M-n"        'nil
   "M-p"        'nil
   "M-m"        'nil
   "M-d"        'nil))

(use-package smart-operator)
(use-package ido-better-flex)
(use-package ox-extra
  :after (org))

(defun multi-occur-in-all-buffers ()
  "Show all lines matching REGEXP in all buffers."
  (interactive)
  (multi-occur
   (buffer-list)
   (car (occur-read-primary-args))))

(add-hook 'maplev-mode-hook
          (lambda ()
            ;;            (smart-operator-mode-on)
            (general-define-key
             :keymaps 'maplev-mode-map
             "C-c d"      'maplev-help-at-point
             "C-k"        'toggle-input-method)
            (setq maplev-mint-start-options (list "-q" "-P"))
            (setq maplev-executable-alist '(("11" "maple" nil "maple")
                                            ("10" "maple" nil "mint")))))

(autoload 'cmaple "maplev" "Start maple process" t)
(autoload 'emaxima-mode "emaxima" "EMaxima mode" t)
(autoload 'maplev-mode "maplev" "Maple editing mode" t)
(autoload 'maxima "maxima" "Running Maxima interactively" t)
(autoload 'maxima-mode "maxima" "Maxima editing mode" t)
(add-to-list 'auto-mode-alist '("\\.max\\'" . maxima-mode))
(add-to-list 'auto-mode-alist '("\\.mpl\\'" . maplev-mode))
(add-to-list 'load-path (eab/bind-path eab/emaxima-path))
(add-hook 'maxima-mode-hook 
          (lambda ()
            (general-define-key
             :keymaps 'maxima-mode-map
             "C-M-a"      'nil
             "C-M-b"      'nil
             "C-M-e"      'nil
             "C-M-f"      'nil
             "M-;"        'nil
             "C-d"        eab/compile-map
             "M-h"        'nil)))

(eab/add-hook proced-mode-hook eab/proced-hook
  (general-define-key
   :keymaps 'proced-mode-map
   "O"  'top))
(use-package top-mode
  :after (eab-minimal)
  :config
  (define-advice top-mode (:after (&rest args) eab-top-mode-after)
    (general-define-key
     :keymaps 'top-mode-map
     "O"  (ilam (switch-to-buffer "*Proced*")))))
