;;; eab-test.el ---  -*- lexical-binding: t -*-

(helm :sources
      (helm-build-in-file-source
          "chronos-eab-history"
          "/ssh:chronos:/home/eab/.bash_history"))

(helm :sources
      (helm-build-in-file-source
          "fz-ls-root-history"
          "/ssh:fz-ls|sudo:fz-ls:/root/.bash_history"))

(defun eab/silly-loop (n)
  "Return the time, in seconds, to run N iterations of a loop."
  (let ((t1 (float-time)))
    (while (> (setq n (1- n)) 0))
    (- (float-time) t1)) )

(provide 'eab-test)