;;; eab-depend-minimal.el --- 

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'log-edit)
;; (require 'ergoemacs-mode)

(setq eab/sudo
      '("sudo"
	(tramp-login-program        "sudo")
	(tramp-login-args           (("-u" "%u") ("-i") ("-H") ("-p" "Password:")))
	;; Local $SHELL could be a nasty one, like zsh or fish.  Let's override it.
	(tramp-login-env            (("SHELL") ("/bin/sh")))
	(tramp-remote-shell         "/bin/sh")
	(tramp-remote-shell-args    ("-c"))
	(tramp-connection-timeout   10)))

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

(defun eab/singularity ()
      `("singularity"
	(tramp-login-program      "sudo /opt/soft/singularity/2.4/bin/singularity shell ")
	(tramp-login-args         (("--writable") (,(concat eab/singularity-dir "%h"))))
	(tramp-remote-shell       "/bin/sh")
	(tramp-remote-shell-args  ("-i" "-c"))))

(eab/bind-path savehist-file)
(savehist-mode 1)

(require 'top-mode)

(which-key-mode)

(provide 'eab-depend-minimal)
