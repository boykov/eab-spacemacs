;;; packages.el --- eab Layer packages File for Spacemacs -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defmacro eab/config (&rest body) (car `,@body))

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
(use-package general)
(use-package auto-install
  :config
  (setq auto-install-directory
        (eab/config (concat user-emacs-directory "auto-install/"))))
(load "eab-config-mode.el")
(use-package eab-minimal
  :after (eab-notify)
  :config
  (general-define-key
   "M-<"          'kmacro-start-macro
   "M-."          'kmacro-edit-macro
   "M-,"          'eab/kmacro-end-or-call-macro
   "C-x Q"        'eab/kbd-macro-query)
  )
(use-package eab-config-simple
  :after (eab-minimal))
(load "eab-config-aaorg.el")
(load "eab-config-workgroups2.el")
(load "eab-config-gptel.el")
(load "eab-config-ellama.el")
(load "eab-config-daemons.el")
(load "eab-config-ergoemacs.el")
(load "eab-config-projectile.el")
(load "eab-config-browse-url.el")
(use-package eab-config-term
    :after (eab-minimal eab-notify))
(load "eab-config-ediff.el")
(load "eab-config-spell.el")
(load "eab-config-recentf.el")
(load "eab-config-helm.el")
(load "eab-config-magit.el")
(load "eab-config-eaf.el")
(load "eab-config-ghostel.el")
(load "eab-config-emacs-eat.el")
(load "eab-config-region-bindings-mode.el")
(load "eab-config-complete.el")
(use-package eab-config-eab-misc
  :load-path "~/.emacs.d/private/eab-spacemacs/local/eab-misc")
(load "eab-config-compile.el")
(load "eab-config-grep.el")
(load "eab-config-dired.el")
(load "eab-config-avy.el")
(load "eab-config-eab-org.el")
(use-package eab-bookmark
  :after (eab-minimal eab-workgroups2))
(use-package eab-gr
  :after (eab-compile eab-notify))
(use-package eab-workflow
  :config
  (general-define-key
   "<f7>"         'eab/fix-windows-coding
   "<f6>"         'eab/revert-buffer
   "C-c u"        'eab/unbound-var
   "C-c U"        'eab/unbound-fun
   ))
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
  (setq custom-file (eab/config (concat (eab/history-dir) "custom.el"))))
(use-package eab-ido
  :after (projectile eab-minimal)
  :config
  (general-define-key
   "C-b"          'eab/cxb
   )
  (setq ido-save-directory-list-file
        (eab/config (concat (eab/history-dir) ".ido.last"))))
(use-package eab-desktop
  :after (desktop appt autorevert eab-workgroups2))
(use-package eab-window)
(use-package eab-outline
  :after (eab-minimal))
(use-package eab-tramp)
(use-package eab-eepitch
  :config
  (general-define-key
   "C-,"          'eab/eepitch-this-line
   "C-r"          'eab/eepitch-this-line
   "C-M-r"        'eab/eepitch-paragraph
   )
  (setq eab/eeansi-path (eab/config (expand-file-name "~/.eev/eeansi.sh")))
  (setq eab/eegchannel-path
        (eab/config
         (expand-file-name (concat eab-spacemacs-path "local/eev-current/eegchannel"))))
  (setq vterm-shell eab/eeansi-path))

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
  (setq epa-pinentry-mode 'loopback))

(use-package vterm
  :config
  (setq vterm-keymap-exceptions '("C-c" "C-x" "C-u" "C-g" "C-h" "C-l" "M-x" "M-o" "C-v" "M-v" "C-y" "M-y" "M-s" "M-a" "M-i" "M-k" "M-j" "M-l" "C-a" "M-c" "M-p"))
  (defun vterm-send-meta-c-b ()
    "Send `M-<backspace>' to the libvterm."
    (interactive)
    (vterm-send-key "b" nil t t)))

;; (load "auctex.el" nil t t)
(use-package eab-tex)


