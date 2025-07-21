;;; eab-tramp.el --- eab tramp extension  -*- lexical-binding: t -*-

;; Copyright (C) 2010-2025 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(setq tramp-show-ad-hoc-proxies 't)

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

(provide 'eab-tramp)
