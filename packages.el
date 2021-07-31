;;; packages.el --- eab Layer packages File for Spacemacs
;;
;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defvar eab-spacemacs-packages
  `(
    solarized-theme
    spacemacs-theme
    etags-table
    etags-select
    
    dictionary
    auto-dictionary ;; switcher for flyspell
    howdoi
    twittering-mode

    deft
    outshine
    outorg
    bibretrieve
    ebib
    parsebib
    gnuplot
    htmlize
    org-ehtml
    purty-mode
    auctex
    (org-link-minor-mode :location local)
    org-agenda-property
    org-jekyll
    org-redmine
    org-plus-contrib
    (bbdb/lisp :location local)

    git-commit
    git-timemachine
    git-wip-timemachine
    libgit
    magit-libgit
    magit-annex
    git-annex
    magit
    forge
    orgit

    help+
    help-fns+
    help-mode+
    bookmark+
    keyfreq
    achievements
    god-mode
    guide-key
    goto-chg
    redo+
    auto-complete
    ac-dabbrev
    ;; auto-complete-emacs-lisp ;; no melpa depend auto-complete
    idle-highlight-mode ;; + no melpa
    highlight ;; dired+
    string-edit
    sauron
    smart-compile
    general
    xterm-color
    ergoemacs-mode
    smartparens
    key-chord
    region-bindings-mode
    anchored-transpose
    multiple-cursors
    expand-region
    paredit
    undo-tree
    edit-list
    yasnippet

    graphviz-dot-mode
    feature-mode
    nginx-mode
    rpm-spec-mode
    go-mode
    dockerfile-mode
    clojure-mode
    crontab-mode
    markdown-mode
    yaml-mode
    textile-mode
    ssh-config-mode
    python-mode
    pydoc-info
    ansible
    ansible-doc
    ansible-vault
    puppet-mode
    groovy-mode
    terraform-mode

    restclient
    request
    pkg-info
    epl
    el-mock
    el-patch
    elpa-mirror
    anaphora
    f
    s
    auto-install

    grep-a-lot
    wgrep
    ag
    wgrep-ag

    (eab-misc :location local)
    ace-window
    ace-jump-buffer
    ace-link
    (eab-ace-jump-mode :location local)
    (eab-avy :location local)
    (eev-current :location local)

    helm
    helm-descbinds
    helm-helm-commands
    smex ;; ido for M-x
    ido-at-point
    ido-vertical-mode
    flx
    flx-ido
    flx-isearch
    workgroups2
    projectile

    popwin
    tramp-term
    buffer-move
    ewmctrl
    oneonone
    emacsc

    vterm
    emamux
    vagrant
    vagrant-tramp
    docker
    docker-tramp

    ;; built-in
    (gnus :location built-in)
    (tramp :location built-in)
    (outline :location built-in)
    (compile :location built-in)
    (window :location built-in)
    (desktop :location built-in)
    (server :location built-in)
    (grep :location built-in)
    (dired :location built-in)
    (ido :location built-in)
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar eab-spacemacs-excluded-packages '()
  "List of packages to exclude.")

(defun eab-spacemacs/init-solarized-theme nil)
(defun eab-spacemacs/init-s ()
  (use-package s))

(defun eab-spacemacs/init-groovy-mode ()
  (use-package groovy-mode)
  (add-hook 'groovy-mode-hook (lambda () (setq indent-tabs-mode nil)))
  )

(defun eab-spacemacs/init-terraform-mode ()
  (use-package terraform-mode))

(defun eab-spacemacs/init-ergoemacs-mode ()
  (require 'ergoemacs-translate)
  (require 'ergoemacs-functions)
  )

(defun eab-spacemacs/init-rpm-spec-mode ())
(defun eab-spacemacs/init-git-timemachine ())
(defun eab-spacemacs/init-git-wip-timemachine ())
(defun eab-spacemacs/init-go-mode ()
  )
(defun eab-spacemacs/init-xterm-color ()
  (require 'xterm-color)
  )
(defun eab-spacemacs/init-ssh-config-mode ()
  (use-package ssh-config-mode))
(defun eab-spacemacs/init-textile-mode ()
  (use-package textile-mode
    :config
    (set-face-foreground 'textile-link-face "deep sky blue")
    (set-face-foreground 'textile-code-face "ivory4")
    (set-face-foreground 'textile-style-face "orange red")
    (set-face-foreground 'textile-ul-bullet-face "deep sky blue")))
(defun eab-spacemacs/init-puppet-mode ()
  (use-package puppet-mode))
(defun eab-spacemacs/init-yaml-mode ()
  (use-package yaml-mode))
(defun eab-spacemacs/init-ansible ())
(defun eab-spacemacs/init-ansible-doc ())
(defun eab-spacemacs/init-ansible-vault ()
  (eab/bind-path ansible-vault-pass-file)
  (with-temp-buffer (ansible-vault-mode)))

(defun eab-spacemacs/init-tramp-term ()
    (use-package tramp-term))
(defun eab-spacemacs/init-vagrant nil)
(defun eab-spacemacs/init-vagrant-tramp nil)
(defun eab-spacemacs/init-csv-mode nil)
(defun eab-spacemacs/init-el-patch nil)
(defun eab-spacemacs/init-projectile nil
  (require 'projectile)
  (setq projectile-require-project-root t)
  (eab/bind-path projectile-known-projects-file)
  (setq projectile-project-root-files-bottom-up
	'(".git"        ; Git VCS root dir
	  ".projectile" ; projectile project marker
	  ".hg"         ; Mercurial VCS root dir
	  ".fslckout"   ; Fossil VCS root dir
	  ".bzr"        ; Bazaar VCS root dir
	  "_darcs"      ; Darcs VCS root dir
	  ))
  )
(defun eab-spacemacs/init-ldap-mode nil)

(defun eab-spacemacs/init-general ()
  (use-package general))

(defun eab-spacemacs/init-php-mode nil)
(defun eab-spacemacs/init-sql-indent nil)
(defun eab-spacemacs/init-gnuplot nil
  (require 'gnuplot)
  )
(defun eab-spacemacs/init-htmlize nil
  (require 'htmlize)
  )

(defun eab-spacemacs/init-key-chord ()
  (use-package key-chord
    :init
    (setq key-chord-two-keys-delay 0.05))
  ;; (key-chord-mode 1) ; DONE заедает, если не в конце dotemacs, не включается по-умолчанию (или выключается из-за чего-то)
  (add-hook 'term-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))
  )

(defun eab-spacemacs/init-auto-dictionary ()
  (use-package auto-dictionary)
  (use-package eab-auto-dictionary)
  )

(defun eab-spacemacs/init-spacemacs-theme ()
    (setq spacemacs-theme-comment-bg nil))
(defun eab-spacemacs/init-howdoi nil
  (require 'howdoi)
  (defun eab/howdoi ()
    (interactive)
    (call-interactively 'howdoi-query-line-at-point-replace-by-code-snippet))  
  )
(defun eab-spacemacs/init-ac-dabbrev nil
  (use-package ac-dabbrev
    :after (auto-complete)))
(defun eab-spacemacs/init-etags-table nil
  (require 'etags-table)
  (setq etags-table-alist 'nil) ;; попробуем использовать search up depth
  (setq etags-table-search-up-depth 10)
  )
(defun eab-spacemacs/init-etags-select nil
  (require 'etags-select)
  (use-package eab-tags)
  )
(defun eab-spacemacs/init-helm nil
  (use-package eab-helm)
  )
(defun eab-spacemacs/init-helm-descbinds nil
  (require 'helm-descbinds)
  (helm-descbinds-mode)
  )
(defun eab-spacemacs/init-helm-helm-commands nil)
(defun eab-spacemacs/init-smart-compile nil
  (require 'smart-compile)
  (setq-default smart-compile-check-makefile nil)
  (add-to-list 'smart-compile-alist '(graphviz-dot-mode . "xdot.py %F"))
  (add-to-list 'smart-compile-alist '(python-mode . "python %F"))
  (add-to-list 'smart-compile-alist '(textile-mode . "make push id=%f"))
  (add-to-list 'smart-compile-alist '("\\.xml\\'" . "cd ../../.. && make push id=%F"))
  (add-to-list 'smart-compile-alist '("\\.jira\\'" . "make push id=%n"))
  (add-to-list 'smart-compile-alist '("\\.html\\'" . "make push id=%n"))
  )
(defun eab-spacemacs/init-popwin nil
  (require 'popwin)
  (popwin-mode 1)

  (generate-new-buffer "special-buffer")

  (setq eab/special-buffer-displaedp nil)
  (setq eab/special-buffer "special-buffer")

  (setq popwin:special-display-config nil)
  (add-to-list 'popwin:special-display-config
	       `(,eab/special-buffer :width 20 :position left :stick t))

  ;; see also toggle-window-dedicated
  (defun eab/special-buffer-toggle ()
    (interactive)
    (if eab/special-buffer-displaedp
	(progn
	  ;; (ignore-errors (delete-window (get-buffer-window eab/special-buffer)))
	  (popwin:close-popup-window)
	  (setq eab/special-buffer-displaedp nil))
      (progn
	(ignore-errors (popwin:display-buffer eab/special-buffer))
	(setq eab/special-buffer-displaedp 't))))

  (global-set-key (kbd "<f3>") 'eab/special-buffer-toggle)
  )
(defun eab-spacemacs/init-expand-region nil
  (require 'expand-region)
  ;; (require 'mark-more-like-this)
  (defun er/add-org-mode-expansions ()
    "Adds org-specific expansions for buffers in org-mode"
    (set (make-local-variable 'er/try-expand-list)
	 (append
          (remove #'mark-paragraph (remove #'er/mark-defun er/try-expand-list))
          '(org-mark-subtree
            er/mark-org-element
            er/mark-org-element-parent
            er/mark-org-code-block
            er/mark-sentence
            er/mark-org-parent)))
    (set (make-local-variable 'er/save-mode-excursion)
	 #'er/save-org-mode-excursion))
  (defun er/add-text-mode-expansions ()
    (make-variable-buffer-local 'er/try-expand-list)
    (setq er/try-expand-list (append
                              er/try-expand-list
                              '(mark-paragraph
				mark-page))))
  (add-hook 'text-mode-hook 'er/add-text-mode-expansions)
  )
(defun eab-spacemacs/init-multiple-cursors nil
  (require 'multiple-cursors) ;; fix mc/keymap
  (eab/bind-path mc/list-file)
  (if (boundp 'mc--default-cmds-to-run-for-all)
      (setq mc--cmds mc--default-cmds-to-run-for-all))
  ;; TODO mc/cmds-to-run-for-all переназначается (sp-backward-sexp sp-forward-sexp)
  (setq mc/cmds-to-run-for-all (append mc/cmds-to-run-for-all
				       '(org-delete-char
					 org-self-insert-command)))
  )
(defun eab-spacemacs/init-flx-isearch ()
  (flx-isearch-mode 0))

(defun eab-spacemacs/init-workgroups2 ()
  (use-package workgroups2
    :config
    (progn
      ))
  (use-package eab-workgroups2
    :init
    (eab/bind-path eab/wg-path)
    (eab/bind-path eab/workgroups-save)
    (eab/bind-path wg-session-file)
    (eab/bind-path eab/wg-update-list)
    (setq wg-use-default-session-file 't)
    (setq wg-control-frames 'nil)
    (setq wg-session-load-on-start nil)
    (setq wg-mode-line-decor-divider "")
    :config
    (ignore-errors (workgroups-mode 1))
    (eab/wg-init)
    )
  )

(defun eab-spacemacs/init-dictionary nil
  (require 'dictionary)
  (setq dictionary-server "localhost")
  (defadvice dictionary-search (after eab-dictionary-abbrev activate)
    "Put searched word for dictionary to eab-abbrev-table"
    (let ((word (ad-get-arg 0)))
      (if (not (string-equal word ""))
          (define-abbrev eab-abbrev-table word word))))
  )
(defun eab-spacemacs/init-sauron nil
  ;; Requirements: twittering-mode
  ;; exclude sauron-org
  (setq sauron-modules '(sauron-notifications sauron-twittering))
  (require 'sauron)
  ;; (require 'sauron-org)
  (require 'sauron-notifications)
  (setq sauron-separate-frame nil)
  (eab/bind-path eab/sauron-sound-path)
  (add-hook 'sauron-event-added-functions
	  (lambda (origin prio msg &optional props)
	    (sauron-fx-mplayer eab/sauron-sound-path)
	    ;;(notifications-notify :title "Sauron" :body msg)))
	    ))
  )
(defun eab-spacemacs/init-magit nil
  (use-package magit
    :after (libgit))
  (require 'magit-wip)
  (require 'git-wip) ;; TODO can remove it and use magit-wip-mode?
;; (setq auto-revert-buffer-list-filter 'magit-auto-revert-repository-buffer-p)
;;    ("-S" "Submodule diff"                 ("-S" "--submodule=diff"))
;; (put 'magit-status-mode 'magit-diff-default-arguments
;;     '("--submodule=diff"))
  )
(defun eab-spacemacs/init-magit-annex nil
  (use-package magit-annex
    :after (magit))
  )
(defun eab-spacemacs/init-git-annex nil)
(defun eab-spacemacs/init-magit-libgit nil)
(defun eab-spacemacs/init-git-commit nil)
(defun eab-spacemacs/init-forge nil
  ;; (require 'forge)
  ;; (setq forge-post-mode-hook '(visual-line-mode))
  (defun auth-source--obfuscate (string)
    (mapcar #'1- string))

  (defun auth-source--deobfuscate (data)
    (apply #'string (mapcar #'1+ data)))
  )
;; (defun eab-spacemacs/init-magit-filenotify nil
;;   (add-hook 'magit-status-mode-hook 'magit-filenotify-mode) ;; TODO too slow
;; )
(defun eab-spacemacs/init-orgit nil
  ;; TODO cancel rev-export disabling
  (use-package orgit
    :after (magit)
    :config
    (defun orgit-rev-export (path desc format))
    )
  ;; org-magit obsolete
  ;; org-magit workaround
  ;; (defvar magit-currently-shown-commit nil)
  ;; (defadvice magit-show-commit (after eab-magit-show-commit activate)
  ;;   (setq magit-currently-shown-commit (ad-get-arg 0)))
  )

(defun eab-spacemacs/init-logstash-conf nil)
(defun eab-spacemacs/init-nginx-mode nil)
(defun eab-spacemacs/init-emamux nil)
(defun eab-spacemacs/init-libgit nil
  (if (not (version< emacs-version "26.1"))
      (require 'libgit)))
(defun eab-spacemacs/init-vterm nil
    (setq vterm-keymap-exceptions '("C-c" "C-x" "C-u" "C-g" "C-h" "C-l" "M-x" "M-o" "C-v" "M-v" "C-y" "M-y" "M-s" "M-a" "M-i" "M-k" "M-j" "M-l" "C-a" "M-c" "M-p")))


(defun eab-spacemacs/init-auctex nil
;; (load "auctex.el" nil t t)
  (use-package eab-tex)
  )
(defun eab-spacemacs/init-org-agenda-property nil
  (use-package org-agenda-property
    :after (org-agenda)
    :config
    (setq org-agenda-property-list '("Custom_ID")))
  )
(defun eab-spacemacs/init-region-bindings-mode nil
  (require 'region-bindings-mode)
  (region-bindings-mode-enable)
  ;; prevent annoying switching on rk in region-bindings-mode on set-mark-command
  ;; DONE возможно, из-за этой настройки что-то начнет работать "странно"
  (add-hook 'window-configuration-change-hook
	    (lambda ()
	      (if (and mark-active (not (use-region-p)))
		  (deactivate-mark))))
  (defadvice winner-undo (before eab-winner-undo-before activate)
    (region-bindings-mode-disable))
  (defadvice winner-undo (after eab-winner-undo-after activate)
    (region-bindings-mode-enable))
  (defadvice winner-redo (before eab-winner-redo-before activate)
    (region-bindings-mode-disable))
  (defadvice winner-redo (after eab-winner-redo-after activate)
    (region-bindings-mode-enable))
  ;; TODO fix the hack: why call it second time?
  ;; emacs 28 bad
  ;; (define-minor-mode region-bindings-mode :lighter " rk" :group 'convenience)
  )
(defun eab-spacemacs/init-smex nil
  (use-package eab-smex)
  )
(defun eab-spacemacs/init-smartparens nil
  (require 'smartparens) ;; fix boundp sp-keymap
  (require 'smartparens-latex)
  ;; (smartparens-global-mode)
  (setq sp-ignore-modes-list nil)
  )
(defun eab-spacemacs/init-auto-install nil
  (require 'auto-install)
  (eab/bind-path auto-install-directory)
  )
(defun eab-spacemacs/init-flx-ido nil
  (use-package flx-ido))
(defun eab-spacemacs/init-ido-at-point nil
  (use-package ido-at-point)
  ;; (ido-at-point-mode) ;; conflicts with minibuffer completion
  )
(defun eab-spacemacs/init-paredit nil
  (require 'paredit)
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  )
(defun eab-spacemacs/init-grep-a-lot nil
  (use-package grep-a-lot))
(defun eab-spacemacs/init-wgrep nil
  (use-package wgrep))
(defun eab-spacemacs/init-ag nil)
(defun eab-spacemacs/init-wgrep-ag nil)
(defun eab-spacemacs/init-undo-tree nil
  (require 'undo-tree)
  (global-undo-tree-mode)
  (require 'diminish)
  (diminish 'undo-tree-mode "UT")
  )

(defun eab-spacemacs/init-edit-list ()
  (use-package edit-list
    :config
    (progn
      ))
  (require 'edit-list)
  (defun eab/edit-list-1 (word)
    (edit-list (intern word)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab-spacemacs/init-docker ()
  (use-package docker)
  ;; Requirements: docker-utils
  (defun eab/tramp-docker-cleanup ()
    (interactive)
    (tramp-cleanup-connection
     (tramp-dissect-file-name
      (concat "/docker:"
	      (car (progn
		     (docker-utils-select-if-empty)
		     (docker-utils-get-marked-items-ids))) ":")))))

(defun eab-spacemacs/init-docker-tramp ()
  (use-package docker-tramp))

(defun eab-spacemacs/init-elpa-mirror nil)
(defun eab-spacemacs/init-ace-window nil)
(defun eab-spacemacs/init-ace-jump-buffer nil)
(defun eab-spacemacs/init-ace-link nil)
(defun eab-spacemacs/init-twittering-mode nil
  (require 'twittering-mode)
  (setq twittering-use-native-retweet 't)
  (setq twittering-initial-timeline-spec-string ":home")
  (setq twittering-use-master-password t)
  (eab/bind-path eab/twittering-modeP)
  (eab/bind-path eab/twittering-modeC)
  (if (eab/ondaemon "serverP")
      (setq twittering-private-info-file eab/twittering-modeP))
  (if (eab/ondaemon "serverC")
      (setq twittering-private-info-file eab/twittering-modeC))
  (use-package eab-twit)
  )
(defun eab-spacemacs/init-request nil)
(defun eab-spacemacs/init-python-mode nil
  (require 'python-mode)
  ;; (require 'ipython)
  (setq py-python-command "ipython")
  (defvar py-mode-map python-mode-map)
  (setq py-start-run-py-shell nil)
  (setq py-force-py-shell-name-p 't) ;; DONE error with #!/usr/bin/python
  (setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.all_completions('%s')))\n")
  )
(defun eab-spacemacs/init-pydoc-info nil
  (require 'pydoc-info)
  )
(defun eab-spacemacs/init-popup nil)
(defun eab-spacemacs/init-idle-highlight-mode nil
  (require 'idle-highlight-mode)
  )
(defun eab-spacemacs/init-help+ nil)
(defun eab-spacemacs/init-help-fns+ nil)
(defun eab-spacemacs/init-help-mode+ nil)
(defun eab-spacemacs/init-fuzzy nil)
(defun eab-spacemacs/init-el-mock nil)
(defun eab-spacemacs/init-anchored-transpose nil)
(defun eab-spacemacs/init-bookmark+ nil
  (require 'bookmark+)
  (eab/bind-path bmkp-last-as-first-bookmark-file)
  (eab/bind-path bookmark-default-file)
  )
(defun eab-spacemacs/init-buffer-move nil
  (require 'buffer-move)
  )
(defun eab-spacemacs/init-crontab-mode nil)
(defun eab-spacemacs/init-shut-up nil)
(defun eab-spacemacs/init-parsebib nil)
(defun eab-spacemacs/init-package-build nil)
(defun eab-spacemacs/init-jedi-core nil)
(defun eab-spacemacs/init-ebib nil
  (eab/bind-path ebib-file-search-dirs)
  (eab/bind-path ebib-preload-bib-files)
  )
(defun eab-spacemacs/init-dockerfile-mode nil)
(defun eab-spacemacs/init-deft nil)
(defun eab-spacemacs/init-ewmctrl nil)
(defun eab-spacemacs/init-anaphora nil)
(defun eab-spacemacs/init-connection nil)
(defun eab-spacemacs/init-ido-vertical-mode nil)
(defun eab-spacemacs/init-link nil)
(defun eab-spacemacs/init-oneonone nil
  (require 'oneonone)
  )
(defun eab-spacemacs/init-emacsc nil
  (require 'emacsc)
  )
(defun eab-spacemacs/init-deferred nil)
(defun eab-spacemacs/init-web-server nil)
(defun eab-spacemacs/init-take-off nil)
(defun eab-spacemacs/init-restclient nil
  (require 'restclient)
  )
(defun eab-spacemacs/init-wide-n nil)
(defun eab-spacemacs/init-god-mode nil
  (setq god-mod-alist
	'(("g" . "C-")
	  (nil . "M-")
	  ("G" . "C-M-")))
  )
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
(defun eab-spacemacs/init-websocket nil)
(defun eab-spacemacs/init-org-jekyll nil)

(defun eab-spacemacs/init-org-redmine ()
  (require 'org-redmine))

(defun eab-spacemacs/init-pkg-info nil)
(defun eab-spacemacs/init-epl nil)
(defun eab-spacemacs/init-python-info nil)
(defun eab-spacemacs/init-achievements nil
  (eab/bind-path achievements-file)
  )
(defun eab-spacemacs/init-org-grep nil)
(defun eab-spacemacs/init-org nil)
(defun eab-spacemacs/init-f nil)
(defun eab-spacemacs/init-keyfreq nil
  (require 'keyfreq)
  (eab/bind-path keyfreq-file)
  (eab/bind-path keyfreq-file-lock)
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1)
  )
(defun eab-spacemacs/init-cask nil
  (require 'cask)
  (cask-initialize)
  )
(defun eab-spacemacs/init-pallet nil
  (require 'pallet)
  (pallet-init)
  )
(defun eab-spacemacs/init-purty-mode nil
  (require 'purty-mode)
  )
(defun eab-spacemacs/init-flx nil)
(defun eab-spacemacs/init-guide-key nil
  (require 'guide-key)
  ;; (setq guide-key/guide-key-sequence '("C-e"))
  (guide-key-mode 1) ; Enable guide-key-mode
  )
(defun eab-spacemacs/init-xml-rpc nil)
(defun eab-spacemacs/init-web nil)
(defun eab-spacemacs/init-string-edit nil
  (require 'string-edit)
  )
(defun eab-spacemacs/init-redo+ nil
  (require 'redo+)
  )
(defun eab-spacemacs/init-pcache nil)
(defun eab-spacemacs/init-org-plus-contrib nil)
(defun eab-spacemacs/init-org-ehtml nil)
(defun eab-spacemacs/init-noflet nil)
(defun eab-spacemacs/init-minimap nil)
(defun eab-spacemacs/init-markdown-mode nil)
(defun eab-spacemacs/init-auto-complete nil
  (use-package eab-auto-complete)
  )
(defun eab-spacemacs/init-yasnippet nil
  (require 'yasnippet)

  (setq yas-snippet-dirs '())
  ;; cd el-get && git clone https://github.com/AndreaCrotti/yasnippet-snippets
  (add-to-list 'yas-snippet-dirs (eab/bind-path eab/yasnippets-path))
  (add-to-list 'yas-snippet-dirs (eab/bind-path eab/eab-snippets-path))

  (setq yas-key-syntaxes '("w_" "w_." "w_.()" "^ "))

  (defun yas-org-very-safe-expand ()
    (let ((yas-fallback-behavior 'return-nil)
	  (yas-minor-mode 't))
      (yas-expand)))

  (add-hook 'org-mode-hook
            (lambda ()
              (make-variable-buffer-local 'yas-trigger-key)
              (setq yas-trigger-key [tab])
              (add-to-list 'org-tab-first-hook 'yas-org-very-safe-expand)
              (define-key yas-keymap [tab] 'yas-next-field)))
  )
(defun eab-spacemacs/init-kv nil)
(defun eab-spacemacs/init-jira nil)
(defun eab-spacemacs/init-ignoramus nil
  (require 'ignoramus)
  (ignoramus-setup)
  )
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
(defun eab-spacemacs/init-org-link-minor-mode nil
  (use-package org-link-minor-mode
    :after (org))
  )
(defun eab-spacemacs/init-eev-current nil
  (use-package eab-eepitch
    :init
    (eab/bind-path eab/eeansi-path)
    (eab/bind-path eab/eegchannel-path)
    (setq vterm-shell eab/eeansi-path)
    )
  )
(defun eab-spacemacs/init-bbdb/lisp nil
  (require 'bbdb-loaddefs)
  (require 'bbdb)
  (require 'bbdb-anniv)
  (eab/bind-path bbdb-file)
  (bbdb-initialize 'gnus 'message 'sc) ;; 'w3m)
  (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
  (setq bbdb-north-american-phone-numbers-p nil)
  )
(defun eab-spacemacs/init-eab-misc nil
  (require 'power-macros)
  (eab/bind-path pm-macro-files)
  (eab/bind-path power-macros-file)

  (defun eab/pm-write-last-kbd-macro (name)
    (interactive "MName of macro: ")
    (with-temp-buffer
      (insert "\n\n")
      (insert
       (concat "(pm-def-macro\n '"
	       name
	       "\n nil nil\n \"\"\n \""
	       (format-kbd-macro) "\")\n"))
      (write-region (point-min) (point-max) power-macros-file t)))

  (defun eab/pm-set-last-kbd-macro ()
    (interactive)
    (setq last-kbd-macro
	  (copy-sequence
	   (symbol-function
	    (intern
	     (ido-completing-read "Macro: "
				  (mapcar
				   (lambda (x) (symbol-name x))
				   (pm-get-available-macros))))))))
  (require 'gnugol)
  (setq diredp-hide-details-initially-flag nil)
  (require 'dired+)
  (require 'dired-details)
  ;; TODO почему приходится делать unload?
  ;; (unload-feature 'dired-details+ 't)
  ;; (require 'ede) ; error with dired
  ;; (require 'dired-sort-menu)  

  (require 'alossage)
  (require 'shell-history)
  (require 'shell-command-queue)
  (require 'one-key)
  (require 'json-pretty-print)
  (require 'rec-mode)
  (require 'color-moccur)
  (require 'moccur-edit)
  (eval-after-load "replace" '(progn (require 'replace+)))

  (defun multi-occur-in-all-buffers ()
    "Show all lines matching REGEXP in all buffers."
    (interactive)
    (multi-occur
     (buffer-list)
     (car (occur-read-primary-args))))

  (require 'smart-operator)
  (add-hook 'maplev-mode-hook
            (lambda ()
	      ;;            (smart-operator-mode-on)
              (setq maplev-mint-start-options (list "-q" "-P"))
              (setq maplev-executable-alist '(("11" "maple" nil "maple")
                                              ("10" "maple" nil "mint")
                                              ("9" "maple" nil "mint")
                                              ("8" "maple" nil "mint")
                                              ("7" "maple" nil "mint")
                                              ("6" "maple" nil "mint")
                                              ("5.1" "maple" nil "mint")
                                              ("5" "maple" nil "mint")
                                              ("4" "maple" nil "mint")))))
  )

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

(defun eab-spacemacs/init-gnus nil
  (use-package eab-gnus)
  )

(defun eab-spacemacs/init-tramp nil
  (use-package eab-tramp)
  )

(defun eab-spacemacs/init-outline nil
  (use-package eab-outline
    :after (eab-minimal))
  )

(defun eab-spacemacs/init-window nil
  (use-package eab-window)
  )

(defun eab-spacemacs/init-desktop nil
  (use-package eab-desktop)
  )

(defun eab-spacemacs/init-server nil
  (use-package eab-server)
  )

(defun eab-spacemacs/init-compile nil
  (use-package eab-compile
    :init
    (setq compile-command "make ")
    (setq compilation-buffer-name-function
	  (lambda (mode)
	    (concat "*" (downcase mode) ": " (projectile-project-name) "*")))
    (setq compilation-exit-message-function 'compilation-exit-autoclose)
    (setq compilation-exit-message-function nil)
    (setq compilation-scroll-output 't)
    )
  )

(defun eab-spacemacs/init-grep nil
  (use-package eab-grep
    :after (grep-a-lot wgrep))
  )

(defun eab-spacemacs/init-dired nil
  (use-package eab-dired
    :after (docker-tramp eab-tramp))
  )

(defun eab-spacemacs/init-ido nil
  (use-package eab-ido
    :after (flx-ido projectile))
  )

(defun eab-spacemacs/user-config ()
  (use-package eab-workflow)
  (use-package eab-words
    :init
    (eab/bind-path abbrev-file-name)
    (if (file-exists-p abbrev-file-name)
	(quietly-read-abbrev-file abbrev-file-name))
    )
  (use-package eab-appt)
  (use-package eab-ui)
  (use-package eab-shell
    :init
    ;; (shell-command "xmodmap -e 'keycode 135 = Hyper_R'")
    ;; (shell-command "xmodmap -e 'keycode 95 = Hyper_R'")
    (eab/bind-path eab/translate-path)
    (eab/bind-path eab/trans-path)
    )
  (use-package eab-postload)
  (use-package eab-depend)

  (use-package eab-org)
  (use-package eab-org-publish)
  (use-package eab-org-agenda)
  (use-package eab-org-protocol)
  (use-package eab-org-src-babel)
  (use-package eab-org-todo)
  (use-package eab-hron-lib)
  (use-package eab-org-latex)
  (use-package eab-greek-to-latex)
  (use-package eab-org-reftex)
  (if (string= (daemonp) "serverC")
      (use-package eab-org-extension))
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
  (when (require 'so-long nil :noerror)
    (global-so-long-mode 1))
  )

(defun eab-spacemacs/init-eab-ace-jump-mode ()
  (evil-mode -1)
  (use-package ace-jump-mode)
  (use-package eab-ace)
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

