;;; packages.el --- eab Layer packages File for Spacemacs
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

(defvar eab-spacemacs-packages
  '(
  textile-mode
  puppet-mode
  yaml-mode
  ansible
  ansible-doc
  ansible-vault
  tramp-term
  vagrant
  vagrant-tramp
  csv-mode
  el-patch
  projectile
  ldap-mode
  general
  php-mode
  sql-indent
  gnuplot
  htmlize
  spacemacs-theme
  ergoemacs-mode
  key-chord
  auto-dictionary ;; switcher for flyspell
  ;; auto-complete-emacs-lisp ;; no melpa depend auto-complete
  howdoi
  ac-dabbrev
  etags-table
  etags-select
  helm
  helm-descbinds
  smart-compile
  popwin
  moz
  expand-region
  multiple-cursors
  flx-isearch
  workgroups2
  dictionary
  sauron
  magit
;;  magit-filenotify ;; needs emacs 24.4 with file-notify-support
  git-commit
  ;;	git-rebase ;; see in magit
  magit-annex
  orgit ;; org-magit obsolete
  auctex
  org-agenda-property
  region-bindings-mode
  smex
  smartparens
  auto-install
  flx-ido
  ido-at-point
  paredit
  grep-a-lot
  wgrep
  ag
  wgrep-ag
  undo-tree
  ;; workgroups
  edit-list

  docker
  dired+
  dired-details
  dired-details+
  elpa-mirror
  ace-window
  ace-jump-buffer
  ace-link
  twittering-mode
  request
  python-mode
  pydoc-info
  popup
  idle-highlight-mode ;; + no melpa
  help+
  help-fns+
  help-mode+
  fuzzy
  el-mock
  anchored-transpose
  bookmark+
  buffer-move
  crontab-mode
  shut-up
  parsebib
  package-build
  jedi-core
  ebib
  helm-helm-commands
  dockerfile-mode
  deft
  ewmctrl
  anaphora
  connection
  ido-vertical-mode
  link
  oneonone
  emacsc
  deferred ;; depend
  web-server
  take-off
  restclient
  god-mode
  fancy-narrow
  outshine
  outorg
  goto-chg
  epc
  ctable
  concurrent
  python-environment
  jedi
  ;; ipython
  bibretrieve
  git-annex
  websocket
  org-jekyll
  org-redmine
  pkg-info
  epl
  s
  achievements
  org-grep
  org
  f
  keyfreq
  cask ;; shut-up
  pallet ;; shut-up
  purty-mode
  flx
  guide-key
  xml-rpc
  web
  string-edit
  redo+
  pcache
  org-plus-contrib
  org-ehtml
  noflet
  minimap
  markdown-mode
  auto-complete
  yasnippet
  logito
  kv
  jira
  ignoramus
  ibuffer-vc
  highlight
  graphviz-dot-mode
  gist  ;; tabulated-list
  gh
  fuzzy-match
  feature-mode
  fakir ;; kv
  elnode ;; kv
  el-x
  ;; descbinds-anything
  db
  creole ;; kv
  clojure-mode
  browse-kill-ring
  bm
  ;; anything-obsolete
  ;; anything-ipython
  ;; anything-extension
  ;; anything-complete
  (eab-misc :location local)
  (eab-ace-jump-mode :location local)
  (eab-avy :location local)
  (eab-org-mode/lisp :location local)
  (eab-org-mode/contrib/lisp :location local) ;; for htmlize.el
  (eev-current :location local)
  (bbdb/lisp :location local)
  (org-link-minor-mode :location local)
  (pymacs :location local)
  )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar eab-spacemacs-excluded-packages '()
  "List of packages to exclude.")

