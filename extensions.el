;;; extensions.el --- eab Layer extensions File for Spacemacs
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

(defvar eab-spacemacs-pre-extensions
  '(
    eab-misc
    ;; pre extension eabs go here
    )
  "List of all extensions to load before the packages.")

(defvar eab-spacemacs-post-extensions
  '(
    eab-dotemacs
    ;; post extension eabs go here
    )
  "List of all extensions to load after the packages.")


(defun eab-spacemacs/init-eab-misc ()
  ;; (add-to-list 'load-path (concat user-emacs-directory "private/eab/extensions/eab-misc"))
  (setq dotfiles-dir user-emacs-directory)
  (setq dotemacs-children-prefix dotfiles-dir)
  (load (concat dotfiles-dir "private/eab-spacemacs/extensions/eab-misc/dotemacs.el"))
  )

(defun eab-spacemacs/init-eab-dotemacs ()
  (dotemacs-load-children '("private/eab-spacemacs/extensions/eab-dotemacs/eab-packages-minimal"))
  (dotemacs-load-children '("private/eab-spacemacs/extensions/eab-dotemacs/eab-kbd")))


;; For each extension, define a function eab/init-<extension-eab>
;;
;; (defun eab-spacemacs/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
