;;; config.el --- Spacemacs Layer configuration File -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defmacro eab/config (&rest body)
  `(eval ,@body))

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'load-path (concat eab-spacemacs-path "lisp"))
(add-to-list 'load-path (concat eab-spacemacs-path "features"))

(defvar eab/first-emacsclient 't "nil if run again")
(defvar eab/ssh-host (eab/config "ssh -o ConnectTimeout=10 kairos") "current host")

(defmacro eab/add-hook (hookname funcname &rest body)
  "add-hook with lambda progn"
  (declare (indent defun))
  `(progn (add-hook ',hookname ',funcname)
          (defun ,funcname ()
            (progn ,@body))))

(defun eab/update-site ()
  (shell-command
   (eab/config (concat "ssh chronos" " <<'END'
sudo docker exec eab-node bash -c \"cd ~/pub/eab-kb/js && node update-client.js\"
END"))))

(defun display-startup-echo-area-message ()
  "Change the default welcome message of minibuffer to another one."
  (message (with-current-buffer (get-buffer-create "*spacemacs*")
             (buffer-substring-no-properties (point-min) (point-max))))
  (message "Spacemacs is ready."))

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
'((setq org-fold-core-style 'overlays))

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and
             (buffer-file-name)
             (file-exists-p (buffer-file-name))
             (not (buffer-modified-p)))
        (revert-buffer t t t))))
  (message "Refreshed open files."))

(if (eab/ondaemon (eab/server-C))
    (progn
      (setq server-port 5001)
      (setq server-use-tcp 't)))

(if (eab/ondaemon (eab/server-P))
    (progn
      (setq server-port 5001)
      (setq server-use-tcp 't)))

;; (if (eab/ondaemon (eab/server-C))
;;     (setq debug-on-error 't))
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

(defun eab/desktop-dir ()
  (eab/history-dir))

(eab/config
 (cond ((eab/onhost "kairos-emacs")    (setq eab/ssh-host-local "ssh -o ConnectTimeout=10 kairos"))
       ((eab/onhost "kairos-clocksum")  (setq eab/ssh-host-local "ssh -o ConnectTimeout=10 kairos"))
       ((eab/onhost "chronos-clocksum") (setq eab/ssh-host-local "ssh -o ConnectTimeout=10 chronos"))
       ((eab/onhost "chronos-emacs")(setq eab/ssh-host-local "ssh -o ConnectTimeout=10 chronos"))
       ((eab/onhost "cyclos-emacs") (setq eab/ssh-host-local "ssh -o ConnectTimeout=10 cyclos"))
       (t (setq eab/ssh-host-local eab/ssh-host))))

;; DONE: почему не срабатывает exclude для ссылок?
;; из-за распределенности? копируется не оттуда, откуда ожидаю? задержка st?
(defun eab/rsync-org-directory (&optional from-host)
  (unless from-host
    (setq from-host ""))
  (shell-command
   (eab/config
    (concat eab/ssh-host-local
            " rsync --delete -avzl --no-links --exclude \".git\" --exclude \"gen\" "
            from-host "~/git/org-chronos/ " org-directory))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; DONE: auto-save и торможение при C-s
(defconst emacs-tmp-dir
  (format "%s/%s%s/"
          (concat (eab/history-dir) "backup")
          (concat "emacs" eab/daemon-name)
          (user-uid)))

(ignore-errors (make-directory emacs-tmp-dir))
 
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

(use-package eab-notify)
