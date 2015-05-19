;;; packages.el --- eab Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar eab-spacemacs-packages
  '(
    key-chord
    auto-dictionary
    page-break-lines
    edit-list
    workgroups2
    projectile
    async
    ergoemacs-mode
    ;; package eab-spacemacss go here
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar eab-spacemacs-excluded-packages '()
  "List of packages to exclude.")

(defun eab-spacemacs/init-ergoemacs-mode ()
  (use-package ergoemacs-mode))

(defun eab-spacemacs/init-auto-dictionary ()
  (use-package auto-dictionary))

(defun eab-spacemacs/init-key-chord ()
  (use-package key-chord
	       :init
	       (setq key-chord-two-keys-delay 0.05)))

(defun eab-spacemacs/init-async ()
  (use-package async))

(defun eab-spacemacs/init-projectile ()
  (use-package projectile
	       :init
	       (setq projectile-require-project-root t)
	       ))

(defun eab-spacemacs/init-page-break-lines ()
  (use-package page-break-lines
	       :init
	       ))

(defun eab-spacemacs/init-edit-list ()
  (use-package edit-list
	       :config
	       (progn
		 )))

(defun eab-spacemacs/init-workgroups2 ()
  (use-package workgroups2
	       :config
	       (progn
		 )))

;; For each package, define a function eab/init-<package-eab>
;;
;; (defun eab-spacemacs/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