(use-package eab-smex
  :after (helm smex eab-minimal)
  :config
  (general-define-key
   :keymaps 'minibuffer-local-map
   "M-a"          'eab/smex-extended
   "C-w"          'eab/smex-repeat)
  (general-define-key
   "M-a"          'eab/smex-limited-commands)
  (setq smex-save-file (eab/config (concat (eab/history-dir) ".smex-items"))))
(use-package undo-tree
  :config
  (general-define-key
   "M-z"          'undo-tree-undo
   "M-Z"          'undo-tree-redo
   )
  (global-undo-tree-mode))
(use-package which-key
  :defer
  :config
  (setq which-key-idle-delay 2)
  (which-key-mode))
(use-package diminish
  :after (undo-tree which-key)
  :config
  (diminish 'which-key-mode "WK")
  (diminish 'undo-tree-mode "UT"))
(use-package buffer-move
  :config
  (defun buf-move ()
    "Begin moving the current buffer to different windows.

Use the arrow keys to move in the desired direction.  Pressing
any other key exits this function."
    (interactive)
    (let ((map (make-sparse-keymap)))
      (dolist (x '(("M-i" . buf-move-up)
                   ("M-j" . buf-move-left)
                   ("M-k" . buf-move-down)
                   ("M-l" . buf-move-right)))
        (define-key map (read-kbd-macro (car x)) (cdr x)))
      (set-transient-map map t))))
(use-package guide-key
  :config
  (guide-key-mode 1))
(use-package string-edit-at-point)
(use-package redo+
  :config
  (general-define-key
   "M-z"          'undo))

(general-define-key
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
 "C-x C-e"      'eval-defun
 "C-x C-k k"    'kill-region
 "C-x M-f"      'find-file-at-point
 "C-x c"        'customize-variable
 "C-x e"        'eval-last-sexp
 "C-x j"        'comment-region
 "C-x o"        'other-window
 "C-z"          'repeat
 "M-!"          'delete-window
 "M-%"          'query-replace-regexp
 "M-&"          'count-matches
 "M-'"          'comment-dwim
 "M-/"          'dabbrev-expand
 "M-1"          'delete-other-windows
 "M-2"          'split-window-vertically
 "M-5"          'query-replace
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
 )

(general-define-key
 "C-c d"        'nil
 "C-c b"        'browse-url
 "C-c v"        'nil
 "C-c w"        'nil
 "C-x b"        'switch-to-buffer
 "M-."          'nil
 )

(general-define-key
 :keymaps 'query-replace-map
 "C-e"  'edit
 "C-r"  'delete-and-edit)

(defvar eab-spacemacs-packages
  `(
    solarized-theme
    spacemacs-theme
    diminish
    which-key
    package-lint
    
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

(defun eab-spacemacs/init-package-lint nil)
(defun eab-spacemacs/init-zoutline nil)
(defun eab-spacemacs/init-iedit nil)
(defun eab-spacemacs/init-lispy nil)
(defun eab-spacemacs/init-ox-pandoc nil)
(defun eab-spacemacs/init-elisa nil)
(defun eab-spacemacs/init-ai-code nil )
(defun eab-spacemacs/init-gptel-agent nil )
(defun eab-spacemacs/init-llm ())
(defun eab-spacemacs/init-prodigy nil)
(defun eab-spacemacs/init-solarized-theme nil)
(defun eab-spacemacs/init-s ())
(defun eab-spacemacs/init-groovy-mode ())
(defun eab-spacemacs/init-terraform-mode ())
(defun eab-spacemacs/init-kubernetes nil)
(defun eab-spacemacs/init-k8s-mode ())
(defun eab-spacemacs/init-rust-mode ())
(defun eab-spacemacs/init-so-long ())
(defun eab-spacemacs/init-git-timemachine ())
(defun eab-spacemacs/init-git-wip-timemachine ())
(defun eab-spacemacs/init-xterm-color ())
(defun eab-spacemacs/init-tramp-term () )
(defun eab-spacemacs/init-vagrant nil)
(defun eab-spacemacs/init-vagrant-tramp nil)
(defun eab-spacemacs/init-csv-mode nil)
(defun eab-spacemacs/init-el-patch nil)
(defun eab-spacemacs/init-consult nil)
(defun eab-spacemacs/init-consult-omni nil)
(defun eab-spacemacs/init-ldap-mode nil)
(defun eab-spacemacs/init-general ())
(defun eab-spacemacs/init-php-mode nil)
(defun eab-spacemacs/init-sql-indent nil)
(defun eab-spacemacs/init-gnuplot nil)
(defun eab-spacemacs/init-htmlize nil )
(defun eab-spacemacs/init-key-chord ())
(defun eab-spacemacs/init-autorevert nil)
(defun eab-spacemacs/init-spacemacs-theme ())
(defun eab-spacemacs/init-gptel nil)
(defun eab-spacemacs/init-gptel-magit nil)
(defun eab-spacemacs/init-ellama nil)
(defun eab-spacemacs/init-daemons nil)
(defun eab-spacemacs/init-ergoemacs-mode nil)
(defun eab-spacemacs/init-projectile nil)
(defun eab-spacemacs/init-browse-url ())
(defun eab-spacemacs/init-epa ())
(defun eab-spacemacs/init-term ())
(defun eab-spacemacs/init-comint ())
(defun eab-spacemacs/init-paragraphs ())
(defun eab-spacemacs/init-subr ())
(defun eab-spacemacs/init-simple ())
(defun eab-spacemacs/init-ediff ())
(defun eab-spacemacs/init-ediff-wind ())
(defun eab-spacemacs/init-ediff-diff ())
(defun eab-spacemacs/init-ispell ())
(defun eab-spacemacs/init-flyspell ())
(defun eab-spacemacs/init-auto-dictionary () )
(defun eab-spacemacs/init-recentf nil)
(defun eab-spacemacs/init-ansi-color nil)
(defun eab-spacemacs/init-helm nil)
(defun eab-spacemacs/init-helm-descbinds nil)
(defun eab-spacemacs/init-helm-helm-commands nil)
(defun eab-spacemacs/init-helm-org nil )
(defun eab-spacemacs/init-helm-org-rifle nil )
(defun eab-spacemacs/init-smart-compile nil)
(defun eab-spacemacs/init-popwin nil)
(defun eab-spacemacs/init-expand-region nil )
(defun eab-spacemacs/init-multiple-cursors nil )
(defun eab-spacemacs/init-flx-isearch ())
(defun eab-spacemacs/init-workgroups2/src ())
(defun eab-spacemacs/init-dictionary nil)
(defun eab-spacemacs/init-magit nil)
(defun eab-spacemacs/init-sqlite3 nil)
(defun eab-spacemacs/init-forge nil)
(defun eab-spacemacs/init-orgit nil)
(defun eab-spacemacs/init-logstash-conf nil)
(defun eab-spacemacs/init-nginx-mode nil)
(defun eab-spacemacs/init-julia-mode nil)
(defun eab-spacemacs/init-racket-mode nil)
(defun eab-spacemacs/init-typescript-mode nil)
(defun eab-spacemacs/init-rpm-spec-mode ())
(defun eab-spacemacs/init-go-mode ())
(defun eab-spacemacs/init-ssh-config-mode () )
(defun eab-spacemacs/init-textile-mode ())
(defun eab-spacemacs/init-puppet-mode ())
(defun eab-spacemacs/init-yaml-mode ())
(defun eab-spacemacs/init-ansible ())
(defun eab-spacemacs/init-ansible-doc ())
(defun eab-spacemacs/init-ansible-vault ())
(defun eab-spacemacs/init-restclient nil)
(defun eab-spacemacs/init-python-mode nil)
(defun eab-spacemacs/init-python nil)
(defun eab-spacemacs/init-crontab-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab-spacemacs/init-emamux nil)
(defun eab-spacemacs/init-esup nil)
(defun eab-spacemacs/init-diff-hl nil)
(defun eab-spacemacs/init-vterm nil)
(defun eab-spacemacs/init-eaf nil)
(defun eab-spacemacs/init-ghostel nil)
(defun eab-spacemacs/init-emacs-eat nil)

(defun eab-spacemacs/init-auctex nil)
(defun eab-spacemacs/init-org-agenda-property nil)
(defun eab-spacemacs/init-region-bindings-mode nil)
(defun eab-spacemacs/init-smex nil)
(defun eab-spacemacs/init-smartparens nil )
(defun eab-spacemacs/init-auto-install nil)
(defun eab-spacemacs/init-flx-ido nil)
(defun eab-spacemacs/init-ido-at-point nil)
(defun eab-spacemacs/init-paredit nil)
(defun eab-spacemacs/init-grep-a-lot nil)
(defun eab-spacemacs/init-wgrep nil)
(defun eab-spacemacs/init-ag nil)
(defun eab-spacemacs/init-rg nil)
(defun eab-spacemacs/init-wgrep-ag nil)
(defun eab-spacemacs/init-undo-tree nil)
(defun eab-spacemacs/init-which-key nil)
(defun eab-spacemacs/init-diminish nil)
(defun eab-spacemacs/init-edit-list ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab-spacemacs/init-docker ())
(defun eab-spacemacs/init-compat nil)
(defun eab-spacemacs/init-elpa-mirror nil)
(defun eab-spacemacs/init-ace-window nil)
(defun eab-spacemacs/init-ace-jump-buffer nil)
(defun eab-spacemacs/init-ace-link nil)
(defun eab-spacemacs/init-request nil)
(defun eab-spacemacs/init-popup nil)
(defun eab-spacemacs/init-idle-highlight-mode nil)
(defun eab-spacemacs/init-fuzzy nil)
(defun eab-spacemacs/init-buffer-move nil)

(defun eab-spacemacs/init-shut-up nil)
(defun eab-spacemacs/init-parsebib nil)
(defun eab-spacemacs/init-jedi-core nil)
(defun eab-spacemacs/init-ebib nil)
(defun eab-spacemacs/init-dockerfile-mode nil)
(defun eab-spacemacs/init-ewmctrl nil)
(defun eab-spacemacs/init-anaphora nil)
(defun eab-spacemacs/init-connection nil)
(defun eab-spacemacs/init-link nil)
(defun eab-spacemacs/init-oneonone nil)
(defun eab-spacemacs/init-emacsc nil)
(defun eab-spacemacs/init-deferred nil)
(defun eab-spacemacs/init-web-server nil)
(defun eab-spacemacs/init-take-off nil)
(defun eab-spacemacs/init-wide-n nil)
(defun eab-spacemacs/init-god-mode nil)
(defun eab-spacemacs/init-fancy-narrow nil)
(defun eab-spacemacs/init-goto-chg nil)
(defun eab-spacemacs/init-epc nil)
(defun eab-spacemacs/init-ctable nil)
(defun eab-spacemacs/init-concurrent nil)
(defun eab-spacemacs/init-python-environment nil)
(defun eab-spacemacs/init-jedi nil)
(defun eab-spacemacs/init-bibretrieve nil)
(defun eab-spacemacs/init-websocket nil )

(defun eab-spacemacs/init-pkg-info nil)
(defun eab-spacemacs/init-epl nil)
(defun eab-spacemacs/init-python-info nil)
(defun eab-spacemacs/init-achievements nil )
(defun eab-spacemacs/init-org-grep nil)
(defun eab-spacemacs/init-ov nil)
(defun eab-spacemacs/init-peg nil)
(defun eab-spacemacs/init-org-super-agenda nil)
(defun eab-spacemacs/init-org-special-block-extras nil)
(defun eab-spacemacs/init-org-sql nil)
(defun eab-spacemacs/init-org-transclusion nil)
(defun eab-spacemacs/init-org-ql nil)
(defun eab-spacemacs/init-aaorg nil)
(defun eab-spacemacs/init-org-mode-fix/lisp nil)
(defun eab-spacemacs/init-f nil)
(defun eab-spacemacs/init-keyfreq nil )
(defun eab-spacemacs/init-cask nil)
(defun eab-spacemacs/init-pallet nil)
(defun eab-spacemacs/init-ob-tmux nil)
(defun eab-spacemacs/init-purty-mode nil)
(defun eab-spacemacs/init-flx nil)
(defun eab-spacemacs/init-guide-key nil)
(defun eab-spacemacs/init-xml-rpc nil)
(defun eab-spacemacs/init-web nil)
(defun eab-spacemacs/init-string-edit-at-point nil)
(defun eab-spacemacs/init-redo+ nil)
(defun eab-spacemacs/init-pcache nil)
(defun eab-spacemacs/init-org-ehtml nil)
(defun eab-spacemacs/init-noflet nil)
(defun eab-spacemacs/init-minimap nil)
(defun eab-spacemacs/init-markdown-mode nil )
(defun eab-spacemacs/init-auto-complete nil)
(defun eab-spacemacs/init-yasnippet nil)
(defun eab-spacemacs/init-kv nil)
(defun eab-spacemacs/init-ignoramus nil)
(defun eab-spacemacs/init-ibuffer-vc nil)
(defun eab-spacemacs/init-highlight nil)
(defun eab-spacemacs/init-highlight-indentation nil)
(defun eab-spacemacs/init-prettier nil)
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
(defun eab-spacemacs/init-org-link-minor-mode nil)
(defun eab-spacemacs/init-eev-current nil)
(defun eab-spacemacs/init-bbdb/lisp nil)
(defun eab-spacemacs/init-eab-misc nil)

(defun eab-spacemacs/init-gnus nil )

(defun eab-spacemacs/init-tramp nil)

(defun eab-spacemacs/init-outline nil)
(defun eab-spacemacs/init-window nil)
(defun eab-spacemacs/init-appt nil)
(defun eab-spacemacs/init-desktop nil)
(defun eab-spacemacs/init-server nil)
(defun eab-spacemacs/init-compile nil)
(defun eab-spacemacs/init-eab-gr nil)
(defun eab-spacemacs/init-grep nil)
(defun eab-spacemacs/init-dired nil)

(defun eab-spacemacs/init-ido nil)
(defun eab-spacemacs/init-abbrev nil)
(defun eab-spacemacs/init-bookmark nil)

(defun eab-spacemacs/init-ibuffer ())
(defun eab-spacemacs/init-eab-ace-jump-mode ())
(defun eab-spacemacs/init-eab-avy ())

(defun eab-spacemacs/init-eab-minimal ())
(defun eab-spacemacs/init-eab-workflow ())
(defun eab-spacemacs/init-eab-ui ())
(defun eab-spacemacs/init-eab-org ())
(defun eab-spacemacs/user-config ())
