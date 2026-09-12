;;; eab-daemons.el --- eab daemons configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package daemons
  :config
  (setq daemons-init-system-submodules '(daemons-systemd)))
(use-package daemons-systemd
  :after (daemons)
  :config
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
              (concat "/ssh:" eab/daemons-host ":/home/eab/")))
    (if (not daemons-systemd-is-user)
        (setq default-directory
              (concat "/ssh:" eab/daemons-host "|sudo:root@" eab/daemons-host ":/home/eab/")))
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
            (concat "/ssh:" eab/daemons-host "|sudo:root@" eab/daemons-host ":/home/eab/")))
      (progn
        (setq daemons-systemd-is-user nil)
        (daemons)))))
;; (let* ((eab/daemons-host "chronos") (default-directory (concat "/ssh:" eab/daemons-host "|sudo:root@" eab/daemons-host ":/home/eab/"))) (progn (setq daemons-systemd-is-user nil) (daemons)))
;; (let* ((eab/daemons-host "chronos") (default-directory (concat "/ssh:" eab/daemons-host ":/home/eab/"))) (progn (setq daemons-systemd-is-user 't) (daemons)))
