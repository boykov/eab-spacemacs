;;; packages.el --- eab Layer packages File for Spacemacs -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

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
    highlight ;; dired+
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
(defun eab-spacemacs/init-ai-code nil
  ;; TODO: remote claude, which path
  (use-package ai-code
    :config
    (setq ai-code-mcp-agent-enabled-backends
          (remove 'claude-code ai-code-mcp-agent-enabled-backends))
    (setq ai-code-claude-code-program "bash")
    (setq ai-code-claude-code-program-switches '("/home/eab/git/eab-system/eab-spacemacs/claude.sh"))
    (setq ai-code-pi-program "bash")
    (setq ai-code-pi-program-switches '("/home/eab/git/eab-system/eab-spacemacs/pi.sh"))
    ;; (setq ai-code--session-project-root-override "/ssh:chronos:/home/eab/claude/")
    (setq ai-code-backends-infra-terminal-backend 'ghostel)
    (ai-code-set-backend 'claude-code)
    ;; russian lang
    (setq ai-code-backends-infra-ghostel-enable-ime-integration nil)
    (ai-code-set-backend 'pi)
    ))
(defun eab-spacemacs/init-gptel-agent nil
  (use-package gptel-agent
    :after (gptel)
    :config
    (add-to-list 'gptel-agent-dirs (eab/config (concat eab-spacemacs-path "agents")))
    (gptel-agent-update)))
(defun eab-spacemacs/init-llm ()
  (use-package llm)
  (use-package llm-openai))
(defun eab-spacemacs/init-prodigy nil
  (use-package prodigy))
(defun eab-spacemacs/init-solarized-theme nil)
(defun eab-spacemacs/init-s ()
  (use-package s))
(defun eab-spacemacs/init-groovy-mode ()
  (use-package groovy-mode)
  (eab/add-hook groovy-mode-hook eab/groovy-hook
    (general-define-key
     :keymaps 'groovy-mode-map
     "C-i"        'eab/outline-toggle-children
     "<backtab>"  'eab/outline-toggle-all))
  (add-hook 'groovy-mode-hook (lambda () (setq indent-tabs-mode nil))))
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
(defun eab-spacemacs/init-tramp-term ()
    (use-package tramp-term))
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
(defun eab-spacemacs/init-gptel-magit nil
  (load "eab-config-gptel-magit.el"))
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
(defun eab-spacemacs/init-ibuffer ()
  (use-package ibuffer
    :config
    (setq ibuffer-formats
          '((mark modified read-only " "
                  (name 18 18 :left :elide))
            (mark modified read-only " " (name 18 18 :left :elide) " "
                  (size 9 -1 :right) " " (mode 16 16 :left :elide) " "
                  filename-and-process)))
    (general-define-key
     :keymaps 'ibuffer-mode-map
     "C-d"        'nil
     "C-k"        'nil
     "C-o"        'nil
     "C-y"        'nil
     "M-g"        'nil
     "M-j"        'nil
     "M-n"        'nil
     "M-o"        'nil
     "M-p"        'nil
     "M-s"        'nil)))
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
  (use-package ediff
    :config
    (eab/add-hook ediff-after-setup-control-frame-hook eab/ediff-hook
      (general-define-key
       :keymaps 'ediff-mode-map
       "d"  'nil))
    (defun eab/ediff-dired-directories ()
      (interactive)
      (when (= (length (window-list)) 2)
        (let ((dirs (mapcar
                     (lambda (w) 
                       (buffer-local-value 'default-directory (window-buffer w)))
                     (window-list))))
          (ediff-directories (car dirs) (cadr dirs) nil))))))
(defun eab-spacemacs/init-ediff-wind ()
  (use-package ediff-wind
    :after (ediff)
    :config
    (setq ediff-window-setup-function 'ediff-setup-windows-plain)
    (setq ediff-split-window-function 'split-window-horizontally)))
(defun eab-spacemacs/init-ediff-diff ()
  (use-package ediff-diff
    :after (ediff)
    :config
    (setq ediff-diff-options "-w")))
(defun eab-spacemacs/init-ispell ()
  (use-package ispell
    :config
    (setq ispell-dictionary "english")))
(defun eab-spacemacs/init-flyspell ()
  (use-package flyspell
    :after (ispell)
    :config
    (eab/add-hook flyspell-mode-hook eab/flyspell-hook
      (general-define-key
       :keymaps 'flyspell-mode-map
       "C-k"        'toggle-input-method))
    (autoload 'tex-mode-flyspell-verify "flyspell" "" t)
    (setq flyspell-default-dictionary "english")
    (defun eab/flyspell-buffer (arg)
      (interactive "P")
      (let ((ispell-local-dictionary (if arg "en" "ru")))
        (flyspell-buffer)))
    (autoload 'flyspell-auto-correct-previous-word "flyspell" "Auto correct the first mispelled" t)
    (autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
    (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)))
(defun eab-spacemacs/init-auto-dictionary ()
  (use-package auto-dictionary
    :config
    ;; (add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))
    ;; (flyspell-delete-all-overlays)
    (add-to-list 'adict-language-list "ru" 't)
    (add-to-list 'adict-dictionary-list
                 `("ru" . ,(adict-guess-dictionary-name '("ru"))) 't)
    (let ((hash adict-hash))
      (adict-add-word hash 19 "и" "в" "не" "на" "что" "с" "то" "я" "он" "как" "а"
                      "по" "к" "его" "все" "из" "за" "это" "у" "же" "от" "но" "было" "так"
                      "бы" "о" "еще" "меня" "был" "только" "она" "уже" "ее" "мне" "сказал" "ты"
                      "для" "мы" "они" "до" "их" "когда" "или" "ему" "ни" "вы" "даже" "под"
                      "него" "если" "чтобы" "вот" "чем" "где" "себя" "была" "нас" "время"
                      "ли" "быть" "раз" "может" "есть" "со" "были" "там" "нет" "очень"
                      "кто" "без" "тут" "во" "будет" "тоже" "этого" "надо" "себе"
                      "да" "ничего" "при" "тебя" "них" "этом" "того" "можно" "этот"
                      "потом" "человек" "вас" "сейчас" "один" "здесь" "теперь" "тебе"
                      "через" "больше" "всех" "лет" "том" "после" "сам" "нибудь" "ним"
                      "просто" "вдруг" "над" "потому" "ведь" "вам" "дело" "тогда"
                      "спросил" "жизни" "два" "чего" "который" "тем" "нам" "перед"
                      "глаза" "всего" "уж" "им" "своей" "несколько" "день" "всегда"
                      "какой" "ей" "более" "такой" "тот" "этой" "нее" "которые"
                      "ней" "эти" "стал" "жизнь" "сразу" "мог" "совсем" "свою" "об"
                      "почему" "пока" "конечно" "люди" "года" "человека" "куда" "почти"
                      "руки" "людей" "хотя" "три" "снова" "хорошо" "знаю" "много" "сказать"
                      "будто" "лишь" "голову" "про" "сказала" "всем" "между" "говорит"
                      "никогда" "опять" "свои" "другой" "мой" "своих" "эту" "такое" "знал"
                      "своего" "таки" "собой" "дома" "времени" "чуть" "свой" "лучше" "именно"
                      "друг" "лицо" "руку" "вообще" "свое" "которой" "никто" "кого"
                      "этих" "говорил" "вместе" "назад"))))

(defun eab-spacemacs/init-recentf nil
  (load "eab-config-recentf.el"))
(defun eab-spacemacs/init-ansi-color nil
  (use-package ansi-color
    ;; see eab-compile.el
    :config
    (defun colorize-compilation-buffer ()
      (read-only-mode 'toggle)
      (ansi-color-apply-on-region (point-min) (point-max))
      (read-only-mode 'toggle))

    ;; TODO: why concrete buffer-name only?
    (define-advice display-message-or-buffer (:before (&rest args) ansi-color)
      "Process ANSI color codes in shell output."
      (let ((buf (car args)))
        (and (bufferp buf)
             (string= (buffer-name buf) "*Shell Command Output*")
             (with-current-buffer buf
               (ansi-color-apply-on-region (point-min) (point-max))))))))
(defun eab-spacemacs/init-helm nil
  (use-package eab-helm
    :after (eab-org ergoemacs-functions)
    :init
    (defvar browse-url-galeon-program nil)
    (defun browse-url-galeon nil)
    (defvar browse-url-netscape-program nil)
    (defun browse-url-netscape nil)
    :config
    (eab/add-hook helm-before-initialize-hook eab/helm-hook
      (general-define-key
       :keymaps 'helm-map
       "C-k"        'toggle-input-method
       "M-H"        'helm-select-2nd-action-or-end-of-line
       "M-g"        'helm-delete-minibuffer-contents
       "C-|"        'eab/helm-select-action
       "<C-return>" (ilam
                     (with-helm-alive-p
                       (helm-exit-and-execute-action 'eab/helm-note-todo)))
       "M-4"        (ilam
                     (with-helm-alive-p
                       (helm-exit-and-execute-action 'eab/helm-note-todo)))
       "M-RET"      (ilam
                     (with-helm-alive-p
                       (helm-exit-and-execute-action 'eab/helm-org-goto-marker)))
       "M-j"        'nil
       "M-v"        'nil
       "M-l"        'nil
       "M-m"        'eab/helm-toggle-visible-mark
       "M-2"        'eab/helm-toggle-visible-mark
       "M-3"        (ilam
                     (with-helm-alive-p
                       (helm-exit-and-execute-action 'eab/helm-org-switch-ql)))
       "M-k"        'helm-next-line
       "M-i"        'helm-previous-line
       "C-n"        'next-history-element
       "C-p"        'previous-history-element
       "C-SPC"      'eab/helm-toggle-visible-mark
       "M-K"        'helm-next-page
       "M-J"        'helm-beginning-of-buffer
       "M-L"        'helm-end-of-buffer
       "M-I"        'helm-previous-page)
      (ergoemacs-fix-arrow-keys helm-map)
      (general-define-key
       :keymaps 'helm-generic-files-map
       "M-i"        'helm-previous-line))
    (setq helm-c-adaptative-history-file (eab/config (concat (eab/history-dir) "helm-adaptive-history")))
    (setq helm-locate-command (eab/config (concat eab/ssh-host-local " plocate %s -e %s")))
    (defun eab/helm-find-file-or-marked (candidate)
      (helm-find-file-or-marked (concat "/ssh:chronos:" candidate)))
    (let ((addr (cdr (rassoc 'helm-find-file-or-marked helm-type-file-actions))))
      (if addr
          (setf addr 'eab/helm-find-file-or-marked)))))
(defun eab-spacemacs/init-helm-descbinds nil)
(defun eab-spacemacs/init-helm-helm-commands nil)
(defun eab-spacemacs/init-helm-org nil
  (use-package helm-org
    :after (eab-helm eab-org)
    :config
    ;; see also minibuffer-local-map
    (add-to-list 'helm-org-headings-actions '("eab/helm-org-goto-marker" . eab/helm-org-goto-marker))
    (add-to-list 'helm-org-headings-actions '("eab/helm-note-todo" . eab/helm-note-todo))
    (add-to-list 'helm-org-headings-actions '("eab/helm-org-switch-ql" . eab/helm-org-switch-ql))
    (add-to-list 'helm-org-headings-actions '("eab/helm-org-store-link" . eab/helm-org-store-link))
    (add-to-list 'helm-org-headings-actions '("eab/helm-hron-todo" . eab/helm-hron-todo))))
(defun eab-spacemacs/init-helm-org-rifle nil
  (use-package helm-org-rifle
    :after (general ergoemacs-functions helm org eab-minimal)
    :config
    (general-define-key
     :keymaps 'helm-org-rifle-map
     "<C-return>" (ilam
                   (with-helm-alive-p
                     (helm-exit-and-execute-action 'eab/rifle-note-todo)))
     "RET"        (ilam
                   (with-helm-alive-p
                     (helm-exit-and-execute-action 'eab/rifle-hron-todo)))
     "M-RET"      (ilam
                   (with-helm-alive-p
                     (helm-exit-and-execute-action
                      'helm-org-rifle-show-entry-in-real-buffer)))
     "M-c"        (ilam
                   (with-helm-alive-p
                     (helm-exit-and-execute-action
                      'eab/helm-rifle-store-link)))
     "M-n"        'helm-next-source
     "M-p"        'helm-previous-source
     "C-k"        'toggle-input-method
     "M-k"        'helm-next-line
     "C-n"        'next-history-element
     "M-K"        'helm-next-page
     "M-J"        'helm-beginning-of-buffer
     "C-p"        'previous-history-element
     "M-i"        'helm-previous-line
     )
    (ergoemacs-fix-arrow-keys helm-org-rifle-map)
    (setq helm-org-rifle-ellipsis-string "\n")
    (setq helm-org-rifle-context-characters 200)
    (setq helm-org-rifle-input-idle-delay 0.5)
    (if (eab/ondaemon (eab/server-P))
        (setq helm-org-rifle-input-idle-delay 1))
    (add-to-list 'helm-org-rifle-actions '("eab/hron-todo" . eab/rifle-hron-todo))
    (add-to-list 'helm-org-rifle-actions '("eab/note-todo" . eab/rifle-note-todo))))
(defun eab-spacemacs/init-smart-compile nil
  (use-package smart-compile
    :config
    (setq-default smart-compile-check-makefile nil)
    (setq-default smart-compile-check-build-system nil)
    (add-to-list 'smart-compile-alist '(graphviz-dot-mode . "xdot.py %F"))
    (add-to-list 'smart-compile-alist '(python-mode . "python %F"))
    (add-to-list 'smart-compile-alist '(textile-mode . "make push id=%f"))
    (add-to-list 'smart-compile-alist '("\\.xml\\'" . "cd `git rev-parse --show-toplevel` && make push id=%F"))
    (add-to-list 'smart-compile-alist '("\\.jira\\'" . "make push id=%n"))
    (add-to-list 'smart-compile-alist '("\\.html\\'" . "make push id=%n"))))
(defun eab-spacemacs/init-popwin nil
  (load "eab-config-popwin.el"))
(defun eab-spacemacs/init-expand-region nil
  (use-package expand-region
    :config
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
    (add-hook 'text-mode-hook 'er/add-text-mode-expansions)))
(defun eab-spacemacs/init-multiple-cursors nil
  (use-package multiple-cursors ;; fix mc/keymap
    :config
    (add-hook 'multiple-cursors-mode-enabled-hook 
              (lambda ()
                (general-define-key
                 :keymaps 'mc/keymap
                 "M-K"        'mc/cycle-forward
                 "M-I"        'mc/cycle-backward
                 "M-v"        'nil
                 "C-v"        'nil)))
    (setq mc/list-file (eab/config (concat (eab/history-dir) ".mc-lists.el")))
    (if (boundp 'mc--default-cmds-to-run-for-all)
        (setq mc--cmds mc--default-cmds-to-run-for-all))
    ;; TODO: mc/cmds-to-run-for-all переназначается (sp-backward-sexp sp-forward-sexp)
    (setq mc/cmds-to-run-for-all (append mc/cmds-to-run-for-all
                                         '(org-delete-char
                                           org-self-insert-command)))))
(defun eab-spacemacs/init-flx-isearch ()
  ;; TODO: поробовать разрешить в agenda?
  (flx-isearch-mode 0)
  (setq isearch-search-fun-function 'isearch-search-fun-default))

(defun eab-spacemacs/init-workgroups2/src ()
  (load "eab-config-workgroups2.el"))

(defun eab-spacemacs/init-dictionary nil
  (use-package dictionary
    :config
    (setq dictionary-server "localhost")
    (define-advice dictionary-search (:after (&rest args) eab-dictionary-abbrev)
      "Put searched word for dictionary to eab-abbrev-table"
      (let ((word (car args)))
        (unless (string-equal word "")
          (define-abbrev eab-abbrev-table word word))))
    (general-define-key
     :keymaps 'dictionary-mode-map
     "t"  'dictionary-search
     "B"  'dictionary-previous)))

(defun eab-spacemacs/init-magit nil
  (load "eab-config-magit.el"))
(defun eab-spacemacs/init-sqlite3 nil)
(defun eab-spacemacs/init-forge nil
  (use-package forge
    :config
    (add-to-list 'forge-alist '("gitlab-local.boos.solutions" "gitlab-local.boos.solutions/api/v4"
                                "gitlab-local.boos.solutions" forge-gitlab-repository))
    (setq bug-reference-auto-setup-functions nil)))
(defun eab-spacemacs/init-orgit nil
  ;; TODO: cancel rev-export disabling
  (use-package orgit
    :after (magit)
    :config
    (defun orgit-rev-export (path desc format))))

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
(defun eab-spacemacs/init-org-agenda-property nil
  (use-package org-agenda-property
    :after (org-agenda)
    :config
    (setq org-agenda-property-list '("Custom_BIB"))))
(defun eab-spacemacs/init-region-bindings-mode nil
  (load "eab-config-region-bindings-mode.el"))
(defun eab-spacemacs/init-smex nil
  (use-package smex)
  (use-package eab-smex
    :after (helm smex eab-minimal)
    :config
    (setq smex-save-file (eab/config (concat (eab/history-dir) ".smex-items")))))
(defun eab-spacemacs/init-smartparens nil
  (use-package smartparens
    :config
    (add-hook 'smartparens-enabled-hook
              (lambda ()
                (general-define-key
                 :keymaps 'sp-keymap
                 "/"  'nil
                 "b"  'sp--self-insert-command ;; for latex sp-local-tag
                 "B"  'nil
                 "f"  'nil
                 "g"  'nil
                 "h"  'nil
                 "l"  'nil
                 "t"  'nil
                 "i"  'nil
                 "e"  'nil
                 "r"  'nil
                 "к"  'nil)
                (setq sp-ignore-modes-list nil)))) ;; fix boundp sp-keymap
  (use-package smartparens-latex))
(defun eab-spacemacs/init-auto-install nil
  (use-package auto-install
    :config
    (setq auto-install-directory (eab/config (concat user-emacs-directory "auto-install/")))))
(defun eab-spacemacs/init-flx-ido nil
  (use-package flx-ido))
(defun eab-spacemacs/init-ido-at-point nil
  (use-package ido-at-point))
(defun eab-spacemacs/init-paredit nil
  (use-package paredit
    :config
    (add-hook 'emacs-lisp-mode-hook 
              (lambda ()
                (general-define-key
                 :keymaps 'emacs-lisp-mode-map
                 "M-("        'paredit-wrap-round
                 "M-r"        'paredit-forward-kill-word
                 "M-e"        'paredit-backward-kill-word
                 "M-g"        'paredit-kill
                 "M-'"        'paredit-comment-dwim
                 "RET"        'paredit-newline)))
    (autoload 'enable-paredit-mode
      "paredit" "Turn on pseudo-structural editing of Lisp code." t)))
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
    :config
    (defun eab/edit-list-1 (word)
      (edit-list (intern word)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab-spacemacs/init-docker ()
  (use-package docker)
  (use-package docker-container
    :config
    (defun eab/tramp-docker-cleanup ()
      (interactive)
      (tramp-cleanup-connection
       (tramp-dissect-file-name
        ;; TODO: tramp default-directory path
        (concat "/docker:"
                (car (progn
                       (docker-utils-get-marked-items-ids))) ":"))))
    (general-define-key
     :keymaps 'docker-container-mode-map
     "c"  'eab/tramp-docker-cleanup)))

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
  (use-package tramp
    :config
    (setq tramp-default-method "ssh")
    (setq tramp-persistency-file-name (eab/config (concat (eab/history-dir) "tramp"))))
  (use-package eab-tramp
    :config
    (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
    (add-to-list 'tramp-methods eab/sussh)
    (add-to-list 'tramp-methods (eab/singularity "`pwd`/"))))

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
(defun eab-spacemacs/init-server nil
  (use-package eab-server
    :after (org eab-notify)))
(defun eab-spacemacs/init-compile nil
  (load "eab-config-compile.el"))
(defun eab-spacemacs/init-grep nil
  (load "eab-config-grep.el"))
(defun eab-spacemacs/init-dired nil
  (load "eab-config-dired.el"))

(defun eab-spacemacs/init-ido nil
  (eab/add-hook ido-minibuffer-setup-hook eab/ido-minibuffer-hook
    (general-define-key
     :keymaps 'ido-file-dir-completion-map
     "M-v"        'yank)
    (general-define-key
     :keymaps 'ido-file-completion-map
     "C-n"        (eab/do-action
                   (ilam-no-def
                    (execute-kbd-macro
                     (read-kbd-macro
                      "C-x C-f / 2*s h : k a i r o s - h o s t | s u d o : k a i r o s - h o s t : / C-x Q"))))
     "C-d"        'eab/ace-ibuffer
     "C-|"        'eab/ido-see-file
     )
    (general-define-key
     :keymaps 'ido-common-completion-map
     "C-v"        'eab/toggle-cxb-ido-item
     )
    (general-define-key
     :keymaps 'ido-buffer-completion-map
     "C-k"        'nil
     "C-d"        'eab/ace-ibuffer
     "M-RET"      'eab/ido-main
     "C-M-j"      'eab/ido-main
     ))
  (use-package eab-ido
    :after (flx-ido projectile eab-minimal)
    :config
    (setq ido-save-directory-list-file
          (eab/config (concat (eab/history-dir) ".ido.last")))))
(defun eab-spacemacs/init-abbrev nil
  (use-package eab-words
    :after (abbrev simple)
    :config
    (setq abbrev-file-name
          (eab/config (concat (eab/history-dir) ".abbrev_defs")))
    (if (file-exists-p abbrev-file-name)
        (progn
          (setq save-abbrevs 'silently)
          (quietly-read-abbrev-file abbrev-file-name)))))
(defun eab-spacemacs/init-bookmark nil
  (use-package bookmark
    :config
    (setq bookmark-watch-bookmark-file 'silent)
    (bookmark-maybe-load-default-file)
    (setq bookmark-history bookmark-alist)
    (setq bookmark-automatically-show-annotations nil)
    (setq bookmark-fringe-mark nil))
  (use-package eab-bookmark
    :after (bookmark eab-minimal eab-workgroups2)
    :config
    (setq bookmark-default-file (eab/config (concat (eab/history-dir) ".emacs.bmk")))
    (general-define-key
     :keymaps 'bookmark-minibuffer-read-name-map
     "C-l" (ilam
            (let ((string
                   (with-current-buffer
                       bookmark-current-buffer
                     (eab/replace-in-string "{{{kb_hide}}}" "" (thing-at-point 'line)))))
              (insert (substring string 0 -1)))))))

(defun eab-spacemacs/init-eab-ace-jump-mode ()
  (use-package ace-jump-mode
    :init
    (evil-mode -1)
    :config
    (setq ace-jump-mode-gray-background nil) ;; it is faster

    (defun eab/ace-ibuffer ()
      (interactive)
      (setq ido-exit 'eab-ido-exit)
      (exit-minibuffer))

    (defun eab/call-ibuffer ()
      (if (equal (buffer-name (current-buffer)) "*Ibuffer*")
          (ibuffer-visit-buffer)))

    (add-hook 'ace-jump-mode-end-hook 'eab/call-ibuffer)

    (defun eab/isearch-ace-jump ()
      "Invoke `ace-jump' from isearch within `current-buffer'."
      (interactive)
      (let ((case-fold-search isearch-case-fold-search)
            (isearch-buffer (current-buffer))
            (isearch-update-post-hook
             (lambda ()
               (interactive)
               (unless (equal isearch-string "")
                 (isearch-exit)))))
        (isearch-exit)
        ;; TODO: ace -> avy
        (ace-jump-do (concat "\\b" isearch-string))))))

(defun eab-spacemacs/init-eab-avy ()
  (use-package avy
    :config
    (setq avy-timeout-seconds 0.25)))

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
  )