(defun eab-spacemacs/init-ergoemacs-mode ()
  (require 'ergoemacs-translate)
  (require 'ergoemacs-functions)
  )

(defun eab-spacemacs/init-textile-mode ()
  (use-package textile-mode)
  (set-face-foreground 'textile-link-face "sky blue")
  (set-face-foreground 'textile-ul-bullet-face "sky blue"))
(defun eab-spacemacs/init-puppet-mode ()
  (use-package puppet-mode))
(defun eab-spacemacs/init-yaml-mode ()
  (use-package yaml-mode))
(defun eab-spacemacs/init-ansible ())
(defun eab-spacemacs/init-ansible-doc ())
(defun eab-spacemacs/init-ansible-vault ())

(defun eab-spacemacs/init-tramp-term ()
    (use-package tramp-term))
(defun eab-spacemacs/init-vagrant nil)
(defun eab-spacemacs/init-vagrant-tramp nil)
(defun eab-spacemacs/init-csv-mode nil)
(defun eab-spacemacs/init-el-patch nil)
(defun eab-spacemacs/init-projectile nil)
(defun eab-spacemacs/init-ldap-mode nil)

(defun eab-spacemacs/init-general ()
  (use-package general))

(defun eab-spacemacs/init-php-mode nil)
(defun eab-spacemacs/init-sql-indent nil)
(defun eab-spacemacs/init-gnuplot nil)
(defun eab-spacemacs/init-htmlize nil)

(defun eab-spacemacs/init-key-chord ()
  (use-package key-chord
    :init
    (setq key-chord-two-keys-delay 0.05)))

(defun eab-spacemacs/init-auto-dictionary ()
  (use-package auto-dictionary))

(defun eab-spacemacs/init-spacemacs-theme ()
    (setq spacemacs-theme-comment-bg nil))
(defun eab-spacemacs/init-howdoi nil)
(defun eab-spacemacs/init-ac-dabbrev nil)
(defun eab-spacemacs/init-etags-table nil)
(defun eab-spacemacs/init-etags-select nil)
(defun eab-spacemacs/init-helm nil)
(defun eab-spacemacs/init-helm-descbinds nil)
(defun eab-spacemacs/init-smart-compile nil)
(defun eab-spacemacs/init-popwin nil)
(defun eab-spacemacs/init-moz nil)
(defun eab-spacemacs/init-expand-region nil)
(defun eab-spacemacs/init-multiple-cursors nil)
(defun eab-spacemacs/init-flx-isearch nil)

(defun eab-spacemacs/init-workgroups2 ()
  (use-package workgroups2
	       :config
	       (progn
		 )))

(defun eab-spacemacs/init-dictionary nil)
(defun eab-spacemacs/init-sauron nil)
(defun eab-spacemacs/init-magit nil)
(defun eab-spacemacs/init-git-commit nil)
(defun eab-spacemacs/init-magit-annex nil)
;; (defun eab-spacemacs/init-magit-filenotify nil)

(defun eab-spacemacs/init-orgit nil
  ;; TODO cancel rev-export disabling
  (require 'orgit)
  (defun orgit-rev-export (path desc format))
  )

(defun eab-spacemacs/init-auctex nil)
(defun eab-spacemacs/init-org-agenda-property nil)
(defun eab-spacemacs/init-region-bindings-mode nil)
(defun eab-spacemacs/init-smex nil)
(defun eab-spacemacs/init-smartparens nil)
(defun eab-spacemacs/init-auto-install nil)
(defun eab-spacemacs/init-flx-ido nil)
(defun eab-spacemacs/init-ido-at-point nil)
(defun eab-spacemacs/init-paredit nil)
(defun eab-spacemacs/init-grep-a-lot nil)
(defun eab-spacemacs/init-wgrep nil)
(defun eab-spacemacs/init-ag nil)
(defun eab-spacemacs/init-wgrep-ag nil)
(defun eab-spacemacs/init-undo-tree nil)

(defun eab-spacemacs/init-edit-list ()
  (use-package edit-list
	       :config
	       (progn
		 )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab-spacemacs/init-docker ()
  (use-package docker))

(defun eab-spacemacs/init-dired+ nil)
(defun eab-spacemacs/init-dired-details nil)
(defun eab-spacemacs/init-dired-details+ nil)
(defun eab-spacemacs/init-elpa-mirror nil)
(defun eab-spacemacs/init-ace-window nil)
(defun eab-spacemacs/init-ace-jump-buffer nil)
(defun eab-spacemacs/init-ace-link nil)
(defun eab-spacemacs/init-twittering-mode nil)
(defun eab-spacemacs/init-request nil)
(defun eab-spacemacs/init-python-mode nil)
(defun eab-spacemacs/init-pydoc-info nil)
(defun eab-spacemacs/init-popup nil)
(defun eab-spacemacs/init-idle-highlight-mode nil)
(defun eab-spacemacs/init-help+ nil)
(defun eab-spacemacs/init-help-fns+ nil)
(defun eab-spacemacs/init-help-mode+ nil)
(defun eab-spacemacs/init-fuzzy nil)
(defun eab-spacemacs/init-el-mock nil)
(defun eab-spacemacs/init-anchored-transpose nil)
(defun eab-spacemacs/init-bookmark+ nil)
(defun eab-spacemacs/init-buffer-move nil)
(defun eab-spacemacs/init-crontab-mode nil)
(defun eab-spacemacs/init-shut-up nil)
(defun eab-spacemacs/init-parsebib nil)
(defun eab-spacemacs/init-package-build nil)
(defun eab-spacemacs/init-jedi-core nil)
(defun eab-spacemacs/init-ebib nil)
(defun eab-spacemacs/init-helm-helm-commands nil)
(defun eab-spacemacs/init-dockerfile-mode nil)
(defun eab-spacemacs/init-deft nil)
(defun eab-spacemacs/init-ewmctrl nil)
(defun eab-spacemacs/init-anaphora nil)
(defun eab-spacemacs/init-connection nil)
(defun eab-spacemacs/init-ido-vertical-mode nil)
(defun eab-spacemacs/init-link nil)
(defun eab-spacemacs/init-oneonone nil)
(defun eab-spacemacs/init-emacsc nil)
(defun eab-spacemacs/init-deferred nil)
(defun eab-spacemacs/init-web-server nil)
(defun eab-spacemacs/init-take-off nil)
(defun eab-spacemacs/init-restclient nil)
(defun eab-spacemacs/init-wide-n nil)
(defun eab-spacemacs/init-god-mode nil)
(defun eab-spacemacs/init-fancy-narrow nil)
(defun eab-spacemacs/init-outshine nil)
(defun eab-spacemacs/init-outorg nil)
(defun eab-spacemacs/init-goto-chg nil)
(defun eab-spacemacs/init-epc nil)
(defun eab-spacemacs/init-ctable nil)
(defun eab-spacemacs/init-concurrent nil)
(defun eab-spacemacs/init-python-environment nil)
(defun eab-spacemacs/init-jedi nil)
(defun eab-spacemacs/init-bibretrieve nil)
(defun eab-spacemacs/init-git-annex nil)
(defun eab-spacemacs/init-websocket nil)
(defun eab-spacemacs/init-org-jekyll nil)

(defun eab-spacemacs/init-org-redmine ()
  (require 'org-redmine))

(defun eab-spacemacs/init-pkg-info nil)
(defun eab-spacemacs/init-epl nil)
(defun eab-spacemacs/init-s nil)
(defun eab-spacemacs/init-python-info nil)
(defun eab-spacemacs/init-achievements nil)
(defun eab-spacemacs/init-org-grep nil)
(defun eab-spacemacs/init-org nil)
(defun eab-spacemacs/init-f nil)
(defun eab-spacemacs/init-keyfreq nil)
(defun eab-spacemacs/init-cask nil)
(defun eab-spacemacs/init-pallet nil)
(defun eab-spacemacs/init-purty-mode nil)
(defun eab-spacemacs/init-flx nil)
(defun eab-spacemacs/init-guide-key nil)
(defun eab-spacemacs/init-xml-rpc nil)
(defun eab-spacemacs/init-web nil)
(defun eab-spacemacs/init-string-edit nil)
(defun eab-spacemacs/init-redo+ nil)
(defun eab-spacemacs/init-pcache nil)
(defun eab-spacemacs/init-org-plus-contrib nil)
(defun eab-spacemacs/init-org-ehtml nil)
(defun eab-spacemacs/init-noflet nil)
(defun eab-spacemacs/init-minimap nil)
(defun eab-spacemacs/init-markdown-mode nil)
(defun eab-spacemacs/init-auto-complete nil)
(defun eab-spacemacs/init-yasnippet nil)
(defun eab-spacemacs/init-logito nil)
(defun eab-spacemacs/init-kv nil)
(defun eab-spacemacs/init-jira nil)
(defun eab-spacemacs/init-ignoramus nil)
(defun eab-spacemacs/init-ibuffer-vc nil)
(defun eab-spacemacs/init-highlight nil)
(defun eab-spacemacs/init-graphviz-dot-mode nil)
(defun eab-spacemacs/init-gist nil)
(defun eab-spacemacs/init-gh nil)
(defun eab-spacemacs/init-fuzzy-match nil)
(defun eab-spacemacs/init-feature-mode nil)
(defun eab-spacemacs/init-fakir nil)
(defun eab-spacemacs/init-elnode nil)
(defun eab-spacemacs/init-el-x nil)
(defun eab-spacemacs/init-db nil)
(defun eab-spacemacs/init-creole nil)
(defun eab-spacemacs/init-clojure-mode nil)
(defun eab-spacemacs/init-browse-kill-ring nil)
(defun eab-spacemacs/init-bm nil)
(defun eab-spacemacs/init-pymacs nil)
(defun eab-spacemacs/init-org-link-minor-mode nil)
(defun eab-spacemacs/init-eev-current nil)
(defun eab-spacemacs/init-bbdb/lisp nil)
(defun eab-spacemacs/init-eab-misc nil)

(defun eab-spacemacs/init-eab-org-mode/lisp ()
  (require 'org)
  (require 'org-crypt)
  (require 'org-habit)
  (require 'org-id)
  (require 'org-agenda)
  (require 'org-clock)
  (require 'org-table)
  (require 'org-bbdb)
  (require 'org-element)
  (require 'ox)
  (require 'ox-freemind)
  (require 'ox-odt)
  (require 'ob)
  (require 'ob-ditaa)
  (require 'ob-dot)
  (require 'ob-shell)
  (require 'ob-latex)
  (require 'ob-python)
  (require 'ob-makefile)
  (require 'ob-R)
;;  (require 'ob-rec)
  )

(defun eab-spacemacs/init-eab-org-mode/contrib/lisp ()
  (require 'htmlize)
  )

(defun eab-spacemacs/user-config ()
  (use-package eab-workgroups2)
  (use-package eab-ui-minimal)
  (use-package eab-shell)
  (use-package eab-shell-utils)
  (use-package eab-sauron)
  (use-package eab-yasnippet)
  (use-package eab-auctex)
  (use-package eab-postload-minimal)
  (use-package eab-depend-minimal)
  (use-package eab-window)
  (use-package eab-find-func)
  (use-package eab-workflow)
  (use-package eab-appt)
  (use-package eab-desktop)
  (use-package eab-words)
  (use-package eab-server)
  (use-package eab-git)
  (use-package eab-grep)
  (use-package eab-dired)
  (use-package eab-smex)
  (use-package eab-ido)
  (use-package eab-wmctrl)
  (use-package eab-ido-utils)
  (use-package eab-packages)
  (use-package eab-popwin)
  (use-package eab-miniframe)
  (use-package eab-compile)
  (use-package eab-browse)
  (use-package eab-sudo)
  (use-package eab-helm-anything)
  (use-package eab-greek-to-latex)
  (use-package eab-tags)
  (use-package eab-auto-complete)
  (use-package eab-ui)
  (use-package eab-ps)
  (use-package eab-auto-dictionary)
  (use-package eab-ace)
  (use-package eab-eepitch)
  (use-package eab-depend)
  (use-package eab-gnus)
  (use-package eab-twit)
  (use-package eab-postload)

  (use-package eab-org)
  (use-package eab-org-publish)
  (use-package eab-org-agenda)
  (use-package eab-org-protocol)
  (use-package eab-org-src-babel)
  (use-package eab-org-todo)
  (use-package eab-hron-lib)
  (use-package eab-org-latex)
  (use-package eab-org-reftex)
  (global-set-key (kbd "C-h c") 'describe-key-briefly)
  (global-set-key (kbd "M-O") 'forward-paragraph)
  (general-define-key
   :prefix "C-e"
   "d" docker-command-map)
  (defvar eab/dired-map (make-sparse-keymap)
    "keymap for fast dired")
  (global-set-key (kbd "C-x d") nil)
  (general-define-key
   :prefix "C-x d"
   "d" '(ido-dired :which-key "ido-dired")
   "o" `(,(ilam (dired eab/org-publish-directory)) :which-key ,eab/org-publish-directory)
   "h" `(,(ilam (dired "~/desktop")) :which-key "~/desktop")
   "s" `(,(ilam (dired "~/share")) :which-key "~/share")
   "p" `(,(ilam (dired eab/downloads-path)) :which-key ,eab/downloads-path)
   "t" `(,(ilam (dired "~/tmp")) :which-key "~/tmp"))
  (setq eab/dired-map (lookup-key global-map (kbd "C-x d")))
  )

(defun eab-spacemacs/init-eab-ace-jump-mode ()
  (evil-mode -1)
  (use-package ace-jump-mode)
  )

(defun eab-spacemacs/init-eab-avy ()
  (use-package avy))

;; For each package, define a function eab/init-<package-eab>
;;
;; (defun eab-spacemacs/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

