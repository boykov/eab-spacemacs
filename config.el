;;; config.el --- Spacemacs Layer configuration File
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

;; ---------------------------------------------------------------------------
;; Prefixes
;; ---------------------------------------------------------------------------

(defun eab/loaded-ok ()
  (if (not configuration-layer-error-count)
      (kill-emacs)
    (progn
      (shell-command "echo > $HOME/dotemacs.error")
      (kill-emacs))))

(defun display-startup-echo-area-message ()
  "Change the default welcome message of minibuffer to another one."
  (message (with-current-buffer (get-buffer-create "*spacemacs*")
	     (buffer-substring-no-properties (point-min) (point-max))))
  (message "Spacemacs is ready."))
