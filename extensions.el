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
    eab-dotemacs
    eab-ace-jump-mode
    eab-org-mode/lisp
    eev-current
    bbdb
    el-expectations
    gnuplot-mode
    org-link-minor-mode
    pymacs
    wikipedia-mode
    ;; pre extension eabs go here
    )
  "List of all extensions to load before the packages.")

(defvar eab-spacemacs-post-extensions
  '(
    eab-dotemacs/lisp
    ;; post extension eabs go here
    )
  "List of all extensions to load after the packages.")


(defun eab-spacemacs/init-wikipedia-mode ()
  )

(defun eab-spacemacs/init-pymacs ()
  )

(defun eab-spacemacs/init-org-link-minor-mode ()
  )

(defun eab-spacemacs/init-gnuplot-mode ()
  )

(defun eab-spacemacs/init-el-expectations ()
  )

(defun eab-spacemacs/init-eev-current ()
  )

(defun eab-spacemacs/init-bbdb ()
  )

(defun eab-spacemacs/init-eab-misc ()
  )

(defun eab-spacemacs/init-eab-org-mode/lisp ()
  (require 'org)
  )

(defun eab-spacemacs/init-eab-dotemacs ()
  (use-package eab-kbd)
  (use-package eab-kbd-layer0))

(defun eab-spacemacs/init-eab-dotemacs/lisp ()
  (use-package eab-workgroups2)
  (use-package eab-ui-minimal)
  (use-package eab-shell)
  (use-package eab-shell-utils)
  (use-package eab-sauron)
  (use-package eab-org)
  (use-package eab-org-publish)
  (use-package eab-org-agenda)
  (use-package eab-org-protocol)
  (use-package eab-yasnippet)
  (use-package eab-org-src-babel)
  (use-package eab-org-todo)
  (use-package eab-hron-lib)
  (use-package eab-postload-minimal))

(defun eab-spacemacs/init-eab-ace-jump-mode ()
  (use-package ace-jump-mode))

;; For each extension, define a function eab/init-<extension-eab>
;;
;; (defun eab-spacemacs/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
