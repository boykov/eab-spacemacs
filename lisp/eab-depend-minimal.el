;;; eab-depend-minimal.el --- 

;; Copyright (C) 2010-2020 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'log-edit)
;; (require 'ergoemacs-mode)

(setq eab/sudo
      '("sudo"
	(tramp-login-program        "sudo")
	(tramp-login-args           (("-u" "%u") ("-i") ("-H") ("-p" "Password:")))
	;; Local $SHELL could be a nasty one, like zsh or fish.  Let's override it.
	(tramp-login-env            (("SHELL") ("/bin/sh")))
	(tramp-remote-shell         "/bin/sh")
	(tramp-remote-shell-args    ("-c"))
	(tramp-connection-timeout   10)))

(setq eab/sussh
      '("sussh"
	(tramp-login-program        "sudo ssh")
	(tramp-login-args           (("-l" "%u") ("-p" "%p") ("%c")
				     ("-e" "none") ("-t" "-t") ("%h") ("/bin/sh")))
	(tramp-async-args           (("-q")))
	(tramp-remote-shell         "/bin/sh")
	(tramp-remote-shell-args    ("-c"))
	(tramp-gw-args              (("-o" "GlobalKnownHostsFile=/dev/null")
				     ("-o" "UserKnownHostsFile=/dev/null")
				     ("-o" "StrictHostKeyChecking=no")))
	(tramp-default-port         22)))

(defun eab/singularity ()
      `("singularity"
	(tramp-login-program      "sudo /opt/soft/singularity/2.4/bin/singularity shell ")
	(tramp-login-args         (("--writable") (,(concat eab/singularity-dir "%h"))))
	(tramp-remote-shell       "/bin/sh")
	(tramp-remote-shell-args  ("-i" "-c"))))

(require 'undo-tree)
(global-undo-tree-mode)

(require 'paredit)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

(require 'projectile)
(setq projectile-require-project-root t)
(setq projectile-project-root-files-bottom-up
      '(".git"        ; Git VCS root dir
	".projectile" ; projectile project marker
	".hg"         ; Mercurial VCS root dir
	".fslckout"   ; Fossil VCS root dir
	".bzr"        ; Bazaar VCS root dir
	"_darcs"      ; Darcs VCS root dir
	))

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
;; emacs 28 bad
;; (define-minor-mode region-bindings-mode :lighter " rk" :group 'convenience)

(if (boundp 'mc--default-cmds-to-run-for-all) (setq mc--cmds mc--default-cmds-to-run-for-all))
;; TODO mc/cmds-to-run-for-all переназначается (sp-backward-sexp sp-forward-sexp)
(setq mc/cmds-to-run-for-all (append mc/cmds-to-run-for-all
				     '(org-delete-char
				       org-self-insert-command)))

(which-key-mode)

(provide 'eab-depend-minimal)
