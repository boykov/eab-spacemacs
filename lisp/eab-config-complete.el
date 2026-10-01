;;; eab-config-complete.el --- eab-config complete configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; aka config workflow

(use-package edit-list
  :after (eab-minimal)
  :config
  (general-define-key
   "C-c e"        'eab/edit-list-at-point)
  (eab/search-word eab/edit-list-at-point "Edit-list at point" eab/edit-list-1 (word))
  (defun eab/edit-list-1 (word)
    (edit-list (intern word))))

(use-package autorevert
  :config
  (global-auto-revert-mode)
  (setq auto-revert-use-notify nil))

(use-package key-chord
  :config
  (setq key-chord-two-keys-delay 0.05)
  (add-hook 'term-mode-hook
            (lambda () (setq input-method-function 'key-chord-input-method))))

(use-package auto-complete
  :config
  (eab/add-hook auto-complete-mode-hook eab/ac-complete-mode-hook
    (general-define-key
     :keymaps 'ac-completing-map
     "\C-s"       'ac-isearch)
    (general-define-key
     :keymaps 'ac-complete-mode-map
     "M-c"        'ac-expand-common
     "M-k"        'ac-next
     "M-i"        'ac-previous)))
(use-package auto-complete-config)
(use-package mode-local)

(use-package eab-auto-complete
  :after (org auto-complete)
  :config
  (general-define-key
   "M-?"          'auto-complete
   "M-DEL"        'eab/completion-at-point
   "C-j"          'eab/completion-at-point)
  (setq ac-comphist-file (eab/config (concat (eab/history-dir) "ac-comphist.dat")))
  (defun eab/read-lines (file)
    "Return a list of lines of a file at at FPATH."
    (if (file-exists-p file)
        (with-temp-buffer
          (insert-file-contents file)
          (split-string (buffer-string) "\n" t))))
  (setq eab/american-english
        (eab/config '(eab/read-lines "/usr/share/dict/american-english")))
  (defvar-mode-local org-mode ac-auto-start nil)
  (defvar-mode-local org-mode ac-use-quick-help nil))

(use-package yasnippet
  :after (org)
  :config
  (general-define-key
   "C-c i"        'yas-expand)

  (setq yas-snippet-dirs '())
  ;; cd el-get && git clone https://github.com/AndreaCrotti/yasnippet-snippets
  (add-to-list 'yas-snippet-dirs (eab/config (concat eab-spacemacs-path "snippets")))

  (setq yas-key-syntaxes '("w_" "w_." "w_.()" "^ "))

  (defun yas-org-very-safe-expand ()
    (yas-minor-mode 't)
    (let ((yas-fallback-behavior 'return-nil))
      (yas-expand)))

  (add-hook 'org-mode-hook
            (lambda ()
              (make-variable-buffer-local 'yas-trigger-key)
              (setq yas-trigger-key [tab])
              (add-to-list 'org-tab-first-hook 'yas-org-very-safe-expand)
              (define-key yas-keymap [tab] 'yas-next-field))))
(provide 'eab-config-complete)
