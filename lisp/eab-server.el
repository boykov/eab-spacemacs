;;; eab-server.el ---  eab server extension -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: none
;; Status: not intended to be distributed yet

(defmacro eab/config (&rest body)
  `(eval ,@body))

(setq eab/homedir (getenv "HOME"))
(setq eab/daemon-name (daemonp))

(unless (stringp eab/daemon-name)
  (setq eab/daemon-name "server"))

(defun eab/onhomedir (def)
  (if (string= eab/homedir def) 't))

(defun eab/ondaemon (def)
  (if (string= eab/daemon-name def) 't))

(defun eab/server-P ()
  (if (or (eab/ondaemon "kairosP")
          (eab/ondaemon "chronosP")
          (eab/ondaemon "cyclos")
          (eab/ondaemon "microcyclos"))
          eab/daemon-name))

(defun eab/server-C ()
  (if (or (eab/ondaemon "chronosC")
          (eab/ondaemon "kairosC"))
      eab/daemon-name))

(defun eab/target-C ()
  "chronosC")

(setq server-C-use-tcp 't)

;; serverM test-dotemacs doesn't use tcp
(if (or (eab/ondaemon (eab/server-C))
        (eab/ondaemon (eab/server-P)))
    (progn
      (setq server-port 5001)
      (setq server-use-tcp 't)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/onhost (def)
  (if (string= system-name def) 't))

(defun eab/history-dir ()
  (let ((dir
         (cdr
          (assoc eab/daemon-name
                 (eab/config
                  '`(
                     ("server"        . ,(concat user-emacs-directory "history/"))
                     ("serverM"       . ,(concat user-emacs-directory "historyM/"))
                     ("kairosP"       . ,(concat user-emacs-directory "historyP/"))
                     ("chronosP"      . ,(concat user-emacs-directory "historyChronosP/"))
                     ("microcyclos"   . ,(concat user-emacs-directory "historyMicrocyclos/"))
                     ("cyclos"        . ,(concat user-emacs-directory "historyCyclos/"))
                     ("chronosC"      . ,(concat user-emacs-directory "historyChronosC/"))
                     ("kairosC"       . ,(concat user-emacs-directory "kairosC/"))
                     ))))))
    (unless (file-exists-p dir)
      (ignore-errors (make-directory dir)))
    dir))

(defvar eab/ssh-host (eab/config "ssh -o ConnectTimeout=10 kairos") "current host")

(eab/config
 (cond ((eab/onhost "kairos-emacs")    (setq eab/ssh-host-local "ssh -o ConnectTimeout=10 kairos"))
       ((eab/onhost "kairos-clocksum")  (setq eab/ssh-host-local "ssh -o ConnectTimeout=10 kairos"))
       ((eab/onhost "chronos-clocksum") (setq eab/ssh-host-local "ssh -o ConnectTimeout=10 chronos"))
       ((eab/onhost "chronos-emacs")(setq eab/ssh-host-local "ssh -o ConnectTimeout=10 chronos"))
       ((eab/onhost "cyclos-emacs") (setq eab/ssh-host-local "ssh -o ConnectTimeout=10 cyclos"))
       (t (setq eab/ssh-host-local eab/ssh-host))))

(defun eab/eval-last-sexp-remote (server &optional use-tcp)
  "Evaluate sexp before point on SERVER; print value in minibuffer.
If USE-TCP is non-nil, bind `server-use-tcp' to USE-TCP.
When called interactively, USE-TCP is determined automatically for
known servers."
  (let ((sexp (call-interactively
               (lambda () (interactive) (preceding-sexp)))))
    (message "%s" (if use-tcp
                      (let ((server-use-tcp use-tcp))
                        (server-eval-at server `(eval ',sexp)))
                    (server-eval-at server `(eval ',sexp))))))

(defun eab/eval-last-sexp-kairos-C ()  (interactive) (eab/eval-last-sexp-remote "kairosC" server-C-use-tcp))
(defun eab/eval-last-sexp-kairos-P ()  (interactive) (eab/eval-last-sexp-remote "kairosP"))
(defun eab/eval-last-sexp-chronos-C () (interactive) (eab/eval-last-sexp-remote "chronosC" server-C-use-tcp))
(defun eab/eval-last-sexp-chronos-P () (interactive) (eab/eval-last-sexp-remote "chronosP"))
(defun eab/eval-last-sexp-server-M ()  (interactive) (eab/eval-last-sexp-remote "serverM"))

'((let ((server-use-tcp 't))
    (server-eval-at "kairosP" '(symbol-function 'eab/eval-last-sexp-server-M)))
  )

(provide 'eab-server)
