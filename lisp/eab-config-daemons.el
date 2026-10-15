;;; eab-config-daemons.el --- eab-config daemons configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package docker)
(use-package docker-container
  :after (docker)
  :config
  (general-define-key
   :keymaps 'eab/one-key-map
   "C"    'docker-containers
   "I"    'docker-images)
  (defun eab/tramp-docker-cleanup ()
    (interactive)
    (tramp-cleanup-connection
     (tramp-dissect-file-name
      ;; TODO: tramp default-directory path
      (concat "/docker:"
              (car (progn
                     (docker-utils-get-marked-items-ids))) ":"))))
  (general-define-key
   :keymaps 'docker-container-mode-map
   "c"  'eab/tramp-docker-cleanup))

(use-package daemons
  :config
  (setq daemons-init-system-submodules '(daemons-systemd)))

(use-package daemons-systemd
  :after (daemons)
  :config
  (general-define-key
   :keymaps 'eab/one-key-map
   "d c"  `(:def ,(ilam-no-def
                   (setq eab/daemons-host "chronos")
                   (call-interactively 'eab/daemons))
                 :which-key "(c)hronos")
   "d k"  (ilam (setq eab/daemons-host "kairos") (call-interactively 'eab/daemons))
   "d y"  (ilam (setq eab/daemons-host "cyclos") (call-interactively 'eab/daemons))
   )
  (defun daemons-systemd--cmd ()
    "Appends `--user' to the `systemctl' call if `daemons-systemd-is-user' is set"
    (if daemons-systemd-is-user
        ". /tmp/lib.sh; cache_cmd_filter 30000 systemctl --user"
      ". /tmp/lib.sh; cache_cmd_filter 30000 systemctl"))
  (defun daemons-systemd-toggle-user ()
    "Toggle showing of user services"
    (interactive)
    (setq daemons-systemd-is-user (not daemons-systemd-is-user))
    (if daemons-systemd-is-user
        (setq default-directory
              (concat "/scp:" eab/daemons-host ":/home/eab/")))
    (if (not daemons-systemd-is-user)
        (setq default-directory
              (concat "/scp:" eab/daemons-host "|sudo:root@" eab/daemons-host ":/home/eab/")))
    (revert-buffer))
  (defun eab/daemons-restart ()
    (interactive)
    (let ((name (daemons--daemon-at-point)))
      (async-start
       `(lambda ()
          (add-to-list 'load-path "/home/eab/.emacs.d/elpa/daemons-20250514.1107")
          (require 'daemons)
          (setq daemons-init-system-submodules '(daemons-systemd))
          (require 'daemons-systemd)
          (with-output-to-string
            (let ((default-directory ,default-directory)
                  (daemons-systemd-is-user ,daemons-systemd-is-user))
              (daemons--run 'restart ,name))))
       (lambda (result)))))
  (define-key daemons-mode-map (kbd "R") 'eab/daemons-restart)
  (defun eab/daemons ()
    (interactive)
    (shell-command (concat "scp ~/git/auto/lib.sh " eab/daemons-host ":/tmp/lib.sh"))
    (let* ((default-directory
            (concat "/scp:" eab/daemons-host "|sudo:root@" eab/daemons-host ":/home/eab/")))
      (progn
        (setq daemons-systemd-is-user nil)
        (daemons)))))
;; (let* ((eab/daemons-host "chronos") (default-directory (concat "/scp:" eab/daemons-host "|sudo:root@" eab/daemons-host ":/home/eab/"))) (progn (setq daemons-systemd-is-user nil) (daemons)))
;; (let* ((eab/daemons-host "chronos") (default-directory (concat "/scp:" eab/daemons-host ":/home/eab/"))) (progn (setq daemons-systemd-is-user 't) (daemons)))

(provide 'eab-config-daemons)
