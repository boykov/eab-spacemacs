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
    eab-dotemacs/lisp
    eab-ace-jump-mode
    eab-org-mode/lisp
    eab-org-mode/contrib/lisp ;; for htmlize.el
    eev-current
    bbdb/lisp
    org-link-minor-mode
    pymacs
    ;; pre extension eabs go here
    )
  "List of all extensions to load before the packages.")

(defvar eab-spacemacs-post-extensions
  '(
    ;; post extension eabs go here
    )
  "List of all extensions to load after the packages.")

(defun eab-spacemacs/init-pymacs ()
  )

(defun eab-spacemacs/init-org-link-minor-mode ()
  )

(defun eab-spacemacs/init-eev-current ()
  )

(defun eab-spacemacs/init-bbdb/lisp ()
  )

(defun eab-spacemacs/init-eab-misc ()
  )

(defun eab-spacemacs/init-eab-org-mode/lisp ()
  (require 'org)
  (require 'org-habit)
  (require 'org-id)
  (require 'org-agenda)
  (require 'org-clock)
  (require 'org-table)
  (require 'org-bbdb)
  (require 'org-element)
  (require 'ox)
  (require 'ob)
  (require 'ob-ditaa)
  (require 'ob-dot)
  (require 'ob-shell)
  (require 'ob-latex)
  (require 'ob-python)
  (require 'ob-makefile)
  (require 'ob-R)
  )

(defun eab-spacemacs/init-eab-org-mode/contrib/lisp ()
  (require 'htmlize)
  )

(defun eab-spacemacs/init-eab-dotemacs ()
  (use-package eab-kbd))

(defun eab-spacemacs/init-eab-dotemacs/lisp ()
  )

(defun eab-spacemacs/init-eab-dotemacs/lisp-1 ()
  (use-package eab-workgroups2)
  (use-package eab-ui-minimal)
  (use-package eab-shell)
  (use-package eab-shell-utils)
  (use-package eab-sauron)
  (use-package eab-yasnippet)
  (use-package eab-auctex)
  (use-package eab-postload-minimal)
  (use-package eab-depend-minimal)
  (use-package eab-window)
  (use-package eab-find-func)
  (use-package eab-workflow)
  (use-package eab-appt)
  (use-package eab-desktop)
  (use-package eab-words)
  (use-package eab-server)
  (use-package eab-git)
  (use-package eab-grep)
  (use-package eab-dired)
  (use-package eab-smex)
  (use-package eab-ido)
  (use-package eab-wmctrl)
  (use-package eab-ido-utils)
  (use-package eab-packages)
  (use-package eab-popwin)
  (use-package eab-miniframe)
  (use-package eab-compile)
  (use-package eab-browse)
  (use-package eab-sudo)
  (use-package eab-helm-anything)
  (use-package eab-greek-to-latex)
  (use-package eab-tags)
  (use-package eab-auto-complete)
  (use-package eab-ui)
  (use-package eab-ps)
  (use-package eab-auto-dictionary)
  (use-package eab-ace)
  (use-package eab-eepitch)
  (use-package eab-depend)
  (use-package eab-gnus)
  (use-package eab-twit)
  (use-package eab-postload)

  (use-package eab-org)
  (use-package eab-org-publish)
  (use-package eab-org-agenda)
  (use-package eab-org-protocol)
  (use-package eab-org-src-babel)
  (use-package eab-org-todo)
  (use-package eab-hron-lib)
  (use-package eab-org-latex)
  (use-package eab-org-reftex)
  )

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
