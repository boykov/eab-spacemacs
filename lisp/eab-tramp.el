;;; eab-tramp.el --- eab tramp extension  -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(defvar eab/sussh
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
    (tramp-default-port         22)) "")

(use-package tramp
  :config
  ;; Don't use elc with eab/config
  (setq tramp-persistency-file-name (eab/config (concat (eab/history-dir) "tramp")))
  ;; DONE: scp: ambiguous target add single quotes 'file name with spaces'
  ;; DONE: remote command continues execution (do with async)
  ;; (setq tramp-use-scp-direct-remote-copying 't)
  ;; (setq tramp-copy-size-limit nil)
  ;; (setq tramp-use-scp-direct-remote-copying nil)
  ;; (setq tramp-copy-size-limit 10240)
  (setq tramp-default-method "ssh")
  (defun eab/singularity (dir)
    `("singularity"
      (tramp-login-program      "sudo /opt/soft/singularity/2.4/bin/singularity shell ")
      (tramp-login-args         (("--writable") (,(concat dir "%h"))))
      (tramp-remote-shell       "/bin/sh")
      (tramp-remote-shell-args  ("-i" "-c"))))
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'tramp-methods eab/sussh)
  (add-to-list 'tramp-methods (eab/singularity "`pwd`/"))
  (setq tramp-show-ad-hoc-proxies 't))

(use-package tramp-term)
(use-package tramp-sh)
(use-package eab-patch-tramp
  :after (tramp-sh))

(provide 'eab-tramp)
