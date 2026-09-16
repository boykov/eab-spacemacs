;;; eab-config-region-bindings-mode.el --- eab-config region-bindings-mode configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package region-bindings-mode
  :after (eab-minimal)
  :config
  (region-bindings-mode-enable)
  ;; prevent annoying switching on rk in region-bindings-mode on set-mark-command
  (add-hook 'window-configuration-change-hook
            (lambda ()
              (if (and mark-active (not (use-region-p)))
                  (deactivate-mark))))
  (define-advice winner-undo (:before (&rest args) eab-winner-undo-before)
    (region-bindings-mode-disable))
  (define-advice winner-undo (:after (&rest args) eab-winner-undo-after)
    (region-bindings-mode-enable))
  (define-advice winner-redo (:before (&rest args) eab-winner-redo-before)
    (region-bindings-mode-disable))
  (define-advice winner-redo (:after (&rest args) eab-winner-redo-after)
    (region-bindings-mode-enable))
  (define-advice region-bindings-mode-on (:before (&rest args) eab-region-bindings-mode-on)
    (progn
      (setq region-bindings-mode-disabled-modes '(magit-status-mode magit-diff-mode))
      (general-define-key
       :keymaps 'region-bindings-mode-map
       "3"        'eab/gptel-one-shot-3
       "w"        (ilam (shell-command-on-region (region-beginning) (region-end) "wc -l"))
       "ц"        (ilam (shell-command-on-region (region-beginning) (region-end) "wc -l"))
       "u"        'untabify
       "г"        'untabify
       "s"        'sort-lines
       "ы"        'sort-lines
       "o"        'org-sort
       "щ"        'org-sort
       "c"        'copy-rectangle-as-kill
       "с"        'copy-rectangle-as-kill
       "v"        'yank-rectangle
       "м"        'yank-rectangle
       "0"        (ilam (eab/or-self-insert-body (er/expand-region 0)))
       "p"        (ilam (eab/or-self-insert-body (er/expand-region 1)))
       "-"        (ilam (eab/or-self-insert-body (er/expand-region -1)))
       "P"        (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (org-mark-paragraph))))
       "З"        (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (org-mark-paragraph))))
       "I"        (ilam (eab/or-self-insert 'indent-region))
       "Ш"        (ilam (eab/or-self-insert 'indent-region))
       "d"        (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-defun))))
       "/"        (ilam (let ((this-command 'ergoemacs-toggle-letter-case)) (eab/or-self-insert 'ergoemacs-toggle-letter-case)))
       "r"        (ilam (eab/or-self-insert 'string-rectangle))
       "к"        (ilam (eab/or-self-insert 'string-rectangle))
       "t"        'nil
       ;; TODO: C-g неправильно работает с region-bindings-mode
       ;; "C-g"   (ilam (eab/or-self-insert 'mc/keyboard-quit))
       "g"        (ilam (eab/or-self-insert 'mc/keyboard-quit))
       "п"        (ilam (eab/or-self-insert 'mc/keyboard-quit))
       "G"        'google-region
       "П"        'google-region
       "l"        (ilam (eab/or-self-insert 'eab/replace-selection))
       "д"        (ilam (eab/or-self-insert 'eab/replace-selection))
       "R"        (ilam (eab/or-self-insert 'eab/replace-newline-by-space))
       "К"        (ilam (eab/or-self-insert 'eab/replace-newline-by-space))
       "e"        'mc/edit-lines
       "у"        'mc/edit-lines
       "x"        (ilam (eab/or-self-insert 'kill-rectangle))
       "ч"        (ilam (eab/or-self-insert 'kill-rectangle))
       "A"        (ilam
                   (eab/or-self-insert-body
                    (save-restriction
                      (narrow-to-region (window-start) (window-end))
                      (ignore-errors (mc/mark-all-like-this)))))
       "D"        'ansible-vault-decrypt-region
       "E"        'ansible-vault-encrypt-region
       "a"        'mc/mark-all-like-this
       "i"        'mc/mark-previous-like-this
       "ш"        'mc/mark-previous-like-this
       "k"        'mc/mark-next-like-this
       "л"        'mc/mark-next-like-this
       "C-c C-c"  'org-toggle-checkbox
       "m"        'mc/mark-more-like-this-extended))))
