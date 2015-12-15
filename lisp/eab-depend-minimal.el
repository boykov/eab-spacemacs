;;; eab-depend-minimal.el --- 

;; Copyright (C) 2010, 2011, 2012, 2013, 2014 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'log-edit)
;; (require 'ergoemacs-mode)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'paredit)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

(require 'projectile)
(setq projectile-require-project-root t)

(require 'auto-install)
(eab/bind-path auto-install-directory)

(require 'smartparens) ;; fix boundp sp-keymap
(require 'smartparens-latex)
;; (smartparens-global-mode)

(setq sp-ignore-modes-list nil)

(eab/bind-path savehist-file)
(savehist-mode 1)

(require 'top-mode)

(require 'expand-region)
;; (require 'mark-more-like-this)
(require 'multiple-cursors) ;; fix mc/keymap
(eab/bind-path mc/list-file)

(require 'region-bindings-mode)
(region-bindings-mode-enable)
;; TODO fix the hack: why call it second time?
(define-minor-mode region-bindings-mode :lighter " rk" :group 'convenience)

(if (boundp 'mc--default-cmds-to-run-for-all) (setq mc--cmds mc--default-cmds-to-run-for-all))
;; TODO mc/cmds-to-run-for-all переназначается (sp-backward-sexp sp-forward-sexp)
(setq mc/cmds-to-run-for-all (append mc/cmds-to-run-for-all
				     '(org-delete-char
				       org-self-insert-command)))


(provide 'eab-depend-minimal)
