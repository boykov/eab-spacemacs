;;; config.el --- Spacemacs Layer configuration File
;;
;; Copyright (C) 2010-2022 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'load-path (concat eab-spacemacs-path "lisp"))

(defvar eab/first-emacsclient 't "nil if run again")
(defvar eab/ssh-host "ssh chronos" "current host")

;; Fix
(setq eab/suppress-greeting
      (substring (shell-command-to-string (concat eab/ssh-host " <<'END'
echo stub
END
" )) 0 -1))

;; (let ((server-use-tcp serverC-use-tcp))
;;     (server-eval-at (eab/server-C) 'eab/gotify-token))

(setq eab/gotify-token
      (substring (shell-command-to-string (concat eab/ssh-host " <<'END'
~/git/auto/keepass.sh \"portal/gotify\" -a app-test-token
END
" )) 0 -1))
(defun eab/gotify (title message priority)
  (shell-command
   (concat "curl \"http://192.168.2.18:8085/message?token=" eab/gotify-token "\" "
	   "-F \"title=" title
	   "\" -F \"message=" message
	   "\" -F \"priority=" (number-to-string priority) "\"")))
(setq eab/gotify-client-token
      (substring (shell-command-to-string (concat eab/ssh-host " <<'END'
~/git/auto/keepass.sh \"portal/gotify\" -a client-token
END
" )) 0 -1))
(setq eab/gotify-ws (concat "ws://192.168.2.18:8085/stream?token=" eab/gotify-client-token))
(setq eab/gotify-command
      (concat eab/ssh-host " 'sqlite3 -column /var/gotify/data/gotify.db \"select datetime(date,\\\"localtime\\\"),title,message from messages order by date desc limit 10;\"'"))

(setq eab/gr-command
      (concat eab/ssh-host " ~/bin/gr status"))

(setq eab/test-dotemacs-command
      (concat eab/ssh-host " ~/git/auto/test-dotemacs.sh"))

(setq eab/batch-publish-command
      (concat eab/ssh-host " ~/git/org/misc/batch-publish.sh"))

(setq eab/xdg-open (concat eab/ssh-host " DISPLAY=:0 xdg-open"))

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

(setq eab/homedir (getenv "HOME"))
(setq eab/daemon-name (daemonp))

(if (not (stringp eab/daemon-name))
    (setq eab/daemon-name "server"))

(defun eab/onhomedir (def)
  (if (string= eab/homedir def) 't))

(defun eab/ondaemon (def)
  (if (string= eab/daemon-name def) 't))

(defun eab/server-P ()
  (if (or (eab/ondaemon "serverP")
	  (eab/ondaemon "cyclos")
	  (eab/ondaemon "microcyclos"))
	  eab/daemon-name))

(defun eab/server-C ()
  "serverC")
(setq serverC-use-tcp 't)

;; TODO для многих патчей требуется одновременно несколько замен
;; значит, если продолжать в этом направлении, надо заменить пару
;; (regexp rep) на список пар
;; лучше использовать el-patch
(defun eab/patch-this-code (func-name regexp rep &optional lex)
  (let ((overriding-terminal-local-map (make-sparse-keymap)))
    (eval
     (read
      (replace-regexp-in-string
       regexp
       rep
       (save-window-excursion
	 (find-function-do-it func-name nil 'switch-to-buffer)
	 (let ((bgn (point)))
	   (forward-sexp)
	   (let ((end (point)))
	     (buffer-substring-no-properties bgn end)))))) lex)))

(if (eab/ondaemon (eab/server-C))
    (progn
      (setq server-port 5001)
      (setq server-use-tcp 't)))

;; (if (eab/ondaemon (eab/server-C))
;;     (setq debug-on-error 't))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar eab/paths-hash nil "symbol : value")

(setq eab/paths-hash (make-hash-table :test 'equal))

(defmacro setq-put (name value)
  `(puthash ',name ,value eab/paths-hash))

(defun eab/get-path (name)
  (gethash name eab/paths-hash))

(defmacro eab/bind-path (name)
  `(setq ,name (gethash ',name eab/paths-hash)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/read-lines (file)
  "Return a list of lines of a file at at FPATH."
  (if (file-exists-p file)
      (with-temp-buffer
	(insert-file-contents file)
	(split-string (buffer-string) "\n" t))))

(defun eab/onhost (def)
  (if (string= system-name def) 't))

(defun eab/history-dir ()
  (let ((dir
	 (cdr (assoc eab/daemon-name (gethash 'eab/history-dir-alist eab/paths-hash)))))
    (if (not (file-exists-p dir))
	(ignore-errors (make-directory dir)))
    dir))

(defun eab/desktop-dir ()
  (eab/history-dir))

(setq-put eab/history-dir-alist
	  `(
	    ("server"        . ,(concat user-emacs-directory "history/"))
	    ("serverM"       . ,(concat user-emacs-directory "historyM/"))
	    ("serverP"       . ,(concat user-emacs-directory "historyP/"))
	    ("microcyclos"   . ,(concat user-emacs-directory "historyMicrocyclos/"))
	    ("cyclos"        . ,(concat user-emacs-directory "historyCyclos/"))
	    (,(eab/server-C) . ,(concat user-emacs-directory "historyC/"))
	    ))

(setq-put eab/emacs-service-alist
	  `(
	    ("serverP"       . "docker-compose-emacs")
	    ("microcyclos"   . "docker-compose-micro")
	    ("cyclos"        . "cyclos-emacs")
	    (,(eab/server-C) . "docker-compose-clocksum")
	  ))

(cond ((eab/onhost "chronos28")    (setq eab/ssh-host-local eab/ssh-host))
      ((eab/onhost "clocksum-28")  (setq eab/ssh-host-local eab/ssh-host))
      ((eab/onhost "cyclos-emacs") (setq eab/ssh-host-local "ssh cyclos")))

(setq eab/emacs-service-command
      (concat
       eab/ssh-host-local
       " sudo systemctl restart "
       (cdr (assoc eab/daemon-name (gethash 'eab/emacs-service-alist eab/paths-hash)))))

;; TODO можно ли подобные настройки не считать "путями" и убрать из path?
(setq-put org-clock-persist-file (concat (eab/history-dir) "org-clock-save.el"))
(setq-put org-id-locations-file (concat (eab/history-dir) ".org-id-locations"))
(setq-put projectile-known-projects-file (concat (eab/history-dir) "projectile-bookmarks.eld"))
(setq-put eab/wg-path "~/git/eab-system/wg/*")

(if (eab/ondaemon (eab/server-P))
    (setq-put org-directory "~/git/org-chronos/")
  (setq-put org-directory "~/git/org/"))

(setq-put eab/org-publish-directory "~/pub/org/")
(setq-put eab/org-publish-directory-file "file:///home/eab/pub/org/")
(setq-put org-mobile-directory "~/Dropbox/MobileOrg")
(setq-put org-ditaa-jar-path "/usr/bin/ditaa")

(setq-put org-link-abbrev-alist
	  '(("bib" . "~/git/lit/boykov.bib::%s")
	    ("papers" . "https://share.homew.keenetic.pro/papers/%s.pdf")
	    ("google" . "http://www.google.com/search?q=")
	    ))
;; See also eab-header in ~/texmf/tex/latex/eab-styles/eab-header.sty


(defun eab/wg-update-list-1 (path)
  (let* ((true-path (file-truename path))
	 (nondir (file-name-nondirectory path))
	 (name nondir))
    `(,true-path ,name)))

(setq-put eab/workgroups-save (concat (eab/history-dir) ".emacs_workgroups"))
(setq-put wg-session-file (eab/bind-path eab/workgroups-save))


(setq-put ac-comphist-file (concat (eab/history-dir) "ac-comphist.dat"))
(setq-put save-place-file (concat (eab/history-dir) ".emacs-places"))
;; (setq-put eab/eab-workgroups (concat (eab/history-dir) "eab-workgroups"))
(setq-put savehist-file (concat (eab/history-dir) "history"))
(setq-put smex-save-file (concat (eab/history-dir) ".smex-items"))
(setq-put eab/trans-path "~/git/python/trans.py")
(setq-put eab/translate-path "~/bin/translate")

(setq-put eab/eeansi-path (expand-file-name "~/.eev/eeansi.sh"))
(setq-put eab/eegchannel-path (expand-file-name (concat eab-spacemacs-path "local/eev-current/eegchannel")))


(setq-put abbrev-file-name (concat (eab/history-dir) ".abbrev_defs"))
(setq-put ido-save-directory-list-file (concat (eab/history-dir) ".ido.last"))
(setq-put mc/list-file (concat (eab/history-dir) ".mc-lists.el"))
(setq-put pm-macro-files `(,(concat eab-spacemacs-path "lisp/eab-pmacros.el")))
(setq-put power-macros-file (concat eab-spacemacs-path "lisp/eab-pmacros.el"))
(setq-put reftex-default-bibliography '("~/git/lit/boykov.bib"))
(setq-put eab/secrets-path (concat user-emacs-directory "eab-private/eab-secrets.el.gpg"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cond ((eab/onhost "jonesbook")    (setq-put source-directory "~/emacs/src/emacs/")) ;; DONE old path
      ((eab/onhost "victory")      (setq-put source-directory "~/src/emacs/"))
      ((eab/onhost "kairos")       (setq-put source-directory "~/data/github/emacs/src"))
      ((eab/onhost "chronos")      (setq-put source-directory "~/data/github/emacs/src"))
      ((eab/onhost "chronos28")    (setq-put source-directory "~/git/eabmisc/eab-docker-emacs/emacs-28.1/src"))
      ((eab/onhost "cyclos-emacs") (setq-put source-directory "~/data/github/emacs/src")))


(setq-put custom-file (concat (eab/history-dir) "custom.el"))
(setq-put eab/emaxima-path (concat eab-spacemacs-path "local/eab-misc/emaxima"))

(setq-put auto-save-list-file-prefix (concat (eab/history-dir) "auto-save-list/.saves-"))

;; TODO auto-save и торможение при C-s
(defconst emacs-tmp-dir
  (format "%s/%s%s/"
	  (concat (eab/history-dir) "backup")
	  (concat "emacs" eab/daemon-name)
	  (user-uid)))

(ignore-errors (make-directory emacs-tmp-dir))

(setq-put backup-directory-alist `((".*" . ,emacs-tmp-dir)))
(setq-put auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))

(setq-put keyfreq-file (concat (eab/history-dir) ".emacs.keyfreq." system-name))
(setq-put keyfreq-file-lock (concat (eab/history-dir) ".emacs.keyfreq.lock." system-name))

(setq-put eab/check-cc-path "~/git/auto/check-cc.sh") ;; see eab-private/eab-secrets.el.gpg
(setq-put eab/check-inet-path "~/git/auto/check-inet.sh")
(setq-put eab/musicdb-path "~/data/dbs/media/music.db")
(setq-put eab/downloads-path "~/downloads/")

(setq-put eab/american-english (eab/read-lines "/usr/share/dict/american-english"))

(setq-put achievements-file (concat (eab/history-dir) ".achievements"))
(setq-put auto-install-directory (concat user-emacs-directory "auto-install/"))
(setq-put bbdb-file (concat user-emacs-directory "eab-private/.bbdb"))
(setq-put bibtex-files '("~/git/lit/boykov.bib"))
(setq-put bmkp-last-as-first-bookmark-file (concat (eab/history-dir) ".emacs.bmk"))
(setq-put bookmark-default-file (concat (eab/history-dir) ".emacs.bmk"))
(setq-put ebib-file-search-dirs '("~/git/lit/"))
(setq-put ebib-preload-bib-files '("~/git/lit/boykov.bib"))
(setq-put erc-log-channels-directory (concat (eab/history-dir) "logs/"))
(setq-put eshell-history-file-name "~/.bash_history")
(setq-put gnus-init-file (concat user-emacs-directory ".gnus"))
(setq-put gnus-startup-file (concat (eab/history-dir) ".newsrc"))
(setq-put helm-c-adaptative-history-file (concat (eab/history-dir) "helm-adaptive-history"))
(setq-put helm-locate-command (concat eab/ssh-host " plocate %s -e %s"))
(setq-put nnmail-message-id-cache-file (concat (eab/history-dir) ".nnmail-cache"))
(setq-put tramp-persistency-file-name (concat (eab/history-dir) "tramp"))
(setq-put url-configuration-directory (concat (eab/history-dir) "url/"))
(setq-put transient-history-file (concat (eab/history-dir) "transient/history.el"))
(setq-put recentf-save-file (concat (eab/history-dir) "recentf"))
(setq-put ansible-vault-pass-file "/home/eab/.ansible/passwd_cc")
(setq-put ansible-vault-pass-file "/home/eab/.ansible/passwd_fz")

(setq-put eab/yasnippets-path (concat eab-spacemacs-path "local/yasnippet-snippets"))
(setq-put eab/eab-snippets-path (concat eab-spacemacs-path "snippets"))
 
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))
