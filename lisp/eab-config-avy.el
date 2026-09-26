;;; eab-config-avy.el --- eab-config avy configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package avy
  :config
  (general-define-key
   "M-d"          'avy-goto-word-1)
  (setq avy-timeout-seconds 0.25))

(use-package ibuffer
  :config
  (setq ibuffer-formats
        '((mark modified read-only " "
                (name 18 18 :left :elide))
          (mark modified read-only " " (name 18 18 :left :elide) " "
                (size 9 -1 :right) " " (mode 16 16 :left :elide) " "
                filename-and-process)))
  (general-define-key
   :keymaps 'ibuffer-mode-map
   "C-d"        'nil
   "C-k"        'nil
   "C-o"        'nil
   "C-y"        'nil
   "M-g"        'nil
   "M-j"        'nil
   "M-n"        'nil
   "M-o"        'nil
   "M-p"        'nil
   "M-s"        'nil))

(use-package ace-jump-mode
  :init
  (evil-mode -1)
  :config
  (general-define-key
   :keymaps 'isearch-mode-map
   "M-d" 'eab/isearch-ace-jump)
  (setq ace-jump-mode-gray-background nil) ;; it is faster

  (defun eab/ace-ibuffer ()
    (interactive)
    (setq ido-exit 'eab-ido-exit)
    (exit-minibuffer))

  (defun eab/call-ibuffer ()
    (if (equal (buffer-name (current-buffer)) "*Ibuffer*")
        (ibuffer-visit-buffer)))

  (add-hook 'ace-jump-mode-end-hook 'eab/call-ibuffer)

  (defun eab/isearch-ace-jump ()
    "Invoke `ace-jump' from isearch within `current-buffer'."
    (interactive)
    (let ((case-fold-search isearch-case-fold-search)
          (isearch-buffer (current-buffer))
          (isearch-update-post-hook
           (lambda ()
             (interactive)
             (unless (equal isearch-string "")
               (isearch-exit)))))
      (isearch-exit)
      ;; TODO: ace -> avy
      (ace-jump-do (concat "\\b" isearch-string)))))