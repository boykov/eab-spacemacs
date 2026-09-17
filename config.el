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

'((let ((server-use-tcp server-C-use-tcp))
    (list (server-eval-at "chronosC" '(eab/gotify-token))
          (server-eval-at "chronosC" '(eab/gotify-client-token))
          (server-eval-at "kairosC" '(eab/gotify-token))
          (server-eval-at "kairosC" '(eab/gotify-client-token))))
  )

(defmacro eab/add-hook (hookname funcname &rest body)
  "add-hook with lambda progn"
  (declare (indent defun))
  `(progn (add-hook ',hookname ',funcname)
          (defun ,funcname ()
            (progn ,@body))))

(defvar eab/gotify-token-cache "" "")
(defun eab/gotify-token ()
  (if (not (equal (length eab/gotify-token-cache) 15))
      (setq eab/gotify-token-cache
            (substring (shell-command-to-string
                        (eab/config (concat eab/ssh-host " bash <<'END'
~/git/auto/keepass.sh \"portal/gotify\" -a app-test-token
END
" ))) 0 -1)))
  eab/gotify-token-cache)

;; TODO: not in eab/config due to async-start and args
;; maybe ,(eab/config ...)?
(defun eab/gotify (title message priority)
  (async-start
   `(lambda ()
      (call-process-shell-command
       (concat
        "/home/eab/git/auto/notify.sh -a " ,(eab/gotify-token)
        " -t \"" ,title "\""
        " -m \"" ,message "\""
        " -p " ,(number-to-string priority))) nil 0)))

(defvar eab/gotify-client-token-cache "" "")
(defun eab/gotify-client-token ()
  (if (not (equal (length eab/gotify-client-token-cache) 15))
      (setq eab/gotify-client-token-cache
            (substring
             (shell-command-to-string
              (eab/config (concat eab/ssh-host " bash <<'END'
~/git/auto/keepass.sh \"portal/gotify\" -a client-token
END
" ))) 0 -1)))
  eab/gotify-client-token-cache)
(setq eab/gotify-command
      (eab/config
       (concat
        "ssh kairos"
        " 'sqlite3 -column /var/gotify/data/gotify.db \"select datetime(date,\\\"localtime\\\"),title,message from messages order by date desc limit 20;\"'")))
;; (eab/gotify "test" "test" 0)

(setq eab/dl.sh-command
      (eab/config (concat "ssh chronos" " dl.sh ")))

(setq eab/test-dotemacs-command
      ;; host=`dig test-dotemacs.salmon.eab.su TXT +short | tr -d '"'`
      (eab/config (concat "ssh chronos" " ~/git/auto/test-dotemacs.sh")))

(defun eab/update-site ()
  (shell-command
   (eab/config (concat "ssh chronos" " <<'END'
sudo docker exec eab-node bash -c \"cd ~/pub/eab-kb/js && node update-client.js\"
END"))))

(defun eab/loaded-ok (instance)
  (if configuration-layer-error-count
      (progn
        (add-to-list 'mode-line-modes '(t " [ERROR] "))
        (eab/gotify instance "bad" 5))
    (progn
      (eab/gotify instance "OK" 0)
      (setq-default TeX-master t))))

(defun eab/test-dotemacs ()
  (eab/loaded-ok "test-dotemacs")
  (sleep-for 0.5)
  (kill-emacs))

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

(if (eab/ondaemon "cyclos")
    (progn
      (setq eab/sync-rsync-command
            (eab/config (concat "ssh cyclos"
                    " screen -d -m bash -c \"echo; "
                    "rsync -WavR --files-from=/home/eab/.emacs.d/historyCyclos/recentf-eabpool /mnt/lion/ kairos:/mnt/lion/; "
                    "rsync -WavR --files-from=/home/eab/.emacs.d/historyCyclos/recentf-eabpool /mnt/lion/ chronos:/mnt/lion/; "
                    "/home/eab/git/auto/notify.sh -a " (eab/gotify-token) " -t \"OK\" -m \"rsync\" -p 0; "
                    "\"")))
      (setq eab/sync-zfs-command
            (eab/config (concat "ssh cyclos" " screen -d -m bash -c \"echo; syncoid.sh chronos kairos\"")))))

(if (eab/ondaemon "chronosP")
    (progn
      (setq eab/sync-rsync-command
            (eab/config (concat "ssh cyclos"
                    " screen -d -m bash -c \"echo; "
                    "rsync -WavR --files-from=/home/eab/.emacs.d/historyCyclos/recentf-eabpool /mnt/lion/ kairos:/mnt/lion/; "
                    "rsync -WavR --files-from=/home/eab/.emacs.d/historyCyclos/recentf-eabpool /mnt/lion/ cyclos:/mnt/lion/; "
                    "/home/eab/git/auto/notify.sh -a " (eab/gotify-token) " -t \"OK\" -m \"rsync\" -p 0; "
                    "\"")))
      (setq eab/sync-zfs-command
            (eab/config (concat "ssh chronos" " screen -d -m bash -c \"echo; syncoid.sh cyclos kairos\"")))))

(if (eab/ondaemon (eab/server-C))
    (progn
      (setq server-port 5001)
      (setq server-use-tcp 't)))

(if (eab/ondaemon (eab/server-P))
    (progn
      (setq server-port 5001)
      (setq server-use-tcp 't)))

'((let ((server-use-tcp 't))
    (list (server-eval-at "kairosP" '(eab/gotify-token))
          (server-eval-at "kairosP" '(eab/gotify-client-token))))
  )


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

(defun eab/wg-update-list-1 (path)
  (let* ((true-path (file-truename path))
         (nondir (file-name-nondirectory path))
         (name nondir))
    `(,true-path ,name)))

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
