;;; packages.el --- eab Layer packages File for Spacemacs
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
    (files :location built-in)
    (subr :location built-in)
    (paragraphs :location built-in)
    (ibuffer :location built-in)
    (comint :location built-in)
    (epa :location built-in)
    (python :location built-in)
    (eab-ui :location built-in)
    (eab-org :location built-in)
    (eab-org-agenda :location built-in)
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar eab-spacemacs-excluded-packages '()
  "List of packages to exclude.")

(defun eab-spacemacs/init-ox-pandoc nil)
(defun eab-spacemacs/init-elisa nil)
(defun eab-spacemacs/init-ai-code nil
  ;; TODO: remote claude, which path
  (use-package ai-code
    :config
    (setq ai-code-mcp-agent-enabled-backends
          (remove 'claude-code ai-code-mcp-agent-enabled-backends))
    (setq ai-code-claude-code-program "ccr") ;; "/home/eab/git/eab-system/eab-spacemacs/claude.sh"
    (setq ai-code-claude-code-program-switches '("claude-code"))
    (setq ai-code--session-project-root-override "/ssh:chronos:/home/eab/claude/")
    (setq ai-code-backends-infra-terminal-backend 'ghostel)
    (ai-code-set-backend 'claude-code))
  ;;   (global-set-key (kbd "C-c a") #'ai-code-menu))
  )
(defun eab-spacemacs/init-gptel-agent nil
  (use-package gptel-agent
    :after (gptel)
    :config
    (add-to-list 'gptel-agent-dirs (eab/config (concat eab-spacemacs-path "agents")))
    (gptel-agent-update))
  (use-package gptel-agent-tools
    :after (gptel gptel-agent)
    :config
    ;; (add-to-list 'gptel-tools (cdr (assoc "WebSearch" (cdar gptel--known-tools))))
    ;; (add-to-list 'gptel-tools (cdr (assoc "WebFetch" (cdar gptel--known-tools))))
    ))
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
  (load "eab-gptel.el"))
(defun eab-spacemacs/init-gptel-magit nil
  (load "eab-gptel-magit.el"))
(defun eab-spacemacs/init-ellama nil
  (load "eab-ellama.el"))
(defun eab-spacemacs/init-daemons nil
  (use-package daemons
    :config
    (setq daemons-init-system-submodules '(daemons-systemd)))
  (use-package daemons-systemd
    :after (daemons)
    :config
    (defun daemons-systemd--cmd ()
      "Appends `--user' to the `systemctl' call if `daemons-systemd-is-user' is set"
      (if daemons-systemd-is-user
          ". /tmp/lib.sh; cache_cmd_filter 30000 systemctl --user"
        ". /tmp/lib.sh; cache_cmd_filter 30000 systemctl"))
    (defun daemons-systemd-toggle-user ()
      "Toggle showing of user services"
      (interactive)
      (setq daemons-systemd-is-user (not daemons-systemd-is-user))
      (if daemons-systemd-is-user
          (setq default-directory
                (concat "/ssh:" eab/daemons-host ":/home/eab/")))
      (if (not daemons-systemd-is-user)
          (setq default-directory
                (concat "/ssh:" eab/daemons-host "|sudo:root@" eab/daemons-host ":/home/eab/")))
      (revert-buffer))
    (defun eab/daemons-restart ()
      (interactive)
      (let ((name (daemons--daemon-at-point)))
        (async-start
          `(lambda ()
            (add-to-list 'load-path "/home/eab/.emacs.d/elpa/daemons-20250514.1107")
            (require 'daemons)
            (setq daemons-init-system-submodules '(daemons-systemd))
            (require 'daemons-systemd)
            (with-output-to-string
              (let ((default-directory ,default-directory)
                    (daemons-systemd-is-user ,daemons-systemd-is-user))
                  (daemons--run 'restart ,name))))
          (lambda (result)))))
    (define-key daemons-mode-map (kbd "R") 'eab/daemons-restart)
    (defun eab/daemons ()
      (interactive)
      (shell-command (concat "scp ~/git/auto/lib.sh " eab/daemons-host ":/tmp/lib.sh"))
      (let* ((default-directory
              (concat "/ssh:" eab/daemons-host "|sudo:root@" eab/daemons-host ":/home/eab/")))
        (progn
          (setq daemons-systemd-is-user nil)
          (daemons))))))
    ;; (let* ((eab/daemons-host "chronos") (default-directory (concat "/ssh:" eab/daemons-host "|sudo:root@" eab/daemons-host ":/home/eab/"))) (progn (setq daemons-systemd-is-user nil) (daemons)))
    ;; (let* ((eab/daemons-host "chronos") (default-directory (concat "/ssh:" eab/daemons-host ":/home/eab/"))) (progn (setq daemons-systemd-is-user 't) (daemons)))
(defun eab-spacemacs/init-ergoemacs-mode ()
  (use-package ergoemacs-functions
    :after (facemenu)
    :config
    (defun ergoemacs-handle-M-O ()
      "Handle meta+O input.
In a terminal, this can be either arrow keys (e.g. meta+O A == <up>) or regular meta+O keybinding."
      (interactive)
      (if (input-pending-p)
          (let ((second-char (read-char)))
            (cond
             ((eq second-char 65) ;; A
              (execute-kbd-macro (kbd "<up>")))
             ((eq second-char 66) ;; B
              (execute-kbd-macro (kbd "<down>")))
             ((eq second-char 67) ;; C
              (execute-kbd-macro (kbd "<right>")))
             ((eq second-char 68) ;; D
              (execute-kbd-macro (kbd "<left>")))
             ((eq second-char 72) ;; H
              (execute-kbd-macro (kbd "<home>")))
             ((eq second-char 70) ;; F
              (execute-kbd-macro (kbd "<end>")))
             (t
              (beep))))
        (call-interactively (key-binding [ergoemacs-meta-O]))))

    (defun ergoemacs-fix-arrow-keys (keymap)
      "Fix arrow keys for KEYMAP."
      (let (ergoemacs-M-O-binding)
        (setq ergoemacs-M-O-binding (lookup-key keymap (kbd "M-O")))
        (define-key keymap (kbd "M-O") 'ergoemacs-handle-M-O)
        (define-key keymap [ergoemacs-meta-O] ergoemacs-M-O-binding)))))

(defun eab-spacemacs/init-projectile nil
  (use-package projectile
    :config
    (setq projectile-require-project-root t)
    (setq projectile-per-project-compilation-buffer t)
    (eab/bind-path projectile-known-projects-file)
    (setq projectile-project-root-files-bottom-up
          '(".git"                      ; Git VCS root dir
            ".projectile"               ; projectile project marker
            ".hg"                       ; Mercurial VCS root dir
            ".fslckout"                 ; Fossil VCS root dir
            ".bzr"                      ; Bazaar VCS root dir
            "_darcs"                    ; Darcs VCS root dir
            ))
    (puthash (eab/config "/home/eab/git/eab-system/portal/")
             (make-ring 256)
             projectile-project-command-history)
    (ring-insert
     (projectile--get-command-history (eab/config "/home/eab/git/eab-system/portal/"))
     (eab/config "make deploy-config li=\"--limit chronos,cyclos\""))))

(defun eab-spacemacs/init-epa ()
  (use-package epa)
  (use-package epa-file
    :after (epa)
    :config
    (epa-file-enable)
    (setq epa-file-select-keys 'silent))
  (use-package epg
    :config
    (setenv "GPG_AGENT_INFO" nil) ; use gpg without gui window
    (setq epg-gpg-program "gpg")
    (setq epa-pinentry-mode 'loopback)))
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
(defun eab-spacemacs/init-files ()
  (eab/bind-path backup-directory-alist)
  (eab/bind-path auto-save-file-name-transforms)
  (setq mode-require-final-newline nil)
  (setq require-final-newline nil)
  (setq make-backup-files nil)
  ;; DONE теперь не работают TeX-master "main" в LaTeX-mode
  ;; уже привык их задавать вручную
  (setq enable-local-variables nil)
  (setq frame-title-format
        `("emacs"
          ,(if (stringp (daemonp)) (daemonp) "")
          "@"
          ,(system-name)
          " "
          ;; ": -<{" (:eval (ignore-errors (eab/wg-current-workgroup))) "}>- "
          (:eval (if (buffer-file-name)
                     (abbreviate-file-name (buffer-file-name))
                   "%b")))))
(defun eab-spacemacs/init-simple ()
  (column-number-mode 1)
  (setq 
   mark-ring-max 64
   global-mark-ring-max 64
   indent-tabs-mode nil
   )
  (eab/bind-path eshell-history-file-name)
  (setq
   history-length 500
   kill-ring-max 500
   max-lisp-eval-depth 10000
   eshell-history-size 1000
   )
  (mapc (lambda (x) (add-to-list 'extended-command-history x))
        '(
          "tramp-cleanup-this-connection"
          "eab/create-workgroups"
          "eab/clear-extended-history"
          "eab/load-personal"
          ))
  (mapc (lambda (x) (add-to-list 'read-expression-history x))
        '(
          "(setq input-method-function 'key-chord-input-method)"
          "(tramp-term--initialize \"jupiter\")"
          ))
  (use-package eab-shell
    :init
    ;; (shell-command "xmodmap -e 'keycode 135 = Hyper_R'")
    ;; (shell-command "xmodmap -e 'keycode 95 = Hyper_R'")
    (eab/bind-path eab/translate-path)
    (eab/bind-path eab/trans-path)))
(defun eab-spacemacs/init-browse-url ()
  (use-package browse-url
    :config
    (setq browse-url-browser-function (quote eab/browse-url))
    (setq browse-url-firefox-program "/usr/local/bin/browser-remote")
    (defun eab/eaf-open-browser (url)
      (call-process-shell-command
       (concat "
ssh chronos docker exec -u 1000:1000 \
  -e HOME=/config \
  -e DBUS_SESSION_BUS_ADDRESS=unix:path=/tmp/dbus.base \
   firefox firefox --profile /config/profile " url)  nil 0)
      (if (get-buffer "Firefox")
          (switch-to-buffer-other-window "Firefox")
        (progn
          (eaf-open-browser "https://eaf-browser.eab.su"))))
    (defun eab/eaf-browser-paste-clip ()
      (interactive)
      (with-temp-file "/tmp/clip.txt"
        (insert (current-kill 0)))
      (call-process-shell-command
       "scp /tmp/clip.txt chronos:/docker/appdata/ff-tmp/clip.txt" nil 0)
      (call-process-shell-command
       (concat "
bash -c \"ssh chronos\" <<EOF
 docker exec firefox sh -c \"cat /tmp/clip.txt | xclip -selection clipboard; \
 sleep 0.1; xdotool key ctrl+v \"
EOF")
       nil 0))
    (defun eab/eaf-browser-ctrl-f ()
      (interactive)
      (call-process-shell-command
       (concat "
ssh chronos docker exec \
   firefox xdotool key ctrl+f")  nil 0))
    (defun eab/eaf-browser-ctrl-t ()
      (interactive)
      (call-process-shell-command
       (concat "
ssh chronos docker exec \
   firefox xdotool key ctrl+t")  nil 0))
    (defun eab/browse-url (url &optional arg)
      (interactive)
      (cond
       ((equal current-prefix-arg 2)
        (eaf-open-browser-other-window url))
       ((equal current-prefix-arg '(4))
        (browse-url-firefox url))
       ((not current-prefix-arg)
        (eab/eaf-open-browser url)
        )))
    (defun eab/browse-url0 (url &optional arg)
      (interactive)
      (if current-prefix-arg
          (browse-url-firefox url)
        (eab/eaf-open-browser url)))
    (defun google (phrase)
      "Search Google for a given phrase.
Prompts the user to enter a search query, defaulting to PHRASE if provided.
Opens the Google search results page for the entered query in the default web browser."
      (eab/browse-url0
       (concat
        "https://www.google.com/search?q="
        (url-hexify-string
         (read-string (if phrase
                          (format "Google (%s): " phrase)
                        "Google: ") nil nil phrase)))))
    (defun google-region ()
      (interactive)
      (let ((str (buffer-substring (region-beginning) (region-end))))
        (call-interactively 'mc/keyboard-quit)
        (google str)))))

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
  (use-package recentf
    :config
    (eab/bind-path recentf-save-file)
    (setq recentf-max-saved-items 200)
    (defun eab/recentf-eabpool ()
      (mapcar
       (lambda (x)
         (replace-regexp-in-string
          (concat "^" (regexp-quote "~/")) ""
          (replace-regexp-in-string
           (concat "^" (regexp-quote "~/pnt/lion/")) "" x)))
       (seq-filter
        (lambda (x)
          (file-exists-p x))
        (seq-filter
         (lambda (x)
           (or
            (let ((s "~/git/"))
              (and (length> x (length s)) (string= (substring x 0 (length s)) s)))
            (let ((s "~/pnt/lion/data/"))
              (and (length> x (length s)) (string= (substring x 0 (length s)) s)))))
         (seq-filter
          (lambda (x)
            (let ((s "~/git/org"))
              (and
               (length> x (length s))
               (not (string= (substring x 0 (length s)) s)))))
          recentf-list)))))
    (add-hook 'after-save-hook
              (lambda ()
                (f-write-text
                 (string-join
                  (eab/recentf-eabpool) "\n")
                 'utf-8
                 (concat recentf-save-file "-eabpool"))))))
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
  (eab/add-hook helm-before-initialize-hook eab/helm-hook
    (general-define-key
     :keymaps 'helm-map
     "C-k"        'toggle-input-method
     "M-H"        'helm-select-2nd-action-or-end-of-line
     "M-g"        'helm-delete-minibuffer-contents
     "s-SPC"      'eab/helm-select-action
     "C-|"        'eab/helm-select-action
     "<C-return>" (ilam
                   (with-helm-alive-p
                     (helm-exit-and-execute-action 'eab/helm-note-todo)))
     "M-RET"      (ilam
                   (with-helm-alive-p
                     (helm-exit-and-execute-action 'eab/helm-org-goto-marker)))
     "M-j"        'nil
     "M-v"        'nil
     "M-l"        'nil
     "M-m"        'eab/helm-toggle-visible-mark
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
  (use-package eab-helm
    :after (eab-org)
    :init
    (defvar browse-url-galeon-program nil)
    (defun browse-url-galeon nil)
    (defvar browse-url-netscape-program nil)
    (defun browse-url-netscape nil)
    :config
    (eab/bind-path helm-c-adaptative-history-file)
    (eab/bind-path helm-locate-command)
    (defun eab/helm-find-file-or-marked (candidate)
      (helm-find-file-or-marked (concat "/ssh:chronos:" candidate)))
    (setf (cdr (rassoc 'helm-find-file-or-marked helm-type-file-actions))
          'eab/helm-find-file-or-marked)))
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
  (use-package popwin
    :config
    (popwin-mode 1)

    (generate-new-buffer "special-buffer")

    (setq eab/special-buffer-displaedp nil)
    (setq eab/special-buffer "special-buffer")

    (setq popwin:special-display-config nil)
    (add-to-list 'popwin:special-display-config
                 `(,eab/special-buffer :width 20 :position left :stick t))

    ;; TODO: see also window-toggle-side-windows C-x w s
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

    (global-set-key (kbd "<f3>") 'eab/special-buffer-toggle)))
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
    (eab/bind-path mc/list-file)
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
  (use-package eab-workgroups2
    :config
    (setq wg-use-default-session-file 't)
    (setq wg-control-frames 'nil)
    (setq wg-session-load-on-start nil)
    (ignore-errors (workgroups-mode 1))
    (setq wg-mode-line-decor-divider "")
    (eab/bind-path eab/wg-path)
    (setq eab/wg-update-list
          (mapcar 'eab/wg-update-list-1 (file-expand-wildcards eab/wg-path)))
    (eab/bind-path eab/workgroups-save)
    (eab/wg-init)))

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
  (use-package magit
    :defer
    :config
    (eab/add-hook magit-mode-hook eab/magit-hook
      (general-define-key
       :keymaps 'magit-log-mode-map
       "C-l M-n"    'log-edit-next-comment
       "C-l M-p"    'log-edit-previous-comment
       "M-n"        'nil
       "M-p"        'nil
       "C-d"        'nil)
      (general-define-key
       :keymaps 'magit-revision-mode-map
       "C-j"        'magit-diff-visit-file
       "RET"        'magit-diff-visit-worktree-file
       "C-d"        'nil)
      (general-define-key
       :keymaps 'magit-status-mode-map
       "C-d"        'nil)
      ;;  "C-f"     'magit-show-only-files
      ;;  "C-F"     'magit-show-only-files-all
      (general-define-key
       :keymaps 'magit-mode-map
       "J"          'magit-commit-amend
       "R"          (kbd "r - A e o r i g i n / m a s t e r RET")
       "N"          (kbd "P o m a s t e r 2*RET")
       "{"          (ilam (execute-kbd-macro (read-kbd-macro "C-u S ESC A g i t SPC c o 2*m i t SPC - m SPC u p d a t e RET g")))
       "M-n"        'nil
       "M-p"        'nil
       "M-s"        'nil
       "M-S"        'nil
       "M-h"        'nil
       "M-H"        'nil
       "M-1"        'nil
       "M-2"        'nil
       "M-g"        'magit-fetch-all
       "C-d"        'nil
       "C-D"        'magit-section-show-level-4-all
       "s-1"        'magit-section-show-level-1-all
       "s-2"        'magit-section-show-level-2-all
       "<backtab>"  'magit-section-show-level-2-all
       "s-3"        'magit-section-show-level-3-all
       "s-4"        'magit-section-show-level-4-all)
      (general-define-key
       :keymaps 'git-commit-mode-map
       "C-v c"      'gptel-magit-generate-message
       "M-n"        'nil
       "M-p"        'nil))
    (transient-append-suffix 'magit-diff "-A"
      '("-a" "Treat all files as text." "--text"))
    (transient-append-suffix 'magit-diff "-a"
      '("-S" "Submodule diff" "--submodule=diff"))
    (setq magit-section-visibility-indicator nil)
    (defun eab/magit-amend-modified ()
      (interactive)
      (magit-stage-modified)
      (call-interactively 'magit-commit-amend)))
  (eab/add-hook magit-file-mode-hook eab/magit-file-mode-hook
    (general-define-key
     :keymaps 'magit-file-mode-map
     "C-x g"      'nil
     ))
  (use-package magit-status
    :after (magit)
    :config
    (add-to-list 'magit-status-sections-hook 'magit-insert-modules 't))
  (define-advice vc-annotate (:before (&rest args) eab-vc-annotate)
    (vc-refresh-state))
  (eab/bind-path transient-history-file)
  (use-package git-wip))
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
  (eab/bind-path ansible-vault-pass-file)
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
  (use-package eaf
    :if (eab/ondaemon "cyclos")
    :config
    (setq eaf-webengine-pc-user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36")
    ;; (setq eaf-proxy-host "192.168.2.19")
    ;; (setq eaf-proxy-port "9152")
    ;; (setq eaf-proxy-type "http")
    ;; (eaf-restart-process)
    (advice-remove #'org-open-file #'eaf--find-file-advisor)
    (defun eab/org-eaf-open (path link)
      (eaf-open path))
    (defun eaf--dired-find-file-advisor (orig-fn)
      "Advisor of `dired-find-file' and `dired-find-alternate-file' that opens EAF supported file using EAF.

It currently identifies PDF, videos, images, and mindmap file extensions."
      (dolist (file (dired-get-marked-files))
        (let* ((local-file
                (if (and (file-remote-p file) (string-match-p "\\.[pP][dD][fF]\\'" file))
                    (let* ((tmp-file
                            (tramp-handle-file-local-copy file)))
                      tmp-file)
                  file)))
          (eaf--find-file orig-fn local-file t))))
    (defun eab/eaf-open-viewer-other-window (url &optional args)
      "Open EAF browser application given a URL and ARGS in other window."
      (interactive "M[EAF/browser] URL: ")
      (when (< (length (window-list)) 2)
        (split-window-right))
      (other-window 1)
      (eaf-open url "pdf-viewer" args))
    (defmacro eab/eaf-bind-key (pair kb)
      (let ((f (intern (cdr pair)))
            (k (car pair)))
        `(eaf-bind-key ,f ,k ,kb)))
    (general-define-key
     :keymaps 'eaf-mode-map*
     "C-o"   'nil
     "C-c b" 'nil
     ))
    ;; doesn't work in eaf + remote vnc
    ;; (eaf-create-send-sequence-function "ctrl-t" "C-t") ;; needs eaf--buffer-id ?
    ;; (eaf-create-send-sequence-function "ctrl-v" "C-v") ;; needs eaf--buffer-id ?
  (use-package eaf-browser
    :if (eab/ondaemon "cyclos")
    :after (eaf)
    :init
    (add-to-list 'load-path (concat eab-spacemacs-path "local/eaf/app/browser"))
    :config
    (setq eaf-browser-auto-import-chrome-cookies 't)
    (setq eaf-browser-chrome-browser-name "chrome")
    (setq eaf-browser-dark-mode-theme "light")
    (setq eaf-browser-dark-mode nil)
    ;; (eaf-create-send-sequence-function "ctrl-f" "C-f") ;; needs eaf--buffer-id ?
    (setq eaf-browser-keybinding nil)
    (let ((kb 'eaf-browser-keybinding))
      (mapc (lambda (x)
              (eval `(eab/eaf-bind-key ,x ,kb)))
            '(
              ("C-t" . "eab/eaf-browser-ctrl-t")
              ("C-f" . "eab/eaf-browser-ctrl-f")
              ("C-v" . "eab/eaf-browser-paste-clip")
              ("C-<escape>" . "eaf-browser-send-esc-or-exit-fullscreen")
              ("<escape>" . "eaf-browser-send-esc-or-exit-fullscreen")
              ;; ("C-t" . "eaf-send-ctrl-t-sequence")
              ;; ("C-v" . "eaf-send-ctrl-v-sequence")
              ("M-b" . "browser-a-lot-goto-prev")
              ;; ("0" . "insert_or_zoom_reset")
              ;; ("=" . "insert_or_zoom_in")
              ;; ("-" . "insert_or_zoom_out")
              ("C-<home>" . "scroll_to_begin")
              ("M-J" . "scroll_to_begin")
              ("C-<end>" . "scroll_to_bottom")
              ("M-L" . "scroll_to_bottom")
              ("M-l" . "toggle_dark_mode_light_theme")
              ("M-D" . "open_link")
              ("M-d" . "toggle_dark_mode")
              ("M-F" . "insert_or_history_forward")
              ("M-B" . "insert_or_history_backward")
              ("M-;" . "search_text_forward")
              ("M-:" . "search_text_backward")
              ("M-i" . "scroll_down")
              ("M-k" . "scroll_up")
              ("M-I" . "scroll_down_page")
              ("M-K" . "scroll_up_page")
              ("<next>" . "scroll_up_page")
              ("<prior>" . "scroll_down_page")
              ("M-c" . "copy_text")
              ("M-v" . "yank_text")
              ("C-w" . "insert_or_export_text")
              ("C-q" . "insert_or_close_buffer")
              ("C-e e" . "insert_or_edit_url")
              ))))
  (use-package eaf-pdf-viewer
    :if (eab/ondaemon "cyclos")
    :after (eaf)
    :init
    (add-to-list 'load-path (concat eab-spacemacs-path "local/eaf/app/pdf-viewer"))
    :config
    (setq eaf-pdf-viewer-keybinding nil)
    (let ((kb 'eaf-pdf-viewer-keybinding))
      (mapc (lambda (x)
              (eval `(eab/eaf-bind-key ,x ,kb)))
            '(
              ("0" . "zoom_reset")
              ("=" . "zoom_in")
              ("-" . "zoom_out")
              ("B" . "viewer-a-lot-goto-prev")
              ("q" . "close_buffer")
              ("p" . "jump_to_page")
              ("o" . "eaf-pdf-outline")
              ("M-i" . "scroll_down")
              ("M-k" . "scroll_up")
              ("M-I" . "scroll_down_page")
              ("M-K" . "scroll_up_page")
              ("<next>" . "scroll_up_page")
              ("<prior>" . "scroll_down_page")
              ("M-c" . "copy_select")
              ("M-;" . "search_text_forward")
              ("M-:" . "search_text_backward")
              ("C-w" . "eaf-pdf-extract-page-text")
              ("C-<home>" . "scroll_to_begin")
              ("M-J" . "scroll_to_begin")
              ("C-<end>" . "scroll_to_end")
              ("M-L" . "scroll_to_end")
              )))))
(defun eab-spacemacs/init-ghostel nil
  (use-package ghostel
    :after (eat key-chord eab-minimal)
    :config
    (setq ghostel-mode-map
          (let ((map (make-sparse-keymap)))
            (define-key map [?\C-c ?\M-d] #'ghostel-char-mode)
            (define-key map [?\C-c ?\C-j] #'ghostel-semi-char-mode)
            (define-key map [?\M-v] #'ghostel-yank)
            ;; (key-chord-define map "jj" #'ghostel-semi-char-mode)
            (define-key map [?\C-c ?\C-e] #'ghostel-emacs-mode)
            map))

    (key-chord-define ghostel-readonly-fast-exit-mode-map "jj" #'ghostel-readonly-exit)
    (key-chord-define ghostel-readonly-mode-map "jj" #'ghostel-readonly-exit)

    (setq ghostel-semi-char-mode-map
          (let ((map (eat-term-make-keymap
                      #'ghostel--send-event
                      '(:ascii :arrow :navigation)
                      '( [?\C-\\] [?\C-q] [?\C-c] [?\C-x] [?\C-g] [?\C-h]
                         [?\e ?\C-c] [?\C-u] [?\C-q] [?\e ?x] [?\e ?:]
                         [?\C-a] [?\C-l] [?\e ?a] [?\e ?s] [?\C-b] [?\e ?1]
                         [?\e ?c] [?\e ?v] [?\e ?g] [?\e ?h] [?\e ?p]
                         [?\C-p] [?\C-n] [?\C-v] [?\C-o] [?\C-e]
                         [?\e ?o] [?\e ?j] [?\e ?l] [?\e ?k] [?\e ?i]
                         [?\e ?!] [?\e ?&] [?\C-y] [?\e ?y]))))
            (define-key map (kbd "<escape>") #'ghostel--send-event)
            (define-key map [?\C-k] #'toggle-input-method)
            (define-key map [?\C-y] #'ghostel-yank)
            (define-key map [?\M-v] #'ghostel-yank)
            (define-key map [?\M-y] #'ghostel-yank)
            (define-key map [?\M-m] (ilam (eab/eepitch-prepare-m-r)))
            (define-key map [?\M-r] (ilam (eab/m-r-ghostel)))
            (define-key map [?\M-j] (ilam (let ((last-command-event 'left)) (ghostel--send-event))))
            (define-key map [?\M-l] (ilam (let ((last-command-event 'right)) (ghostel--send-event))))
            (define-key map [?\M-k] (ilam (let ((last-command-event 'down)) (ghostel--send-event))))
            (define-key map [?\M-i] (ilam (let ((last-command-event 'up)) (ghostel--send-event))))
            (define-key map [?\M-K] (ilam (let ((last-command-event 'next)) (ghostel--send-event))))
            (define-key map [?\M-I] (ilam (let ((last-command-event 'prior)) (ghostel--send-event))))
            (define-key map [?\M-h] (ilam (let ((last-command-event 'home)) (ghostel--send-event))))
            (define-key map [?\M-p] (ilam (let ((last-command-event 'end)) (ghostel--send-event))))
            (define-key map [?\C-p] (ilam (let ((last-command-event 'up)) (ghostel--send-event))))
            (define-key map [?\C-n] (ilam (let ((last-command-event 'down)) (ghostel--send-event))))
            (define-key map [?\C-c ?\C-c] #'ghostel--send-event)
            (define-key map [?\C-c ?\C-e] #'ghostel-emacs-mode)
            (key-chord-define map "jj" #'ghostel-emacs-mode)
            map))

    ;; (use-local-map claude-ghostel-semi-char-mode-map)
    (setq claude-ghostel-semi-char-mode-map
          (let ((map (eat-term-make-keymap
                      #'ghostel--send-event
                      '(:ascii :arrow :navigation)
                      '( [?\C-\\] [?\C-q] [?\C-c] [?\C-g] [?\C-h]
                         [?\e ?\C-c] [?\C-u] [?\C-q] [?\e ?x] [?\e ?:]
                         [?\C-a] [?\C-l] [?\e ?a] [?\e ?s] [?\C-b] [?\e ?1]
                         [?\e ?c] [?\e ?v] [?\e ?g] [?\e ?h] [?\e ?p]
                         [?\C-p] [?\C-n] [?\C-v] [?\C-o] [?\C-e]
                         [?\e ?o] [?\e ?j] [?\e ?l] [?\e ?k] [?\e ?i]
                         [?\e ?!] [?\e ?&] [?\C-y] [?\e ?y]))))
            (define-key map (kbd "<C-return>") #'ghostel--send-event)
            (define-key map (kbd "<escape>") #'ghostel--send-event)
            (define-key map [?\C-k] #'toggle-input-method)
            (define-key map [?\C-y] #'ghostel-yank)
            (define-key map [?\M-v] #'ghostel-yank)
            (define-key map [?\M-y] #'ghostel-yank)
            (define-key map [?\M-m] (ilam (eab/eepitch-prepare-m-r)))
            (define-key map [?\M-r] (ilam (eab/m-r-ghostel)))
            (define-key map [?\M-j] (ilam (let ((last-command-event 'left)) (ghostel--send-event))))
            (define-key map [?\M-l] (ilam (let ((last-command-event 'right)) (ghostel--send-event))))
            (define-key map [?\M-k] (ilam (let ((last-command-event 'down)) (ghostel--send-event))))
            (define-key map [?\M-i] (ilam (let ((last-command-event 'up)) (ghostel--send-event))))
            (define-key map [?\M-K] (ilam (let ((last-command-event 'next)) (ghostel--send-event))))
            (define-key map [?\M-I] (ilam (let ((last-command-event 'prior)) (ghostel--send-event))))
            (define-key map [?\M-h] (ilam (let ((last-command-event 'home)) (ghostel--send-event))))
            (define-key map [?\M-p] (ilam (let ((last-command-event 'end)) (ghostel--send-event))))
            (define-key map [?\C-p] (ilam (let ((last-command-event 'up)) (ghostel--send-event))))
            (define-key map [?\C-n] (ilam (let ((last-command-event 'down)) (ghostel--send-event))))
            (define-key map [?\C-c ?\C-c] #'ghostel--send-event)
            (define-key map [?\C-c ?\C-e] #'ghostel-emacs-mode)
            (key-chord-define map "jj" #'ghostel-emacs-mode)
            map))
    
    (setq ghostel-char-mode-map
          (let ((map (eat-term-make-keymap
                      #'ghostel--send-event
                      '(:ascii :arrow :navigation :function)
                      '([?\e ?\C-m] [?\e ?s]))))
            (define-key map [?\C-\M-m] #'ghostel-semi-char-mode)
            map))

    ;; C-] doesn't work inside container
    (defun eab/m-r-ghostel ()
      (interactive)
      (execute-kbd-macro (read-kbd-macro "C-]"))
      (sleep-for 0.2)
      (ghostel-emacs-mode)
      (move-beginning-of-line 1)
      (call-interactively 'set-mark-command)
      (re-search-backward "^> EOF")
      (next-line)
      (call-interactively 'kill-ring-save)
      (ergoemacs-move-cursor-previous-pane -1)
      (yank)
      (ergoemacs-move-cursor-previous-pane -1)
      (ghostel-semi-char-mode)
      (sleep-for 0.2)
      (let ((last-command-event 'right))
        (ghostel--send-event)))

    (add-hook 'ghostel-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))

    ))

(defun eab-spacemacs/init-emacs-eat nil
  (use-package eat
    :after (key-chord eab-minimal)
    :config
    (setq eat-mode-map
          (let ((map (make-sparse-keymap)))
            (define-key map [?\C-c ?\M-d] #'eat-char-mode)
            (define-key map [?\C-c ?\C-j] #'eat-semi-char-mode)
            (define-key map [?\C-c ?\C-k] #'eat-kill-process)
            (define-key map [?\C-c ?\C-p] #'eat-previous-shell-prompt)
            (define-key map [?\C-c ?\C-n] #'eat-next-shell-prompt)
            (key-chord-define map "jj" #'eat-semi-char-mode)
            (define-key map [?\C-c ?\C-e] #'eat-semi-char-mode)
            map))

    (setq eat-semi-char-mode-map
          (let ((map (eat-term-make-keymap
                      #'eat-self-input
                      '(:ascii :arrow :navigation)
                      '( [?\C-\\] [?\C-q] [?\C-c] [?\C-x] [?\C-g] [?\C-h]
                         [?\e ?\C-c] [?\C-u] [?\C-q] [?\e ?x] [?\e ?:]
                         [?\C-a] [?\C-l] [?\e ?a] [?\e ?s] [?\C-b] [?\e ?1]
                         [?\e ?c] [?\e ?v] [?\e ?g] [?\e ?h] [?\e ?p]
                         [?\C-p] [?\C-n] [?\C-v] [?\C-o] [?\C-e]
                         [?\e ?o] [?\e ?j] [?\e ?l] [?\e ?k] [?\e ?i] [?\e ?\s]
                         [?\e ?!] [?\e ?&] [?\C-y] [?\e ?y]))))
            (define-key map [?\C-q] #'eat-quoted-input)
            (define-key map [?\C-y] #'eat-yank)
            (define-key map [?\M-v] #'eat-yank)
            (define-key map [?\M-y] #'eat-yank-from-kill-ring)
            (define-key map [?\M-m] (ilam (eab/eepitch-prepare-m-r)))
            (define-key map [?\M-r] (ilam (eab/m-r)))
            (define-key map [?\M-j] (ilam (eat-self-input 1 'left)))
            (define-key map [?\M-l] (ilam (eat-self-input 1 'right)))
            (define-key map [?\M-k] (ilam (eat-self-input 1 'down)))
            (define-key map [?\M-i] (ilam (eat-self-input 1 'up)))
            (define-key map [?\M-h] (ilam (eat-self-input 1 'home)))
            (define-key map [?\M-p] (ilam (eat-self-input 1 'end)))
            (define-key map [?\C-p] (ilam (eat-self-input 1 'up)))
            (define-key map [?\C-n] (ilam (eat-self-input 1 'down)))
            (define-key map [?\C-c ?\C-c] #'eat-self-input)
            (define-key map [?\C-c ?\C-e] #'eat-emacs-mode)
            (define-key map [remap insert-char] #'eat-input-char)
            (key-chord-define map "jj" #'eat-emacs-mode)
            map))

    (setq eat-char-mode-map
          (let ((map (eat-term-make-keymap
                      #'eat-self-input
                      '(:ascii :arrow :navigation :function)
                      '([?\e ?\C-m]))))
            (define-key map [?\C-\M-m] #'eat-semi-char-mode)
            map))

    (define-minor-mode eat--semi-char-mode
      "Minor mode for semi-char mode keymap."
      :interactive nil
      :keymap eat-semi-char-mode-map)

    (define-minor-mode eat--char-mode
      "Minor mode for char mode keymap."
      :interactive nil
      :keymap eat-char-mode-map)

    (defun eab/m-r ()
      (interactive)
      (execute-kbd-macro (read-kbd-macro "C-]"))
      (sleep-for 0.2)
      (eat-emacs-mode)
      (move-beginning-of-line 1)
      (call-interactively 'set-mark-command)
      (re-search-backward "^> EOF")
      (next-line)
      (call-interactively 'kill-ring-save)
      (ergoemacs-move-cursor-previous-pane -1)
      (yank)
      (ergoemacs-move-cursor-previous-pane -1)
      (eat-semi-char-mode)
      (sleep-for 0.2)
      (eat-self-input 1 'right))

    (eab/patch-this-code
     'eat
     `((,(let ((print-quoted 't))
           (prin1-to-string
            `(format "%s<%d>" eat-buffer-name arg))) .
            ,(let ((print-quoted 't))
               (prin1-to-string
                `(format "*ansi-term%d*" arg))))))

    (add-hook 'eat--semi-char-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))
    ;; (add-hook 'eat--char-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))
    (add-hook 'eat-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))

    (custom-set-faces
     '(eat-term-color-4 ((t (:inherit eat-term-color-32)))))))

(defun eab-spacemacs/init-auctex nil
;; (load "auctex.el" nil t t)
  (use-package eab-tex))
(defun eab-spacemacs/init-org-agenda-property nil
  (use-package org-agenda-property
    :after (org-agenda)
    :config
    (setq org-agenda-property-list '("Custom_BIB"))))
(defun eab-spacemacs/init-region-bindings-mode nil
  (use-package region-bindings-mode
    :after (eab-minimal)
    :config
    (region-bindings-mode-enable)
    ;; prevent annoying switching on rk in region-bindings-mode on set-mark-command
    (add-hook 'window-configuration-change-hook
              (lambda ()
                (if (and mark-active (not (use-region-p)))
                    (deactivate-mark))))
    (define-advice winner-undo (:before (&rest args) eab-winner-undo-before)
      (region-bindings-mode-disable))
    (define-advice winner-undo (:after (&rest args) eab-winner-undo-after)
      (region-bindings-mode-enable))
    (define-advice winner-redo (:before (&rest args) eab-winner-redo-before)
      (region-bindings-mode-disable))
    (define-advice winner-redo (:after (&rest args) eab-winner-redo-after)
      (region-bindings-mode-enable))
    (define-advice region-bindings-mode-on (:before (&rest args) eab-region-bindings-mode-on)
      (progn
        (setq region-bindings-mode-disabled-modes '(magit-status-mode magit-diff-mode))
        (general-define-key
         :keymaps 'region-bindings-mode-map
         "3"        'eab/gptel-one-shot-3
         "w"        (ilam (shell-command-on-region (region-beginning) (region-end) "wc -l"))
         "ц"        (ilam (shell-command-on-region (region-beginning) (region-end) "wc -l"))
         "u"        'untabify
         "г"        'untabify
         "s"        'sort-lines
         "ы"        'sort-lines
         "o"        'org-sort
         "щ"        'org-sort
         "c"        'copy-rectangle-as-kill
         "с"        'copy-rectangle-as-kill
         "v"        'yank-rectangle
         "м"        'yank-rectangle
         "0"        (ilam (eab/or-self-insert-body (er/expand-region 0)))
         "p"        (ilam (eab/or-self-insert-body (er/expand-region 1)))
         "-"        (ilam (eab/or-self-insert-body (er/expand-region -1)))
         "P"        (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (org-mark-paragraph))))
         "З"        (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (org-mark-paragraph))))
         "I"        (ilam (eab/or-self-insert 'indent-region))
         "Ш"        (ilam (eab/or-self-insert 'indent-region))
         "d"        (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-defun))))
         "/"        (ilam (let ((this-command 'ergoemacs-toggle-letter-case)) (eab/or-self-insert 'ergoemacs-toggle-letter-case)))
         "r"        (ilam (eab/or-self-insert 'string-rectangle))
         "к"        (ilam (eab/or-self-insert 'string-rectangle))
         "t"        'nil
         ;; TODO: C-g неправильно работает с region-bindings-mode
         ;; "C-g"   (ilam (eab/or-self-insert 'mc/keyboard-quit))
         "g"        (ilam (eab/or-self-insert 'mc/keyboard-quit))
         "п"        (ilam (eab/or-self-insert 'mc/keyboard-quit))
         "G"        'google-region
         "П"        'google-region
         "l"        (ilam (eab/or-self-insert 'eab/replace-selection))
         "д"        (ilam (eab/or-self-insert 'eab/replace-selection))
         "R"        (ilam (eab/or-self-insert 'eab/replace-newline-by-space))
         "К"        (ilam (eab/or-self-insert 'eab/replace-newline-by-space))
         "e"        'mc/edit-lines
         "у"        'mc/edit-lines
         "x"        (ilam (eab/or-self-insert 'kill-rectangle))
         "ч"        (ilam (eab/or-self-insert 'kill-rectangle))
         "A"        (ilam
                     (eab/or-self-insert-body
                      (save-restriction
                        (narrow-to-region (window-start) (window-end))
                        (ignore-errors (mc/mark-all-like-this)))))
         "D"        'ansible-vault-decrypt-region
         "E"        'ansible-vault-encrypt-region
         "a"        'mc/mark-all-like-this
         "i"        'mc/mark-previous-like-this
         "ш"        'mc/mark-previous-like-this
         "k"        'mc/mark-next-like-this
         "л"        'mc/mark-next-like-this
         "C-c C-c"  'org-toggle-checkbox
         "m"        'mc/mark-more-like-this-extended)))))
(defun eab-spacemacs/init-smex nil
  (use-package smex)
  (use-package eab-smex
    :after (helm smex eab-minimal)
    :config
    (eab/bind-path smex-save-file)))
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
    (eab/bind-path auto-install-directory)))
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
                 "s-r"        'paredit-raise-sexp
                 "s-L"        'paredit-forward-barf-sexp
                 "s-J"        'paredit-backward-barf-sexp
                 "s-l"        'paredit-forward-slurp-sexp
                 "s-j"        'paredit-backward-slurp-sexp
                 "s-I"        'paredit-splice-sexp
                 "s-K"        'undefined
                 "s-i"        'paredit-splice-sexp-killing-backward
                 "s-k"        'undefined
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
    (eab/bind-path ebib-file-search-dirs)
    (eab/bind-path ebib-preload-bib-files)
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
    (eab/bind-path achievements-file)))
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
  (use-package org
    :config
    (eab/bind-path org-directory)
    (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
    (add-hook 'org-mode-hook (lambda () (setq indent-tabs-mode nil)))
    ;; fix org-element performance degradation
    (setq org-element--cache-self-verify 't)
    (setq org-element-use-cache 't)
    (if (string= (daemonp) "kairosC") (setq org-cycle-hide-drawer-startup nil))
    '((setq org-element-cache-persistent nil))
    '((setq org-element-use-cache nil))
    ;; fix 'file is already exist' bug
    (setq org-babel-temporary-directory "/tmp/user/1000/babel-aa5I6G"))
  (use-package org-clock)
  (use-package org-crypt)
  (use-package org-capture)
  (use-package org-id)
  (use-package org-archive)
  (use-package ox-latex)
  (use-package ox-html)
  (use-package ol-bbdb)
  (use-package org-agenda)
  (use-package org-protocol)
  (use-package org-src)

  (eab/add-hook orgtbl-mode-hook eab/orgtbl-mode-hook
    (general-define-key
     :keymaps 'orgtbl-mode-map
     "M-a"        'nil))

  (eab/add-hook org-mode-hook eab/org-hook
    (general-define-key
     :keymaps 'org-mode-map
     "RET"                'eab/org-return
     "M-D"                'ace-link-org
     "C-d"                eab/compile-map
     "<f6>"               'eab/revert-buffer
     "s-'"                'org-edit-src-code
     "s-k"                'undefined
     "s-i"                'org-metaup
     "s-p"                'org-priority-up
     "s-j"                'org-metaleft
     "s-l"                'org-metaright
     "s-K"                'undefined
     "s-I"                'org-shiftmetaup
     "s-J"                'org-shiftmetaleft
     "s-L"                'org-shiftmetaright
     "s-<return>"         'org-insert-heading
     "s-S-<return>"       'org-insert-todo-heading
     "M-s-k"              'org-shiftdown
     "M-s-i"              'org-shiftup
     "M-s-j"              'org-shiftleft
     "M-s-l"              'org-shiftright
     "C-y"                'nil
     "C-e"                'nil
     "C-,"                'nil
     "C-SPC"              'nil
     "M-a"                'nil
     "M-e"                'nil
     "C-a"                'nil
     "C-k"                'nil
     "M-h"                'org-beginning-of-line
     "M-p"                'org-end-of-line
     "M-g"                'org-kill-line
     "M-v"                'org-yank
     "M-RET"              (ilam (org-insert-heading nil))
     "C-M-n"              'org-backward-element
     "C-M-m"              'org-forward-element
     "M-n"                'sp-backward-sexp
     "M-m"                'sp-forward-sexp
     "M-N"                'org-backward-sentence
     "M-M"                'org-forward-sentence
     "M-U"                'eab/org-backward-paragraph
     "M-O"                'eab/org-forward-paragraph
     "M-u"                'eab/org-backward-page
     "M-o"                'eab/org-forward-page
     "C-M-S-u"            'org-backward-paragraph
     "C-M-S-o"            'org-forward-paragraph
     "C-M-u"              'outline-previous-visible-heading
     "C-M-o"              'outline-next-visible-heading
     "s-u"                'org-preview-latex-fragment
     "C-c C-x M-c"        'org-copy-special
     "C-c C-x M-x"        'org-cut-special
     "C-c C-x M-v"        'org-paste-special
     "s-x M-c"            'org-copy-special
     "s-x M-x"            'org-cut-special
     "s-x M-v"            'org-paste-special
     "s-."                (kbd "C-c . RET"))

    (key-chord-define org-mode-map "jj" 'org-edit-src-code)
    (key-chord-define org-src-mode-map "jj" 'org-edit-src-exit)

    (general-define-key
     :keymaps 'org-src-mode-map
     "s-'"        'org-edit-src-exit
     "C-l '"      'org-edit-src-exit)

    (general-define-key
     :keymaps 'org-ql-view-map
     "q" #'eab/bury-buffer
     "g" #'eab/org-ql-view-refresh)

    (general-define-key
     :keymaps 'org-agenda-mode-map
     "M-j"        'nil
     "M-l"        'nil
     "C-p"        'nil
     "C-n"        'nil
     "C-k"        'nil
     "s"          'isearch-forward
     "h"          'eab/hron-todo
     "j"          'beginning-of-buffer
     "M-g"        'org-agenda-kill
     "M-k"        'org-agenda-next-line
     "M-i"        'org-agenda-previous-line))
  )
(defun eab-spacemacs/init-org-mode-fix/lisp nil
  ;; fix 'file is already exist' bug
  (setq org-babel-temporary-directory "/tmp/user/1000/babel-aa5I6G"))
(defun eab-spacemacs/init-f nil)
(defun eab-spacemacs/init-keyfreq nil
  (use-package keyfreq
    :config
    (eab/bind-path keyfreq-file)
    (eab/bind-path keyfreq-file-lock)
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
    (eab/bind-path ac-comphist-file)
    (eab/bind-path eab/american-english)
    (defvar-mode-local org-mode ac-auto-start nil)
    (defvar-mode-local org-mode ac-use-quick-help nil)))
(defun eab-spacemacs/init-yasnippet nil
  (use-package yasnippet
    :after (org)
    :config

    (setq yas-snippet-dirs '())
    ;; cd el-get && git clone https://github.com/AndreaCrotti/yasnippet-snippets
    (add-to-list 'yas-snippet-dirs (eab/bind-path eab/eab-snippets-path))

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
    (eab/bind-path eab/eeansi-path)
    (eab/bind-path eab/eegchannel-path)
    (setq vterm-shell eab/eeansi-path)))
(defun eab-spacemacs/init-bbdb/lisp nil
  (use-package bbdb
    :config
    (eab/bind-path bbdb-file)
    (bbdb-initialize 'gnus 'message 'sc) ;; 'w3m)
    (setq bbdb-north-american-phone-numbers-p nil))
  (use-package bbdb-loaddefs)
  (use-package bbdb-anniv))
(defun eab-spacemacs/init-eab-misc nil
  (use-package org-depend
    :after (org))
  (use-package power-macros
    :after (eab-depend) ;; keybindings.el C-l vs eab-pmacros.el
    :config
    (eab/bind-path pm-macro-files)
    (eab/bind-path power-macros-file)
    (if (file-exists-p power-macros-file)
        (load power-macros-file))
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
                                     (pm-get-available-macros)))))))))
  
  ;; dired+ нужен для привычной подсветки
  (use-package dired+
    :init
    (setq diredp-hide-details-initially-flag nil))
  (use-package dired-details)
  (use-package alossage)
  (use-package shell-command-queue)
  (use-package one-key)
  (use-package json-pretty-print)
  (use-package rec-mode)
  (use-package color-moccur)
  (use-package moccur-edit)
  (use-package smart-operator)
  (use-package ido-better-flex)
  (use-package ox-extra
    :after (org))
  
  (defun multi-occur-in-all-buffers ()
    "Show all lines matching REGEXP in all buffers."
    (interactive)
    (multi-occur
     (buffer-list)
     (car (occur-read-primary-args))))

  (add-hook 'maplev-mode-hook
            (lambda ()
              ;;            (smart-operator-mode-on)
              (general-define-key
               :keymaps 'maplev-mode-map
               "C-c d"      'maplev-help-at-point
               "C-k"        'toggle-input-method)
              (setq maplev-mint-start-options (list "-q" "-P"))
              (setq maplev-executable-alist '(("11" "maple" nil "maple")
                                              ("10" "maple" nil "mint")))))

  (autoload 'cmaple "maplev" "Start maple process" t)
  (autoload 'emaxima-mode "emaxima" "EMaxima mode" t)
  (autoload 'maplev-mode "maplev" "Maple editing mode" t)
  (autoload 'maxima "maxima" "Running Maxima interactively" t)
  (autoload 'maxima-mode "maxima" "Maxima editing mode" t)
  (add-to-list 'auto-mode-alist '("\\.max\\'" . maxima-mode))
  (add-to-list 'auto-mode-alist '("\\.mpl\\'" . maplev-mode))
  (add-to-list 'load-path (eab/bind-path eab/emaxima-path))
  (add-hook 'maxima-mode-hook 
            (lambda ()
              (general-define-key
               :keymaps 'maxima-mode-map
               "C-M-a"      'nil
               "C-M-b"      'nil
               "C-M-e"      'nil
               "C-M-f"      'nil
               "M-;"        'nil
               "C-d"        eab/compile-map
               "M-h"        'nil)))

  (use-package top-mode
    :after (eab-minimal)
    :config
    (define-advice top-mode (:after (&rest args) eab-top-mode-after)
      (general-define-key
       :keymaps 'top-mode-map
       "O"  (ilam (switch-to-buffer "*Proced*"))))))

(defun eab-spacemacs/init-gnus nil
  (use-package eab-gnus :disabled
    :config
    (add-hook 'gnus-summary-prepared-hook 'gnus-summary-hide-all-threads)
    (add-hook 'gnus-summary-prepare-hook 'gnus-summary-sort-by-most-recent-date)))

(defun eab-spacemacs/init-tramp nil
  (use-package tramp
    :config
    (setq tramp-default-method "ssh")
    (eab/bind-path tramp-persistency-file-name))
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
    :after (desktop appt autorevert)))
(defun eab-spacemacs/init-server nil
  (use-package eab-server
    :after (org)))
(defun eab-spacemacs/init-compile nil
  (eab/add-hook compilation-mode-hook eab/compilation-hook
    (general-define-key
     :keymaps 'compilation-button-map
     "M-RET"      'eab/compile-goto-error-same-window
     "RET"        'eab/compile-goto-error)
    (general-define-key
     :keymaps 'compilation-mode-map
     "g"          'eab/recompile
     "B"          'compilation-a-lot-goto-prev
     "F"          'compilation-a-lot-goto-next
     "\C-d"       eab/compile-map
     "\C-o"       'nil
     "M-k"        'nil
     "M-p"        'nil
     "M-i"        'nil
     "M-n"        'nil))
  (use-package eab-compile
    :after (ansi-color eab-depend)
    :config
    (defvar eab/compile-map (make-sparse-keymap)
      "Compile keymap.")
    (global-set-key (kbd "C-d") nil)
    (general-define-key
     :prefix "C-d"
     "q"    'eab/nocommand
     "a"    'eab/compile-helm
     "e"    eab/explore-map
     "d"    'eab/projectile-compile-project
     "C-d"    'eab/projectile-compile-project
     "s"    (ilam (smart-compile 4))
     "S"    `(,(ilam (eab/projectile-compile-project-custom "make push_unstaged")) :which-key " ")
     "l"    `(,(ilam (TeX-command "LaTeX"   'TeX-master-file)) :which-key " ")
     "b"    `(,(ilam (TeX-command "BibTeX"  'TeX-master-file)) :which-key " ")
     "L"    `(,(ilam (TeX-command "LaTeX"   'TeX-master-file)) :which-key " ")
     "p"    `(,(ilam (eab/projectile-compile-project-custom "make push_all")) :which-key " ")
     "c"    `(,(ilam (eab/projectile-compile-project-custom "make clear")) :which-key " ")
     "t"    `(,(ilam (eab/projectile-compile-project-custom "make test")) :which-key " ")
     "2"    `(,(ilam (eab/projectile-compile-project-custom "make test2")) :which-key " "))
    (setq eab/compile-map (lookup-key global-map (kbd "C-d")))
    (setq compile-command "make ")
    (setq compilation-exit-message-function 'compilation-exit-autoclose)
    (setq compilation-exit-message-function nil)
    (setq compilation-scroll-output 't)))
(defun eab-spacemacs/init-grep nil
  (eab/add-hook grep-mode-hook eab/grep-hook
    (general-define-key
     :keymaps 'grep-mode-map
     "B"          'eab/switch-grep-prev
     "F"          'eab/switch-grep-next
     "C-o"        'nil
     "M-p"        'nil
     "C-l b"      'eab/kill-last-grep
     "b"          (ilam (eab/switch-grep-prev 't))
     "M-RET"      'eab/compile-goto-error-same-window
     "C-M-j"      'eab/compile-goto-error-same-window
     "RET"        'eab/compile-goto-error
     "g"          'eab/recompile
     "u"          'eab/grep-utf
     "s"          'eab/grep-switch
     "l"          (ilam (so-long-minor-mode 1) (toggle-truncate-lines 1))
     "M-n"        'nil
     "C-w"        'eab/wgrep-change-to-wgrep-mode))
  (use-package eab-grep
    :after (grep-a-lot wgrep eab-depend)
    :config
    (defvar eab/grep-map (make-sparse-keymap)
      "Grep keymap.")
    (global-set-key (kbd "C-x G") nil)
    (general-define-key
     :prefix "C-x G"
     "f"    'eab/find-grep
     "g"    'eab/find-grep
     "c"    'eab/clock-grep
     "s"    (ilam
             (call-interactively 'eab/grep)
             (call-interactively 'eab/switch-grep)
             ;; (setq-local eab/grep-switch-cycle 'full)
             (sleep-for 0.4)
             (progn
               (eab/grep-switch-0 eab/grep-clock-left eab/grep-clock-right)
               (setq-local eab/grep-switch-cycle 'full)))
     "G"    'eab/clock-grep)
    (setq eab/grep-map (lookup-key global-map (kbd "C-x G")))
    ))

(defun eab-spacemacs/init-dired nil
  (eab/add-hook dired-mode-hook eab/dired-hook
    (general-define-key
     :keymaps 'dired-mode-map
     "C-M-b"      'nil
     "M-a"        'nil
     "M-i"        'nil
     "M-j"        'nil
     "C-n"        'nil
     "M-c"        'nil
     "M-g"        'nil
     "M-G"        'nil
     "M-v"        'nil
     "M-!"        'nil
     "M-l"        'nil
     "M-p"        'nil
     "M-o"        'nil
     "M-s"        'nil
     "M-u"        'nil
     "M-m"        'nil
     "C-o"        'nil
     "C-p"        'nil
     "C-k"        'nil
     "C-S-a"      'nil
     "C-c C-w"    'dired-do-rename
     "C-w"        'wdired-change-to-wdired-mode
     "b"          'browse-url-of-dired-file
     "o"          'dired-find-file-other-window
     "C-|"        'eab/dired-see-file
     "s-SPC"      'eab/dired-see-file
     "E"          'ediff-files
     "SPC"        'open-in-external-app))
  (eab/add-hook wdired-mode-hook eab/wdired-hook
    (general-define-key
     :keymaps 'wdired-mode-map
     "s-w"        'wdired-finish-edit))
  (use-package dired-async)
  (use-package dired-x)
  (use-package eab-dired
    :after (dired eab-minimal eab-tramp eab-org eab-depend)
    :config
    (defvar eab/dired-map (make-sparse-keymap)
      "keymap for fast dired")
    (global-set-key (kbd "C-x d") nil)
    (eab/bind-path eab/downloads-path)
    (general-define-key
     :prefix "C-x d"
     "d" '(ido-dired :which-key "ido-dired")
     "o" `(,(ilam (dired eab/org-publish-directory)) :which-key ,eab/org-publish-directory)
     "h" `(,(ilam (dired "~/desktop")) :which-key "~/desktop")
     "s" `(,(ilam (dired "~/share")) :which-key "~/share")
     "p" `(,(ilam (dired eab/downloads-path)) :which-key ,eab/downloads-path)
     "t" `(,(ilam (dired "~/tmp")) :which-key "~/tmp"))
    (setq eab/dired-map (lookup-key global-map (kbd "C-x d")))
    (add-to-list 'auto-mode-alist '("\\.dired$" . dired-virtual-mode))))

(defun eab-spacemacs/init-ido nil
  (eab/add-hook ido-minibuffer-setup-hook eab/ido-minibuffer-hook
    (general-define-key
     :keymaps 'ido-file-dir-completion-map
     "M-v"        'yank)
    (general-define-key
     :keymaps 'ido-file-completion-map
     "C-n"        (eab/do-action (ilam (execute-kbd-macro (read-kbd-macro "C-x C-f / 2*s h : k a i r o s - h o s t | s u d o : k a i r o s - h o s t : / C-x Q"))))
     "C-d"        'eab/ace-ibuffer
     "C-|"        'eab/ido-see-file
     "s-SPC"      'eab/ido-see-file)
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
    (eab/bind-path ido-save-directory-list-file)))
(defun eab-spacemacs/init-abbrev nil
  (use-package eab-words
    :after (abbrev simple)
    :config
    (eab/bind-path abbrev-file-name)
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
    (eab/bind-path bookmark-default-file)
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

(defun eab-spacemacs/init-eab-ui ()
  (use-package eab-ui
    :config
    (eab/bind-path auto-save-list-file-prefix)
    (eab/bind-path save-place-file)
    (eab/bind-path url-configuration-directory)
    (eab/bind-path source-directory)
    (setq find-function-C-source-directory source-directory)
    (eab/bind-path custom-file)))
(defun eab-spacemacs/init-eab-org ()
  (use-package eab-org
    :init
    (eab/bind-path eab/org-publish-directory-file)
    (eab/bind-path eab/org-publish-directory)
    :after (org
            org-clock
            org-crypt
            org-capture
            org-id
            org-archive
            ol-bbdb
            ox-latex
            ox-extra
            ox-html
            tex
            tex-site
            eab-minimal)
    :config
    (eab/bind-path org-link-abbrev-alist)
    (eab/bind-path org-id-locations-file)
    (eab/bind-path org-clock-persist-file)
    (eab/bind-path bibtex-files)
    (eab/bind-path org-ditaa-jar-path)))
(defun eab-spacemacs/init-eab-org-agenda ()
  (use-package eab-org-agenda
    :after (org org-agenda)
    :config
    (add-hook 'org-agenda-mode-hook (lambda () (hl-line-mode 1)))
    (setq org-sort-agenda-notime-is-late nil)
    (setq org-agenda-sorting-strategy
          '((agenda habit-down time-up priority-down category-keep)
            (todo timestamp-down)
            (tags priority-down category-keep)
            (search category-keep)))
    (setq org-agenda-hide-tags-regexp nil)
    (org-toggle-sticky-agenda t)
    (setq org-agenda-include-diary nil)
    (setq org-agenda-archives-mode 't)
    (setq org-agenda-text-search-extra-files (quote (agenda-archives)))
    (setq org-agenda-clockreport-parameter-plist (quote (:link nil :maxlevel 2)))))
(defun eab-spacemacs/user-config ()
  (use-package cl)
  (use-package cl-macs)
  (use-package view)
  (use-package ps-print)
  (use-package ps-mule)
  (use-package uniquify
    :config
    (setq uniquify-buffer-name-style 'forward))
  (use-package savehist
    :config
    (eab/bind-path savehist-file)
    (savehist-mode 1))
  (use-package log-edit)
  (use-package tex)
  (use-package tex-site)

  (use-package eab-org-publish)
  (use-package eab-org-protocol
    :after (eab-org org-protocol))
  (use-package eab-org-src-babel
    :after (org-src ob-tmux))
  (use-package eab-org-todo)
  (use-package eab-hron-lib
    :after (eab-org))
  (use-package eab-org-latex
    :config
    (add-hook 'LaTeX-mode-hook 
              (lambda ()
                (general-define-key
                 :keymaps 'LaTeX-mode-map
                 "M-m"        'forward-sexp
                 "C-d"        'nil
                 "C-S-d"      eab/compile-map))))
  (use-package eab-greek-to-latex :disabled)
  (use-package eab-org-reftex :disabled)
  (use-package eab-org-extension)
  (use-package eab-postload
    :after (org)))
