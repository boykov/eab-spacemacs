;;; eab-config-ediff.el --- eab-config ediff configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(eab/add-hook diff-mode-hook eab/diff-hook
  (general-define-key
   :keymaps 'diff-mode-map
   "M-SPC"      'nil
   "M-1"        'nil
   "M-2"        'nil
   "M-5"        'nil
   "M-k"        'nil
   "M-<"        'nil
   "M->"        'nil
   "M-K"        'nil
   "M-h"        'nil
   "M-n"        'nil
   "M-N"        'nil
   "M-o"        'nil
   "M-p"        'nil))

(use-package diff-hl)

(use-package ediff
  :config
  (eab/add-hook ediff-after-setup-control-frame-hook eab/ediff-hook
    (general-define-key
     :keymaps 'ediff-mode-map
     "d"  'nil))
  (defun eab/ediff-dired-directories ()
    (interactive)
    (when (= (length (window-list)) 2)
      (let ((dirs (mapcar
                   (lambda (w) 
                     (buffer-local-value 'default-directory (window-buffer w)))
                   (window-list))))
        (ediff-directories (car dirs) (cadr dirs) nil)))))

(use-package ediff-wind
    :after (ediff)
    :config
    (setq ediff-window-setup-function 'ediff-setup-windows-plain)
    (setq ediff-split-window-function 'split-window-horizontally))

(use-package ediff-diff
    :after (ediff)
    :config
    (setq ediff-diff-options "-w"))