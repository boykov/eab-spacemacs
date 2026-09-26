;;; packages.el --- eab Layer packages File for Spacemacs -*- lexical-binding: t -*-
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

(defmacro eab/add-hook (hookname funcname &rest body)
  "add-hook with lambda progn"
  (declare (indent defun))
  `(progn (add-hook ',hookname ',funcname)
          (defun ,funcname ()
            (progn ,@body))))

(defun display-startup-echo-area-message ()
  "Change the default welcome message of minibuffer to another one."
  (message (with-current-buffer (get-buffer-create "*spacemacs*")
             (buffer-substring-no-properties (point-min) (point-max))))
  (message "Spacemacs is ready."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package eab-notify)
(use-package eab-server
  :after (eab-notify))

(defvar eab-spacemacs-packages
  `(
    solarized-theme
    spacemacs-theme
    diminish
    which-key
    
    dictionary
    auto-dictionary ;; switcher for flyspell

    (aaorg :location local)
    bibretrieve
    ebib
    parsebib
    gnuplot
    htmlize
    org-ehtml
    ob-tmux
    purty-mode
    auctex
    (org-link-minor-mode :location local)
    org-agenda-property
    (bbdb/lisp :location local)
    ov
    org-super-agenda
    peg
    (org-ql :location local)
    org-special-block-extras
    org-sql
    org-transclusion
    ox-pandoc

    git-timemachine
    git-wip-timemachine
    magit
    forge
    orgit
    diff-hl
    sqlite3

    keyfreq
    achievements
    god-mode
    guide-key
    goto-chg
    redo+
    auto-complete
    idle-highlight-mode ;; + no melpa
    highlight           ;; dired+
    string-edit-at-point
    smart-compile
    general
    xterm-color
    ergoemacs-mode
    smartparens
    key-chord
    region-bindings-mode
    multiple-cursors
    expand-region
    paredit
    undo-tree
    edit-list
    yasnippet
    highlight-indentation
    prettier
    lispy
    zoutline
    iedit

    typescript-mode
    racket-mode
    julia-mode
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
    ansible
    ansible-doc
    ansible-vault
    puppet-mode
    groovy-mode
    terraform-mode
    so-long
    k8s-mode
    rust-mode
    sql-indent

    restclient
    request
    pkg-info
    epl
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
    rg

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
    helm-org
    helm-org-rifle
    smex ;; ido for M-x
    ido-at-point
    flx
    flx-ido
    flx-isearch
    (workgroups2/src :location local)
    projectile
    consult
    (consult-omni :location local)

    popwin
    tramp-term
    buffer-move
    ewmctrl
    oneonone
    emacsc

    esup
    ghostel
    vterm
    (emacs-eat :location local)
    (eaf :location local)
    emamux
    vagrant
    vagrant-tramp
    docker
    websocket
    daemons
    prodigy
    kubernetes
    llm
    ellama
    elisa
    gptel
    gptel-agent
    gptel-magit
    ai-code

    ;; built-in
    (compat :location built-in)
    (gnus :location built-in)
    (tramp :location built-in)
    (outline :location built-in)
    (compile :location built-in)
    (eab-gr :location built-in)
    (window :location built-in)
    (desktop :location built-in)
    (appt :location built-in)
    (server :location built-in)
    (grep :location built-in)
    (dired :location built-in)
    (ido :location built-in)
    (bookmark :location built-in)
    (abbrev :location built-in)
    (autorevert :location built-in)
    (ansi-color :location built-in)
    (recentf :location built-in)
    (flyspell :location built-in)
    (ispell :location built-in)
    (ediff :location built-in)
    (ediff-wind :location built-in)
    (ediff-diff :location built-in)
    (browse-url :location built-in)
    (simple :location built-in)
    (subr :location built-in)
    (paragraphs :location built-in)
    (ibuffer :location built-in)
    (comint :location built-in)
    (term :location built-in)
    (epa :location built-in)
    (python :location built-in)
    (eab-ui :location built-in)
    (eab-org :location built-in)
    (eab-workflow :location built-in)
    (eab-minimal :location built-in)
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar eab-spacemacs-excluded-packages '()
  "List of packages to exclude.")

(defun eab-spacemacs/init-zoutline nil
  (use-package zoutline))
(defun eab-spacemacs/init-iedit nil
  (use-package iedit))
(defun eab-spacemacs/init-lispy nil
  (use-package lispy
    :after (iedit zoutline)))
(defun eab-spacemacs/init-ox-pandoc nil)
(defun eab-spacemacs/init-elisa nil)
(defun eab-spacemacs/init-ai-code nil )
(defun eab-spacemacs/init-gptel-agent nil )
(defun eab-spacemacs/init-llm ())
(defun eab-spacemacs/init-prodigy nil
  (use-package prodigy))
(defun eab-spacemacs/init-solarized-theme nil)
(defun eab-spacemacs/init-s ()
  (use-package s))
(defun eab-spacemacs/init-groovy-mode ()
  (use-package groovy-mode
    :config
    (eab/add-hook groovy-mode-hook eab/groovy-hook
      (general-define-key
       :keymaps 'groovy-mode-map
       "C-i"        'eab/outline-toggle-children
       "<backtab>"  'eab/outline-toggle-all))
    (add-hook 'groovy-mode-hook (lambda () (setq indent-tabs-mode nil)))))
(defun eab-spacemacs/init-terraform-mode ()
  (use-package terraform-mode))
(defun eab-spacemacs/init-kubernetes nil)
(defun eab-spacemacs/init-k8s-mode ()
  (use-package k8s-mode))
(defun eab-spacemacs/init-rust-mode ()
  (use-package rust-mode))
(defun eab-spacemacs/init-so-long ()
  (use-package so-long
    :config
    (global-so-long-mode 1)))
(defun eab-spacemacs/init-git-timemachine ())
(defun eab-spacemacs/init-git-wip-timemachine ())
(defun eab-spacemacs/init-xterm-color ()
  (use-package xterm-color))
(defun eab-spacemacs/init-tramp-term () )
(defun eab-spacemacs/init-vagrant nil)
(defun eab-spacemacs/init-vagrant-tramp nil)
(defun eab-spacemacs/init-csv-mode nil)
(defun eab-spacemacs/init-el-patch nil)
(defun eab-spacemacs/init-consult nil)
(defun eab-spacemacs/init-consult-omni nil
  (use-package consult-omni
    :after (consult)
    :init
    (add-to-list 'load-path (eab/config (concat eab-spacemacs-path "local/consult-omni")))
    (add-to-list 'load-path (eab/config (concat eab-spacemacs-path "local/consult-omni/sources")))
    :config
    (setq consult-omni-multi-sources '("DuckDuckGo API"))))
(defun eab-spacemacs/init-ldap-mode nil)
(defun eab-spacemacs/init-general ()
  (use-package general))
(defun eab-spacemacs/init-php-mode nil)
(defun eab-spacemacs/init-sql-indent nil)
(defun eab-spacemacs/init-gnuplot nil
  (use-package gnuplot))
(defun eab-spacemacs/init-htmlize nil
  (use-package htmlize))
(defun eab-spacemacs/init-key-chord ()
  (use-package key-chord
    :config
    (setq key-chord-two-keys-delay 0.05)
    (add-hook 'term-mode-hook
              (lambda () (setq input-method-function 'key-chord-input-method)))))
(defun eab-spacemacs/init-autorevert nil
  (use-package autorevert
    :config
    (global-auto-revert-mode)
    (setq auto-revert-use-notify nil)))
(defun eab-spacemacs/init-spacemacs-theme ()
    (setq spacemacs-theme-comment-bg nil))

(defun eab-spacemacs/init-gptel nil
  (load "eab-config-gptel.el"))
(defun eab-spacemacs/init-gptel-magit nil)
(defun eab-spacemacs/init-ellama nil
  (load "eab-config-ellama.el"))
(defun eab-spacemacs/init-daemons nil
  (load "eab-config-daemons.el"))
(defun eab-spacemacs/init-ergoemacs-mode nil
  (load "eab-config-ergoemacs.el"))
(defun eab-spacemacs/init-projectile nil
  (load "eab-config-projectile.el"))
(defun eab-spacemacs/init-browse-url ()
  (load "eab-config-browse-url.el"))

(defun eab-spacemacs/init-epa ()
  (use-package epa)
  (use-package epa-file
    :after (epa)
    :config
    (epa-file-enable)
    (setq epa-file-select-keys 'silent))
  (use-package epg
    :config
    (setenv "GPG_AGENT_INFO" nil)       ; use gpg without gui window
    ;; gpg --import ~/.ssh/key_*.gpg
    (setq epg-gpg-program "gpg")
    (setq epa-pinentry-mode 'loopback)))
(defun eab-spacemacs/init-term ()
  (use-package eab-config-term
    :after (eab-minimal eab-notify)))
(defun eab-spacemacs/init-comint ()
  (use-package comint
    :config
    (add-hook 'ielm-mode-hook (lambda () (setq comint-process-echoes nil)))
    (add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))
    (general-define-key
     :keymaps 'comint-mode-map
     "M-p"        'comint-previous-matching-input-from-input
     "M-n"        'comint-next-matching-input-from-input
     "C-M-n"      'comint-next-input
     "C-M-p"      'comint-previous-input
     "M-s"        'nil
     "M-p"        'nil
     "M-n"        'nil
     "M-r"        'nil
     "C-p"        'comint-previous-input
     "C-n"        'comint-next-input)))
(defun eab-spacemacs/init-paragraphs ()
  ;; (setq paragraph-start ...)
  ;; (setq paragraph-separate ...)
  (setq page-delimiter "^$"))
(defun eab-spacemacs/init-subr ()
  (setq max-specpdl-size 10000)
  (unless window-system ;; Only use in tty-sessions.
    (defvar arrow-keys-map (make-sparse-keymap) "Keymap for arrow keys")
    (define-key esc-map "O" arrow-keys-map)
    (define-key arrow-keys-map "A" 'previous-line)
    (define-key arrow-keys-map "B" 'next-line)
    (define-key arrow-keys-map "C" 'forward-char)
    (define-key arrow-keys-map "D" 'backward-char)))

(defun eab-spacemacs/init-simple ()
  (load "eab-config-simple.el"))

(defun eab-spacemacs/init-ediff ()
  (load "eab-config-ediff.el"))
(defun eab-spacemacs/init-ediff-wind ())
(defun eab-spacemacs/init-ediff-diff ())
(defun eab-spacemacs/init-ispell ()
  (load "eab-config-spell.el"))
(defun eab-spacemacs/init-flyspell ())
(defun eab-spacemacs/init-auto-dictionary () )

(defun eab-spacemacs/init-recentf nil
  (load "eab-config-recentf.el"))
(defun eab-spacemacs/init-ansi-color nil)
(defun eab-spacemacs/init-helm nil
  (load "eab-config-helm.el"))
(defun eab-spacemacs/init-helm-descbinds nil)
(defun eab-spacemacs/init-helm-helm-commands nil)
(defun eab-spacemacs/init-helm-org nil )
(defun eab-spacemacs/init-helm-org-rifle nil )
(defun eab-spacemacs/init-smart-compile nil)
(defun eab-spacemacs/init-popwin nil
  (load "eab-config-popwin.el"))
(defun eab-spacemacs/init-expand-region nil )
(defun eab-spacemacs/init-multiple-cursors nil )
(defun eab-spacemacs/init-flx-isearch ()
  ;; TODO: попробовать разрешить в agenda?
  (flx-isearch-mode 0)
  (setq isearch-search-fun-function 'isearch-search-fun-default))

(defun eab-spacemacs/init-workgroups2/src ()
  (load "eab-config-workgroups2.el"))

(defun eab-spacemacs/init-dictionary nil)

(defun eab-spacemacs/init-magit nil
  (load "eab-config-magit.el"))
(defun eab-spacemacs/init-sqlite3 nil)
(defun eab-spacemacs/init-forge nil)
(defun eab-spacemacs/init-orgit nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               __  __           _           
;;              |  \/  | ___   __| | ___  ___ 
;;              | |\/| |/ _ \ / _` |/ _ \/ __|
;;              | |  | | (_) | (_| |  __/\__ \
;;              |_|  |_|\___/ \__,_|\___||___/
;;                                            
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab-spacemacs/init-logstash-conf nil)
(defun eab-spacemacs/init-nginx-mode nil)
(defun eab-spacemacs/init-julia-mode nil
  (add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode)))
(defun eab-spacemacs/init-racket-mode nil
  (add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode)))
(defun eab-spacemacs/init-typescript-mode nil
  (use-package typescript-mode))
(defun eab-spacemacs/init-rpm-spec-mode ()
  (add-to-list 'auto-mode-alist '("\\.spec\\|\\.spec\\.in" . rpm-spec-mode)))
(defun eab-spacemacs/init-go-mode ()
  (add-hook 'go-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (setq-local tab-width 2)
              ))
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))
(defun eab-spacemacs/init-ssh-config-mode ()
  (use-package ssh-config-mode
    :config
    (eab/add-hook ssh-config-mode-hook eab/ssh-config-hook
      (general-define-key
       :keymaps 'ssh-config-mode-map
       "C-i"        'eab/outline-toggle-children
       "<backtab>"  'eab/outline-toggle-all))
    (add-to-list 'auto-mode-alist '("/\\.ssh/config\\'"     . ssh-config-mode))
    (add-to-list 'auto-mode-alist '("/sshd?_config\\'"      . ssh-config-mode))
    (add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
    (add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode))))
(defun eab-spacemacs/init-textile-mode ()
  (use-package textile-mode
    :config
    (eab/add-hook textile-mode-hook eab/textile-hook
      (general-define-key
       :keymaps 'textile-mode-map
       "C-i"        'eab/outline-toggle-children
       "<backtab>"  'eab/outline-toggle-all))
    (add-hook 'textile-mode-hook (lambda () (toggle-truncate-lines -1)))
    (add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
    (set-face-foreground 'textile-link-face "deep sky blue")
    (set-face-foreground 'textile-code-face "ivory4")
    (set-face-foreground 'textile-style-face "orange red")
    (set-face-foreground 'textile-ul-bullet-face "deep sky blue")))
(defun eab-spacemacs/init-puppet-mode ()
  (use-package puppet-mode
    :config
    (add-to-list 'auto-mode-alist '("\\.pp\\'" . puppet-mode))))
(defun eab-spacemacs/init-yaml-mode ()
  (use-package yaml-mode
    :config
    (eab/add-hook yaml-mode-hook eab/yaml-hook
      (general-define-key
       :keymaps 'yaml-mode-map
       "C-i"        'eab/outline-toggle-children
       "<backtab>"  'eab/outline-toggle-all))
    (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))))
(defun eab-spacemacs/init-ansible ())
(defun eab-spacemacs/init-ansible-doc ())
(defun eab-spacemacs/init-ansible-vault ()
  (setq ansible-vault-pass-file (eab/config "/home/eab/.ansible/passwd_cc"))
  (setq ansible-vault-pass-file (eab/config "/home/eab/.ansible/passwd_fz"))
  (with-temp-buffer (ansible-vault-mode))
  (add-hook 'ansible-vault-mode-hook (lambda () (setq indent-tabs-mode nil)))
  (add-to-list 'auto-mode-alist '("/keys.yml" . ansible-vault-mode)))
(defun eab-spacemacs/init-restclient nil
  (use-package restclient
    :config
    (add-to-list 'auto-mode-alist '("\\.redmine\\'" . restclient-mode))))
(defun eab-spacemacs/init-python-mode nil)
(defun eab-spacemacs/init-python nil
  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (autoload 'python-mode "python-mode" "Python Mode." t)
  (add-hook 'python-mode-hook
            (lambda ()
              (general-define-key
               :keymaps 'python-mode-map
               "C-d"        eab/compile-map
               "C-j"        'nil
               "M-RET"      'newline
               "RET"        'newline))))
(defun eab-spacemacs/init-crontab-mode nil
  (add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."    . crontab-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun eab-spacemacs/init-emamux nil)
(defun eab-spacemacs/init-esup nil)
(defun eab-spacemacs/init-diff-hl nil
  (use-package diff-hl))
(defun eab-spacemacs/init-vterm nil
  (use-package vterm
    :config
    (setq vterm-keymap-exceptions '("C-c" "C-x" "C-u" "C-g" "C-h" "C-l" "M-x" "M-o" "C-v" "M-v" "C-y" "M-y" "M-s" "M-a" "M-i" "M-k" "M-j" "M-l" "C-a" "M-c" "M-p"))
    (defun vterm-send-meta-c-b ()
      "Send `M-<backspace>' to the libvterm."
      (interactive)
      (vterm-send-key "b" nil t t))))
(defun eab-spacemacs/init-eaf nil
  (load "eab-config-eaf.el"))
(defun eab-spacemacs/init-ghostel nil
  (load "eab-config-ghostel.el"))
(defun eab-spacemacs/init-emacs-eat nil
  (load "eab-config-emacs-eat.el"))

(defun eab-spacemacs/init-auctex nil
;; (load "auctex.el" nil t t)
  (use-package eab-tex
    :after (eab-minimal)))
(defun eab-spacemacs/init-org-agenda-property nil)
(defun eab-spacemacs/init-region-bindings-mode nil
  (load "eab-config-region-bindings-mode.el"))
(defun eab-spacemacs/init-smex nil
  (use-package smex)
  (use-package eab-smex
    :after (helm smex eab-minimal)
    :config
    (setq smex-save-file (eab/config (concat (eab/history-dir) ".smex-items")))))
(defun eab-spacemacs/init-smartparens nil )
(defun eab-spacemacs/init-auto-install nil
  (use-package auto-install
    :config
    (setq auto-install-directory (eab/config (concat user-emacs-directory "auto-install/")))))
(defun eab-spacemacs/init-flx-ido nil
  (use-package flx-ido))
(defun eab-spacemacs/init-ido-at-point nil
  (use-package ido-at-point))
(defun eab-spacemacs/init-paredit nil)
(defun eab-spacemacs/init-grep-a-lot nil
  (use-package grep-a-lot))
(defun eab-spacemacs/init-wgrep nil
  (use-package wgrep))
(defun eab-spacemacs/init-ag nil)
(defun eab-spacemacs/init-rg nil
    (use-package rg))
(defun eab-spacemacs/init-wgrep-ag nil)
(defun eab-spacemacs/init-undo-tree nil
  (use-package undo-tree
    :config
    (global-undo-tree-mode)))
(defun eab-spacemacs/init-which-key nil
  (use-package which-key
    :config
    (setq which-key-idle-delay 2)
    (which-key-mode)))
(defun eab-spacemacs/init-diminish nil
  (use-package diminish
    :after (undo-tree which-key)
    :config
    (diminish 'which-key-mode "WK")
    (diminish 'undo-tree-mode "UT")))
(defun eab-spacemacs/init-edit-list ()
  (use-package edit-list
    :after (eab-minimal)
    :config
    (eab/search-word eab/edit-list-at-point "Edit-list at point" eab/edit-list-1 (word))
    (defun eab/edit-list-1 (word)
      (edit-list (intern word)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab-spacemacs/init-docker ())

(defun eab-spacemacs/init-compat nil)
(defun eab-spacemacs/init-elpa-mirror nil)
(defun eab-spacemacs/init-ace-window nil)
(defun eab-spacemacs/init-ace-jump-buffer nil)
(defun eab-spacemacs/init-ace-link nil)
(defun eab-spacemacs/init-request nil)
(defun eab-spacemacs/init-popup nil)
(defun eab-spacemacs/init-idle-highlight-mode nil
  (use-package idle-highlight-mode))
(defun eab-spacemacs/init-fuzzy nil)
(defun eab-spacemacs/init-buffer-move nil
  (use-package buffer-move))

(defun eab-spacemacs/init-shut-up nil)
(defun eab-spacemacs/init-parsebib nil)
(defun eab-spacemacs/init-jedi-core nil)
(defun eab-spacemacs/init-ebib nil
  (use-package ebib
    :config
    (setq ebib-file-search-dirs (eab/config '`("~/git/lit/")))
    (setq ebib-preload-bib-files (eab/config '`("~/git/lit/boykov.bib")))
    (autoload 'ebib "ebib" "Ebib, a BibTeX database manager." t)))
(defun eab-spacemacs/init-dockerfile-mode nil)
(defun eab-spacemacs/init-ewmctrl nil)
(defun eab-spacemacs/init-anaphora nil)
(defun eab-spacemacs/init-connection nil)
(defun eab-spacemacs/init-link nil)
(defun eab-spacemacs/init-oneonone nil
  (use-package oneonone))
(defun eab-spacemacs/init-emacsc nil
  (use-package emacsc))
(defun eab-spacemacs/init-deferred nil)
(defun eab-spacemacs/init-web-server nil)
(defun eab-spacemacs/init-take-off nil)
(defun eab-spacemacs/init-wide-n nil)
(defun eab-spacemacs/init-god-mode nil
  (use-package god-mode
    :disabled
    :config
    (setq god-mod-alist
          '(("g" . "C-")
            (nil . "M-")
            ("G" . "C-M-")))))
(defun eab-spacemacs/init-fancy-narrow nil)
(defun eab-spacemacs/init-goto-chg nil)
(defun eab-spacemacs/init-epc nil)
(defun eab-spacemacs/init-ctable nil)
(defun eab-spacemacs/init-concurrent nil)
(defun eab-spacemacs/init-python-environment nil)
(defun eab-spacemacs/init-jedi nil)
(defun eab-spacemacs/init-bibretrieve nil)
(defun eab-spacemacs/init-websocket nil
  (use-package websocket))

(defun eab-spacemacs/init-pkg-info nil)
(defun eab-spacemacs/init-epl nil)
(defun eab-spacemacs/init-python-info nil)
(defun eab-spacemacs/init-achievements nil
  (use-package achievements
    :config
    (setq achievements-file (eab/config (concat (eab/history-dir) ".achievements")))))
(defun eab-spacemacs/init-org-grep nil)
(defun eab-spacemacs/init-ov nil)
(defun eab-spacemacs/init-peg nil)
(defun eab-spacemacs/init-org-super-agenda nil)
(defun eab-spacemacs/init-org-special-block-extras nil)
(defun eab-spacemacs/init-org-sql nil
  (use-package org-sql
    :defer))
(defun eab-spacemacs/init-org-transclusion nil
  (use-package org-transclusion))
(defun eab-spacemacs/init-org-ql nil
  (use-package org-ql)
  (use-package org-ql-search
    :config
    (setq org-link-parameters
          (remove
           '("org-ql-search" :follow org-ql-view--link-follow
             :store org-ql-view--link-store)
           org-link-parameters)))
  (use-package helm-org-ql
    :after (org-ql)
    :config
    (add-to-list 'helm-org-ql-actions '("eab/hron-todo" . eab/helm-hron-todo))))
(defun eab-spacemacs/init-aaorg nil
  (load "eab-config-aaorg.el"))
(defun eab-spacemacs/init-org-mode-fix/lisp nil
  ;; fix 'file is already exist' bug
  (setq org-babel-temporary-directory "/tmp/user/1000/babel-aa5I6G"))
(defun eab-spacemacs/init-f nil)
(defun eab-spacemacs/init-keyfreq nil
  (use-package keyfreq
    :config
    (setq keyfreq-file (eab/config (concat (eab/history-dir) ".emacs.keyfreq." system-name)))
    (setq keyfreq-file-lock (eab/config (concat (eab/history-dir) ".emacs.keyfreq.lock." system-name)))
    (keyfreq-mode 1)
    (keyfreq-autosave-mode 1)))
(defun eab-spacemacs/init-cask nil
  (use-package cask
    :config
    (cask-initialize)))
(defun eab-spacemacs/init-pallet nil
  (use-package pallet
    :config
    (pallet-init)))
(defun eab-spacemacs/init-ob-tmux nil
    (use-package ob-tmux))
(defun eab-spacemacs/init-purty-mode nil
  (use-package purty-mode))
(defun eab-spacemacs/init-flx nil)
(defun eab-spacemacs/init-guide-key nil
  (use-package guide-key
    :config
    (guide-key-mode 1)))
(defun eab-spacemacs/init-xml-rpc nil)
(defun eab-spacemacs/init-web nil)
(defun eab-spacemacs/init-string-edit-at-point nil
  (use-package string-edit-at-point))
(defun eab-spacemacs/init-redo+ nil
  (use-package redo+))
(defun eab-spacemacs/init-pcache nil)
(defun eab-spacemacs/init-org-ehtml nil)
(defun eab-spacemacs/init-noflet nil)
(defun eab-spacemacs/init-minimap nil)
(defun eab-spacemacs/init-markdown-mode nil
  (use-package markdown-mode
    :config
    (eab/add-hook markdown-mode-hook eab/markdown-hook
      (general-define-key
       :keymaps 'markdown-mode-map
       "C-M-b"      'nil
       "C-M-f"      'nil
       "M-l"        'nil
       "M-i"        'nil
       "M-n"        'nil
       "M-p"        'nil
       "<tab>"      'nil))
    (push '("\\.md\\'" . markdown-mode) auto-mode-alist)
    (add-hook 'markdown-mode-hook (lambda () (setq indent-tabs-mode nil)))
    (add-to-list 'auto-mode-alist
                 '("stack\\(exchange\\|overflow\\)\\.com\\.[a-z0-9]+\\.txt"
                   . markdown-mode))))
(defun eab-spacemacs/init-auto-complete nil
  (use-package auto-complete
    :config
    (eab/add-hook auto-complete-mode-hook eab/ac-complete-mode-hook
      (general-define-key
       :keymaps 'ac-completing-map
       "\C-s"       'ac-isearch)
      (general-define-key
       :keymaps 'ac-complete-mode-map
       "M-c"        'ac-expand-common
       "M-k"        'ac-next
       "M-i"        'ac-previous)))
  (use-package auto-complete-config)
  (use-package mode-local)
  (use-package eab-auto-complete
    :after (org)
    :config
    (setq ac-comphist-file (eab/config (concat (eab/history-dir) "ac-comphist.dat")))
    (defun eab/read-lines (file)
      "Return a list of lines of a file at at FPATH."
      (if (file-exists-p file)
          (with-temp-buffer
            (insert-file-contents file)
            (split-string (buffer-string) "\n" t))))
    (setq eab/american-english (eab/config '(eab/read-lines "/usr/share/dict/american-english")))
    (defvar-mode-local org-mode ac-auto-start nil)
    (defvar-mode-local org-mode ac-use-quick-help nil)))
(defun eab-spacemacs/init-yasnippet nil
  (use-package yasnippet
    :after (org)
    :config

    (setq yas-snippet-dirs '())
    ;; cd el-get && git clone https://github.com/AndreaCrotti/yasnippet-snippets
    (add-to-list 'yas-snippet-dirs (eab/config (concat eab-spacemacs-path "snippets")))

    (setq yas-key-syntaxes '("w_" "w_." "w_.()" "^ "))

    (defun yas-org-very-safe-expand ()
      (yas-minor-mode 't)
      (let ((yas-fallback-behavior 'return-nil))
        (yas-expand)))

    (add-hook 'org-mode-hook
              (lambda ()
                (make-variable-buffer-local 'yas-trigger-key)
                (setq yas-trigger-key [tab])
                (add-to-list 'org-tab-first-hook 'yas-org-very-safe-expand)
                (define-key yas-keymap [tab] 'yas-next-field)))))
(defun eab-spacemacs/init-kv nil)
(defun eab-spacemacs/init-ignoramus nil
  (use-package ignoramus
    :config
    (ignoramus-setup)))
(defun eab-spacemacs/init-ibuffer-vc nil)
(defun eab-spacemacs/init-highlight nil)
(defun eab-spacemacs/init-highlight-indentation nil)
(defun eab-spacemacs/init-prettier nil)
(defun eab-spacemacs/init-graphviz-dot-mode nil
  (eab/add-hook graphviz-dot-mode-hook eab/graphviz-hook
    (general-define-key
     :keymaps 'graphviz-dot-mode-map
     "C-d"        eab/compile-map)
    (set (make-local-variable 'compile-command) nil)))
(defun eab-spacemacs/init-gist nil)
(defun eab-spacemacs/init-gh nil)
(defun eab-spacemacs/init-fuzzy-match nil)
(defun eab-spacemacs/init-feature-mode nil
  (add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode)))
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
    :after (org)))
(defun eab-spacemacs/init-eev-current nil
  (use-package eev-all)
  (use-package eev-browse-url)
  (use-package eev-mini-steps)
  (use-package eab-eepitch
    :after (eev-all eev-browse-url eev-mini-steps)
    :config
    (setq eab/eeansi-path (eab/config (expand-file-name "~/.eev/eeansi.sh")))
    (setq eab/eegchannel-path
          (eab/config
           (expand-file-name (concat eab-spacemacs-path "local/eev-current/eegchannel"))))
    (setq vterm-shell eab/eeansi-path)))
(defun eab-spacemacs/init-bbdb/lisp nil
  (use-package bbdb
    :config
    (setq bbdb-file (eab/config (concat user-emacs-directory "eab-private/.bbdb")))
    (bbdb-initialize 'gnus 'message 'sc) ;; 'w3m)
    (setq bbdb-north-american-phone-numbers-p nil))
  (use-package bbdb-loaddefs)
  (use-package bbdb-anniv))
(defun eab-spacemacs/init-eab-misc nil
  (load "eab-config-eab-misc.el"))

(defun eab-spacemacs/init-gnus nil
  (use-package eab-gnus :disabled
    :config
    (add-hook 'gnus-summary-prepared-hook 'gnus-summary-hide-all-threads)
    (add-hook 'gnus-summary-prepare-hook 'gnus-summary-sort-by-most-recent-date)))

(defun eab-spacemacs/init-tramp nil
  (use-package eab-tramp))

(defun eab-spacemacs/init-outline nil
  (use-package eab-outline
    :after (eab-minimal)))
(defun eab-spacemacs/init-window nil
  (use-package eab-window))
(defun eab-spacemacs/init-appt nil
  (use-package appt
    :config
    (setq appt-message-warning-time 12)
    (setq appt-display-interval 12)))
(defun eab-spacemacs/init-desktop nil
  (use-package desktop)
  (use-package eab-desktop
    :after (desktop appt autorevert eab-workgroups2)))
(defun eab-spacemacs/init-server nil)
(defun eab-spacemacs/init-compile nil
  (load "eab-config-compile.el"))
(defun eab-spacemacs/init-eab-gr nil
  (use-package eab-gr
    :after (eab-compile eab-notify)))
(defun eab-spacemacs/init-grep nil
  (load "eab-config-grep.el"))
(defun eab-spacemacs/init-dired nil
  (load "eab-config-dired.el"))

(defun eab-spacemacs/init-ido nil
  (use-package eab-ido
    :after (flx-ido projectile eab-minimal)
    :config
    (setq ido-save-directory-list-file
          (eab/config (concat (eab/history-dir) ".ido.last")))))
(defun eab-spacemacs/init-abbrev nil)
(defun eab-spacemacs/init-bookmark nil
  (use-package bookmark)
  (use-package eab-bookmark
    :after (bookmark eab-minimal eab-workgroups2)))

(defun eab-spacemacs/init-ibuffer ())
(defun eab-spacemacs/init-eab-ace-jump-mode ())
(defun eab-spacemacs/init-eab-avy ()
  (load "eab-config-avy.el"))

(defun eab-spacemacs/init-eab-minimal ()
  (use-package eab-minimal
    :after (eab-notify)))
(defun eab-spacemacs/init-eab-workflow ()
  (use-package eab-workflow))
(defun eab-spacemacs/init-eab-ui ()
  (use-package eab-ui
    :config
    (setq auto-save-list-file-prefix (eab/config (concat (eab/history-dir) "auto-save-list/.saves-")))
    (setq save-place-file (eab/config (concat (eab/history-dir) ".emacs-places")))
    (setq url-configuration-directory (eab/config (concat (eab/history-dir) "url/")))
    (eab/config
     (cond ((eab/onhost "kairos")       (setq source-directory "~/data/github/emacs/src"))
           ((eab/onhost "chronos")      (setq source-directory "~/data/github/emacs/src"))
           ((eab/onhost "kairos-emacs") (setq source-directory "~/data/github/emacs/src"))
           ((eab/onhost "chronos-emacs")(setq source-directory "~/data/github/emacs/src"))
           ((eab/onhost "cyclos-emacs") (setq source-directory "~/data/github/emacs/src"))))
    (setq find-function-C-source-directory source-directory)
    (setq custom-file (eab/config (concat (eab/history-dir) "custom.el")))))
(defun eab-spacemacs/init-eab-org ()
  (load "eab-config-eab-org.el"))
(defun eab-spacemacs/user-config ()
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;           ____ _       _           _
  ;;          / ___| | ___ | |__   __ _| |
  ;;         | |  _| |/ _ \| '_ \ / _` | |
  ;;         | |_| | | (_) | |_) | (_| | |
  ;;          \____|_|\___/|_.__/ \__,_|_|
  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Global

  (general-define-key
   "C-M-f"        'toggle-frame-maximized
   "C-M-:"        'isearch-backward-regexp
   "C-M-;"        'isearch-forward-regexp
   "C-h C-c"      'describe-command
   "C-h c"        'eab/describe-key-briefly
   "C-h C-f"      'eab/find-function-at-point
   "C-h C-k"      'eab/describe-key-find
   "C-h C-v"      'eab/find-variable-at-point
   )

  (general-define-key
   "C-c a"        'org-agenda
   "C-c C-M-p"    'org-open-at-point-global
   "C-c C-l"      'org-insert-link
   "C-c l"        'org-store-link
   "C-c r"        'org-capture
   "C-x C-M-p"    'org-open-at-point-global
   "M-z"          'undo
   "C-b"          'switch-to-buffer
   "M-a"          'execute-extended-command
   "C-t"          'transpose-sexps
   "M-m"          'forward-sexp
   "M-n"          'backward-sexp
   "M-q"          'kill-current-buffer
   "C-i"          'indent-for-tab-command
   "C-m"          'newline
   "C-@"          'set-mark-command
   "C-S-a"        'eval-expression
   "C-S-b"        'select-frame-by-name
   "C-S-s"        'write-file
   "C-SPC"        'set-mark-command
   "S-SPC"        'nil
   "C-c M-f"      'find-file-at-point
   "C-k"          'toggle-input-method
   "C-o"          'find-file
   "C-x C-d"      'dired-jump
   "C-x C-e"      'eval-defun
   "C-x C-k k"    'kill-region
   "C-x M-f"      'find-file-at-point
   "C-x c"        'customize-variable
   "C-x e"        'eval-last-sexp
   "C-x j"        'comment-region
   "C-x o"        'other-window
   "C-x Q"        'eab/kbd-macro-query
   "C-z"          'repeat
   "M-!"          'delete-window
   "M-%"          'query-replace-regexp
   "M-&"          'count-matches
   "M-'"          'comment-dwim
   "M-<"          'kmacro-start-macro
   "M-."          'kmacro-edit-macro
   "M-,"          'eab/kmacro-end-or-call-macro
   "C-M-,"        'eab/pm-write-last-kbd-macro
   "M-/"          'dabbrev-expand
   "M-1"          'delete-other-windows
   "M-2"          'split-window-vertically
   "M-5"          'query-replace
   "M-:"          'isearch-backward
   "M-;"          'isearch-forward
   "M-@"          'split-window-horizontally
   "M-B"          'backward-kill-sexp
   "M-C"          'copy-all
   "M-H"          'move-end-of-line
   "M-I"          'scroll-down
   "M-J"          'beginning-of-buffer
   "M-K"          'scroll-up
   "M-L"          'end-of-buffer
   "M-M"          'end-of-defun
   "M-N"          'beginning-of-defun
   "M-O"          'forward-paragraph
   "C-S-SPC"      'mark-defun
   "M-S-SPC"      'org-mark-paragraph
   "M-SPC"        'set-mark-command
   "C-M-@"        'set-rectangular-region-anchor
   "M-U"          'backward-paragraph
   "M-X"          'delete-region
   "M-b"          'kill-sexp
   "M-c"          'kill-ring-save
   "M-e"          'backward-kill-word
   "M-f"          'delete-char
   "M-F"          'delete-backward-char
   "M-g"          'kill-line
   "M-h"          'move-beginning-of-line
   "M-i"          'previous-line
   "M-j"          'backward-char
   "C-M-j"        'delete-backward-char
   "M-k"          'next-line
   "M-l"          'forward-char
   "M-o"          'forward-word
   "M-p"          'move-end-of-line
   "M-r"          'kill-word
   "M-u"          'backward-word
   "M-v"          'yank
   "M-x"          'kill-region
   ;; "M-y"               'god-mode-all
   )

  (general-define-key
   "<f10>"        'eab/flyspell-buffer
   "<f12>"        'eab/make-list-paths
   "<f6>"         'eab/revert-buffer
   "<f7>"         'eab/fix-windows-coding
   "<print>"      'eab/make-list-paths
   "C-,"          'eab/eepitch-this-line
   "C-r"          'eab/eepitch-this-line
   "C-M-r"        'eab/eepitch-paragraph
   "M-DEL"        'eab/completion-at-point
   "C-j"          'eab/completion-at-point
   "C-c RET"      'org-return
   "C-c c"        'eab/add-eab-abbrev
   "C-c d"        'nil
   "C-c O"        'eab/open-corresponding-html
   "C-c B"        'eab/open-heading-browser
   "C-c b"        'browse-url
   "C-c s"        'eab/org-agenda-search
   "C-c u"        'eab/unbound-var
   "C-c U"        'eab/unbound-fun
   "C-c v"        'nil
   "C-c w"        'nil
   "C-c e"        'eab/edit-list-at-point
   "C-x b"        'switch-to-buffer
   "C-x C-b"      'ibuffer
   "C-x g"        'eab/grep
   "C-x C-g"      (kbd "C-u C-x g")
   "M-."          'nil
   "M-A"          'eab/call-shell-command
   )

  ;; shell and shell-utils
  (general-define-key
   "C-S-f"        'eab/gr-status)

  (general-define-key
   "C-c i"        'yas-expand)

  (general-define-key
   "M-?"          'auto-complete
   "C-c g"        'eab/google
   "M-z"          'undo-tree-undo
   "C-b"          'eab/cxb
   "M-a"          'eab/smex-limited-commands
   "C-t"          'sp-transpose-sexp
   "M-m"          'sp-forward-sexp
   "M-n"          'sp-backward-sexp
   "C-:"          'isearch-moccur
   "C-c t"        'dictionary-search
   "C-f"          eab/explore-map
   "C-p"          'er/expand-region
   "C-x C-k d"    'pm-define
   "C-x C-k e"    'pm-switch-buf
   "C-x t"        'dictionary-search
   "M-V"          'helm-show-kill-ring
   "M-Z"          'undo-tree-redo
   )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;        _           _ _ _        _
  ;;       | |__  _   _(_) | |_     (_)_ __
  ;;       | '_ \| | | | | | __|____| | '_ \
  ;;       | |_) | |_| | | | ||_____| | | | |
  ;;       |_.__/ \__,_|_|_|\__|    |_|_| |_|
  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; built-in

  (general-define-key
   :keymaps 'isearch-mode-map
   "M-p"  'nil
   "M-n"  'nil
   "M-y"  'nil
   "M-c"  'nil
   "M-s"  'nil
   "C-y"  'nil
   "C-l"  'nil
   "M-r"  'isearch-edit-string
   "C-e"  'isearch-edit-string
   "M-;"  'isearch-repeat-forward
   "M-:"  'isearch-repeat-backward
   "M-v"  'isearch-yank-kill
   "M-k"  'isearch-ring-advance
   "M-i"  'isearch-ring-retreat
   "C-k"  'isearch-toggle-input-method
   "M-5"  'isearch-query-replace)

  (general-define-key
   :keymaps 'read-expression-map
   "M-g"  'nil)
  
  (general-define-key
   :keymaps 'query-replace-map
   "C-e"  'edit
   "C-r"  'delete-and-edit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;                 _     _       _                 _
  ;;        __ _  __| | __| |     | |__   ___   ___ | | __
  ;;       / _` |/ _` |/ _` |_____| '_ \ / _ \ / _ \| |/ /
  ;;      | (_| | (_| | (_| |_____| | | | (_) | (_) |   <
  ;;       \__,_|\__,_|\__,_|     |_| |_|\___/ \___/|_|\_\
  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; add-hook

  (eab/add-hook fortran-mode-hook eab/fortran-hook
    (general-define-key
     :keymaps 'fortran-mode-map
     "C-d"        eab/compile-map))

  (eab/add-hook text-mode-hook eab/text-hook
    (general-define-key
     :keymaps 'text-mode-map
     "C-c C-c"    'server-edit))

  (define-advice artist-mode (:before (&rest args) eab-artist-mode)
    (general-define-key
     :keymaps 'artist-mode-map
     "C-b"        'nil))

  (eab/add-hook nroff-mode-hook eab/nroff-hook
    (general-define-key
     :keymaps 'nroff-mode-map
     "M-s"        'nil
     "M-n"        'nil
     "M-p"        'nil))
  
  (eab/add-hook f90-mode-hook eab/f90-hook
    (general-define-key
     :keymaps 'f90-mode-map
     "C-j"        'nil
     "C-d"        eab/compile-map))

  (eab/add-hook message-mode-hook eab/message-hook
    (general-define-key
     :keymaps 'message-mode-map
     "C-c C-c"    'eab/message-send
     "M-;"        'nil
     "M-n"        'nil))

  (eab/add-hook makefile-gmake-mode-hook eab/makefile-gmake-mode
    (general-define-key
     :keymaps 'makefile-gmake-mode-map
     "\C-d"       eab/compile-map
     "M-n"        'nil
     "M-p"        'nil))

  (eab/add-hook java-mode-hook eab/java-hook
    (general-define-key
     :keymaps 'java-mode-map
     "M-M"        'c-end-of-defun
     "M-N"        'c-beginning-of-defun
     "M-j"        'nil
     "M-a"        'nil
     "M-e"        'nil))

  (eab/add-hook c-mode-hook eab/c-hook
    (general-define-key
     :keymaps 'c-mode-map
     "C-d"        eab/compile-map
     "C-M-a"      'nil
     "C-M-e"      'nil
     "M-a"        'nil
     "M-M"        'nil
     "M-N"        'nil
     "M-j"        'nil
     "M-q"        'nil
     "M-M"        'c-end-of-defun
     "M-N"        'c-beginning-of-defun
     "M-e"        'nil))

  (eab/add-hook c++-mode-hook eab/c++-hook
    (general-define-key
     :keymaps 'c++-mode-map
     "C-d"        eab/compile-map
     "C-M-a"      'nil
     "C-M-e"      'nil
     "M-a"        'nil
     "M-M"        'nil
     "M-N"        'nil
     "M-j"        'nil
     "M-q"        'nil
     "M-M"        'c-end-of-defun
     "M-N"        'c-beginning-of-defun
     "M-e"        'nil))

  (eab/add-hook ruby-mode-hook eab/ruby-hook
    (general-define-key
     :keymaps 'ruby-mode-map
     "C-d"        eab/compile-map
     "C-M-b"      'nil))
  
  (add-to-list 'auto-mode-alist '("\\.tmpl$" . conf-mode))
  (add-to-list 'auto-mode-alist '("AUTOEXEC\\." . 'bat-mode))
  (add-to-list 'auto-mode-alist '("CONFIG\\." . 'bat-mode))
  (add-to-list 'auto-mode-alist '("\\.F90\\'" . f90-mode))
  (add-to-list 'auto-mode-alist '("\\.[bB][aA][tT]$" . 'bat-mode))
  (add-to-list 'auto-mode-alist '("\\.lsp\\'" . lisp-mode))
  (add-to-list 'auto-mode-alist '("\\.rtf\\'" . rtf-mode))

  (autoload 'rtf-mode "rtf-mode" "RTF" t)
  (autoload 'bat-mode "bat-mode" "DOS and WIndows BAT files" t)
  )
