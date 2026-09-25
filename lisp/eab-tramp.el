;;; eab-tramp.el --- eab tramp extension  -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(use-package tramp
  :config
  (setq tramp-default-method "ssh")
  (setq tramp-show-ad-hoc-proxies 't)
  (setq tramp-persistency-file-name (eab/config (concat (eab/history-dir) "tramp"))))


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

(defun eab/singularity (dir)
      `("singularity"
        (tramp-login-program      "sudo /opt/soft/singularity/2.4/bin/singularity shell ")
        (tramp-login-args         (("--writable") (,(concat dir "%h"))))
        (tramp-remote-shell       "/bin/sh")
        (tramp-remote-shell-args  ("-i" "-c"))))

(with-eval-after-load 'tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'tramp-methods eab/sussh)
  (add-to-list 'tramp-methods (eab/singularity "`pwd`/")))

(provide 'eab-tramp)
