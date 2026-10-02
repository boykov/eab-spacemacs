;;; eab-gr.el --- eab gr extension -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements: eab-compile eab-notify
;; Status: ready

(setq eab/gr-command
      (eab/config (concat eab/ssh-host-local " bash ~/bin/gr status")))
(setq eab/gr-buffer "*gr status*")
(setq eab/gr-ready? nil)
(setq eab/update-gr-command
      (eab/config (concat eab/ssh-host-local " bash ~/bin/gr @fz git fetch")))
(setq eab/check-gr-command
      (eab/config
       (concat eab/ssh-host-local " bash ~/bin/gr @fz ~/git/auto/gr-git-log.sh | wc -l")))

(defun eab/gr-status ()
  (interactive)
  (let* ((compilation-buffer-name-function
          `(lambda (mode) ,eab/gr-buffer)))
    (unless eab/gr-ready?
      (save-window-excursion
        (eab/compile eab/gr-command))
      (setq eab/gr-ready? 't))
    (eab/async-update-gr :recompile 't :notify 't)
    (switch-to-buffer eab/gr-buffer nil 't)))

(cl-defun eab/async-update-gr (&optional &key recompile notify)
  (let
      ((old-check (shell-command-to-string eab/check-gr-command)))
    (async-start
     `(lambda ()
        (with-temp-buffer
          (shell-command-to-string ,eab/update-gr-command))
        "@fz updated")
     `(lambda (result)
        (if ,recompile
            (save-window-excursion
              (switch-to-buffer eab/gr-buffer)
              (let ((compilation-buffer-name-function nil))
                (recompile))))
        (if ,notify
            (let ((fresh-check (shell-command-to-string eab/check-gr-command)))
              (if (not (equal ,old-check fresh-check))
                  (if (> (string-to-number fresh-check) 6)
                      (eab/gotify "fz" "updated" 5)))))
        (message "async result: <%s>" result)))))

(defun eab/update-gr-status-on-idle ()
  (if (not eab/gr-ready?)
      (progn
        (save-window-excursion (eab/gr-status))
        (sleep-for 3)))
  (eab/async-update-gr :recompile 't :notify 't))

(defun eab/gr-tag-default-directory ()
  (interactive)
  (shell-command (concat "gr +#emacs " default-directory)))

(provide 'eab-gr)

;;; eab-gr.el ends here
