;;; eab-config-projectile.el --- eab-config projectile configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package projectile
  :after (eab-minimal eab-workgroups2)
  :config
  (general-define-key
   :prefix "C-a"
   "f"            'projectile-switch-project
   "F"            'projectile-discover-projects-in-directory
   )
  (setq projectile-require-project-root t)
  (setq projectile-per-project-compilation-buffer t)
  (eab/bind-path projectile-known-projects-file)
  (setq projectile-project-root-files-bottom-up
        '(".git"                      ; Git VCS root dir
          ".projectile"               ; projectile project marker
          ".hg"                       ; Mercurial VCS root dir
          ".fslckout"                 ; Fossil VCS root dir
          ".bzr"                      ; Bazaar VCS root dir
          "_darcs"                    ; Darcs VCS root dir
          ))
  (puthash (eab/config "/home/eab/git/eab-system/portal/")
           (make-ring 256)
           projectile-project-command-history)
  (ring-insert
   (projectile--get-command-history (eab/config "/home/eab/git/eab-system/portal/"))
   (eab/config "make deploy-config li=\"--limit chronos,cyclos\""))
  (ring-insert
   (projectile--get-command-history (eab/config "/home/eab/git/eab-system/portal/"))
   (eab/config "make deploy-anexp li=\"--limit chronos,kairos\" aa=\"\""))
  )
