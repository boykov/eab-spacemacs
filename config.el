;;; config.el --- Spacemacs Layer configuration File
;;
;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'load-path (concat user-emacs-directory "private/eab-spacemacs/lisp"))


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
    (setq eab/daemon-name "serverP"))

(defun eab/onhomedir (def)
  (if (string= eab/homedir def) 't))

(defun eab/ondaemon (def)
  (if (string= eab/daemon-name def) 't))

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
	 (eval (cdr
		(assoc eab/daemon-name (gethash 'eab/history-dir-alist eab/paths-hash))))))
    (if (not (file-exists-p dir))
	(ignore-errors (make-directory dir)))
    dir))

(defun eab/desktop-dir ()
  (eab/history-dir))

(setq-put eab/history-dir-alist
	  '(
	    ("ea2b" . (concat user-emacs-directory "history2/"))
	    ("ghost" . (concat user-emacs-directory "history/"))
	    ("server" . (concat user-emacs-directory "history/"))
	    ("serverN" . (concat user-emacs-directory "historyN/"))
	    ("serverM" . (concat user-emacs-directory "historyM/"))
	    ("serverP" . (concat user-emacs-directory "historyP/"))
	    ("serverC" . (concat user-emacs-directory "historyC/"))
	    ))


;; TODO можно ли подобные настройки не считать "путями" и убрать из path?
(setq-put org-clock-persist-file (concat (eab/history-dir) "org-clock-save.el"))
(setq-put org-id-locations-file (concat (eab/history-dir) ".org-id-locations"))

(setq-put org-directory "~/git/org/")
(setq-put eab/org-publish-directory "~/pub/org/")
(setq-put eab/org-publish-directory-file "file:///home/eab/pub/org/")
(setq-put org-mobile-directory "~/Dropbox/MobileOrg")
(setq-put org-ditaa-jar-path "~/bin/ditaa0_9.jar")

(setq-put org-link-abbrev-alist
	  '(("bib" . "~/git/lit/boykov.bib::%s")
	    ("papers" . "~/pub/papers/%s.pdf")
	    ("google" . "http://www.google.com/search?q=")
	    ))
;; See also eab-header in ~/texmf/tex/latex/eab-styles/eab-header.sty

(setq-put eab/wg-path "~/git/auto/wg/*")

(setq-put eab/wg-update-list
	  '(("~/.emacs.d/" ":.emacs.d:")
	    ("~/git/org/" ":clock:")
	    ("~/git/org/clock/" ":clock:")
	    ("~/git/cc/" ":cc:")))

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
(setq-put eab/eegchannel-path (expand-file-name (concat user-emacs-directory "private/eab-spacemacs/local/eev-current/eegchannel")))


(setq-put abbrev-file-name (concat (eab/history-dir) ".abbrev_defs"))
(setq-put ido-save-directory-list-file (concat (eab/history-dir) ".ido.last"))
(setq-put mc/list-file (concat (eab/history-dir) ".mc-lists.el"))
(setq-put pm-macro-files `(,(concat user-emacs-directory "private/eab-spacemacs/lisp/eab-pmacros.el")))
(setq-put power-macros-file (concat user-emacs-directory "private/eab-spacemacs/lisp/eab-pmacros.el"))
(setq-put reftex-default-bibliography '("~/git/lit/boykov.bib"))
(setq-put eab/secrets-path (concat user-emacs-directory "eab-private/eab-secrets.el.gpg"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cond ((eab/onhost "jonesbook") (setq-put source-directory "~/emacs/src/emacs/")) ;; DONE old path
      ((eab/onhost "victory")   (setq-put source-directory "~/src/emacs/"))
      ((eab/onhost "kairos")   (setq-put source-directory "~/data/gitno/github/emacs/src"))
      ((eab/onhost "chronos")   (setq-put source-directory "~/data/gitno/github/emacs/src"))
      ((eab/onhost "cyclos")   (setq-put source-directory "~/data/gitno/github/emacs/src")))


(setq-put custom-file (concat user-emacs-directory "custom.el"))
(setq-put eab/emaxima-path (concat user-emacs-directory "private/eab-spacemacs/local/eab-misc/emaxima"))

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
(setq-put eab/twittering-mode (expand-file-name "~/.twittering-mode.gpg"))
(setq-put eab/twittering-modeN (expand-file-name "~/.twittering-modeN.gpg"))

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
(setq-put nnmail-message-id-cache-file (concat (eab/history-dir) ".nnmail-cache"))
(setq-put tramp-persistency-file-name (concat (eab/history-dir) "tramp"))
(setq-put url-configuration-directory (concat (eab/history-dir) "url/"))
(setq-put ansible-vault-pass-file "/home/eab/.ansible/passwd_cc")
(setq-put ansible-vault-pass-file "/home/eab/.ansible/passwd_fz")

(setq-put eab/yasnippets-path (concat user-emacs-directory "private/eab-spacemacs/local/yasnippet-snippets"))
(setq-put eab/eab-snippets-path (concat user-emacs-directory "private/eab-spacemacs/snippets"))

(setq-put eab/sauron-sound-path "/usr/share/sounds/ubuntu/stereo/service-login.ogg")
 
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))
