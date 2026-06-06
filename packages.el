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

    (org :location local)
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
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar eab-spacemacs-excluded-packages '()
  "List of packages to exclude.")

(defun eab-spacemacs/init-ox-pandoc nil)
(defun eab-spacemacs/init-gptel nil
  ;; (setq gptel-log-level 'debug)
  ;; (setq gptel-confirm-tool-calls 'always)
  (setq gptel-default-mode 'org-mode)
  (setq gptel-expert-commands 't)
  (setq gptel-api-key (eab/orai-token))
  (setq gptel-model   'deepseek/deepseek-v3.2
        gptel-backend
        (gptel-make-openai "OpenRouter"
          :host "openrouter.ai"
          :curl-args '("-xsocks5://192.168.2.19:9050")
          :endpoint "/api/v1/chat/completions"
          :stream t
          :key 'gptel-api-key
         :models '(openai/gpt-oss-120b
                    qwen/qwen-turbo
                    nvidia/nemotron-3-super-120b-a12b:free
                    qwen/qwen3-coder-30b-a3b-instruct
                    qwen/qwen3.6-plus:free
                    qwen/qwen3-coder-next
                    deepseek/deepseek-v3.2
                    deepseek/deepseek-v4-pro
                    mistralai/mixtral-8x7b-instruct
                    meta-llama/codellama-34b-instruct
                    codellama/codellama-70b-instruct
                    google/palm-2-codechat-bison-32k
                    google/gemini-pro
                    )))
  (defun eab/gptel-one-shot-3 ()
    (interactive)
    (let ((inhibit-message t))
      (kill-new
        "Суммируй приведенный текст ровно тремя словами.
Формат ответа -- 3 слова, например: деньги-дата-отложить"))
    (execute-kbd-macro
     (read-kbd-macro "C-v m k m RET M-v RET")))
  (defun eab/gptel-rewrite ()
    "Rewrite the current buffer or region.
This function sets the gptel model to qwen/qwen3-coder-30b-a3b-instruct and
calls the gptel-rewrite interactive command."
    (interactive)
    (setq gptel-model 'qwen/qwen3-coder-30b-a3b-instruct)
    (call-interactively 'gptel-rewrite))
  (defun eab/gptel-mode ()
    (interactive)
    (call-interactively 'org-mode)
    (call-interactively 'gptel-mode))
  )
(defun eab-spacemacs/init-gptel-agent nil
  (use-package gptel-agent
    :config
    (add-to-list 'gptel-agent-dirs "/home/eab/.emacs.d/private/eab-spacemacs/agents/")
    (gptel-agent-update)
    )
  (use-package gptel-agent-tools
    ;; after package is loaded
    :config
    (add-to-list 'gptel-tools (cdr (assoc "WebSearch" (cdar gptel--known-tools))))
    (add-to-list 'gptel-tools (cdr (assoc "WebFetch" (cdar gptel--known-tools))))))
(defun eab-spacemacs/init-gptel-magit nil
  (use-package gptel-magit
    :after (magit gptel)
    ;; before package is loaded
    :config
    (setq gptel-magit-model 'qwen/qwen3-coder-next)
    (setq gptel-magit-commit-prompt
          "You are an expert at writing Git commits. Your job is to write a short clear commit message that summarizes the changes.

The commit message should be structured as follows:

    <type>(<optional scope>): <description>

    [optional body]

- Commits MUST be prefixed with a type, which consists of one of the followings words: build, chore, ci, docs, feat, fix, perf, refactor, style, test
- The type feat MUST be used when a commit adds a new feature
- The type fix MUST be used when a commit represents a bug fix
- An optional scope MAY be provided after a type. A scope is a phrase describing a section of the codebase enclosed in parenthesis, e.g., fix(parser):
- A description MUST immediately follow the type/scope prefix. The description is a short description of the code changes, e.g., fix: array parsing issue when multiple spaces were contained in string.
- Try to limit the whole subject line to 60 characters
- Capitalize the subject line
- Do not end the subject line with any punctuation
- Use the imperative mood in the subject line
- Keep the body short and concise (omit it entirely if not useful)" )
    (defun eab/gptel-magit-generate-message ()
      "Generate a commit message."
      (interactive)
      (gptel-magit--generate (lambda (message)
                               (with-current-buffer (current-buffer)
                                 (save-excursion
                                   (insert message)))))
      (message "magit-gptel: Generating commit message..."))
    (defun gptel-magit--generate (callback)
      "Generate a commit message for current magit repo.
Invokes CALLBACK with the generated message when done."
      (let ((diff (magit-git-output "diff" "--cached" "HEAD^"))
            (gptel-tools nil)
            (gptel-use-tools nil))
        (gptel-magit--request diff
          :system gptel-magit-commit-prompt
          :context nil
          :callback `(lambda (response _info)
                       (let ((msg response))
                         (funcall ,callback msg))))))))
(defun eab-spacemacs/init-elisa nil)
(defun eab-spacemacs/init-llm ()
  (use-package llm)
  (use-package llm-openai))
(defun eab-spacemacs/init-ellama ()
  (use-package ellama
    :after (llm llm-openai)
    :config
    (setq eab-llm (make-llm-openai-compatible
                   :url "https://llm.api.cloud.yandex.net/v1"
                   :chat-model (concat "gpt://" (eab/yc-id) "/yandexgpt/rc")
                   :key (eab/ycai-token)))
    (setopt ellama-language "Russian")
    (setopt ellama-provider eab-llm)
    (setopt ellama-coding-provider eab-llm)))
(defun eab-spacemacs/init-kubernetes nil)
(defun eab-spacemacs/init-prodigy nil
  (use-package prodigy))
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

(defun eab-spacemacs/init-solarized-theme nil)
(defun eab-spacemacs/init-s ()
  (use-package s))

(defun eab-spacemacs/init-groovy-mode ()
  (use-package groovy-mode)
  (add-hook 'groovy-mode-hook (lambda () (setq indent-tabs-mode nil))))

(defun eab-spacemacs/init-terraform-mode ()
  (use-package terraform-mode))

(defun eab-spacemacs/init-k8s-mode ()
  (use-package k8s-mode))

(defun eab-spacemacs/init-rust-mode ()
  (use-package rust-mode))

(defun eab-spacemacs/init-so-long ()
  (use-package so-long
    :config
    (global-so-long-mode 1)))

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
    (add-to-list 'load-path "/home/eab/.emacs.d/private/eab-spacemacs/local/consult-omni")
    (add-to-list 'load-path "/home/eab/.emacs.d/private/eab-spacemacs/local/consult-omni/sources")
    :config
    (setq consult-omni-multi-sources '("DuckDuckGo API"))))
(defun eab-spacemacs/init-projectile nil
  (use-package projectile
    :config
    (setq projectile-require-project-root t)
    (setq projectile-per-project-compilation-buffer t)
    (eab/bind-path projectile-known-projects-file)
    (setq projectile-project-root-files-bottom-up
          '(".git"        ; Git VCS root dir
            ".projectile" ; projectile project marker
            ".hg"         ; Mercurial VCS root dir
            ".fslckout"   ; Fossil VCS root dir
            ".bzr"        ; Bazaar VCS root dir
            "_darcs"      ; Darcs VCS root dir
            ))
    (puthash "/home/eab/git/eab-system/portal/"
             (make-ring 256)
             projectile-project-command-history)
    (ring-insert
     (projectile--get-command-history "/home/eab/git/eab-system/portal/")
     "make deploy-config li=\"--limit chronos,cyclos\"")))
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
    ;; (key-chord-mode 1) ; DONE заедает, если не в конце dotemacs, не включается по-умолчанию (или выключается из-за чего-то)
    (add-hook 'term-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))))
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
ssh chronos docker exec -u app \
  -e HOME=/config \
  -e DBUS_SESSION_BUS_ADDRESS=unix:path=/tmp/dbus.base \
   firefox firefox --profile /config/profile " url)  nil 0)
      (switch-to-buffer "Firefox"))
    (defun eab/browse-url (url &optional arg)
      (interactive)
      (if current-prefix-arg
          (browse-url-firefox url)
        (eaf-open-browser-other-window url)))
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

(defun eab-spacemacs/init-spacemacs-theme ()
    (setq spacemacs-theme-comment-bg nil))
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

    ;; TODO why concrete buffer-name only?
    (define-advice display-message-or-buffer (:before (&rest args) ansi-color)
      "Process ANSI color codes in shell output."
      (let ((buf (car args)))
        (and (bufferp buf)
             (string= (buffer-name buf) "*Shell Command Output*")
             (with-current-buffer buf
               (ansi-color-apply-on-region (point-min) (point-max))))))))
(defun eab-spacemacs/init-autorevert nil
  (use-package autorevert
    :config
    (global-auto-revert-mode)
    (setq auto-revert-use-notify nil)))
(defun eab-spacemacs/init-helm nil
  (use-package eab-helm
    :defer
    :after (eab-org)
    :init
    (defvar browse-url-galeon-program nil)
    (defun browse-url-galeon nil)
    (defvar browse-url-netscape-program nil)
    (defun browse-url-netscape nil)
    :config
    (eab/bind-path eab/musicdb-path)
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
    (add-to-list 'helm-org-headings-actions '("eab/helm-org-goto-marker" . eab/helm-org-goto-marker))
    (add-to-list 'helm-org-headings-actions '("eab/helm-note-todo" . eab/helm-note-todo))
    (add-to-list 'helm-org-headings-actions '("eab/helm-org-switch-ql" . eab/helm-org-switch-ql))
    (add-to-list 'helm-org-headings-actions '("eab/hron-todo" . eab/helm-hron-todo))))
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
    (eab/bind-path mc/list-file)
    (if (boundp 'mc--default-cmds-to-run-for-all)
        (setq mc--cmds mc--default-cmds-to-run-for-all))
    ;; TODO mc/cmds-to-run-for-all переназначается (sp-backward-sexp sp-forward-sexp)
    (setq mc/cmds-to-run-for-all (append mc/cmds-to-run-for-all
                                         '(org-delete-char
                                           org-self-insert-command)))))
(defun eab-spacemacs/init-flx-isearch ()
  ;; TODO поробовать разрешить в agenda?
  (flx-isearch-mode 0)
  (setq isearch-search-fun-function 'isearch-search-fun-default))

(defun eab-spacemacs/init-workgroups2/src ()
  (use-package eab-workgroups2
    :after (workgroups2)
    :config
    (setq wg-use-default-session-file 't)
    (setq wg-control-frames 'nil)
    (setq wg-session-load-on-start nil)
    (eab/bind-path wg-session-file)
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
    (transient-append-suffix 'magit-diff "-A"
      '("-a" "Treat all files as text." "--text"))
    (transient-append-suffix 'magit-diff "-a"
      '("-S" "Submodule diff" "--submodule=diff"))
    (setq magit-section-visibility-indicator nil)
    (defun eab/magit-amend-modified ()
      (interactive)
      (magit-stage-modified)
      (call-interactively 'magit-commit-amend)))
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
  ;; TODO cancel rev-export disabling
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
    (add-to-list 'auto-mode-alist '("/\\.ssh/config\\'"     . ssh-config-mode))
    (add-to-list 'auto-mode-alist '("/sshd?_config\\'"      . ssh-config-mode))
    (add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
    (add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode))))
(defun eab-spacemacs/init-textile-mode ()
  (use-package textile-mode
    :config
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
  (autoload 'python-mode "python-mode" "Python Mode." t))
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
  (if (eab/ondaemon "cyclos")
      (progn
        (use-package eaf
          :config
          (setq eaf-webengine-pc-user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36")
          ;; (setq eaf-proxy-host "192.168.2.19")
          ;; (setq eaf-proxy-port "9152")
          ;; (setq eaf-proxy-type "http")
          ;; (eaf-restart-process)
          (advice-remove #'org-open-file #'eaf--find-file-advisor)
          (defun eab/org-eaf-open (path link)
            (eaf-open path))
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
           )
          (eaf-create-send-sequence-function "ctrl-t" "C-t")
          (eaf-create-send-sequence-function "ctrl-v" "C-v"))
        (use-package eaf-browser
          :after (eaf)
          :init
          (add-to-list 'load-path "/home/eab/.emacs.d/private/eab-spacemacs/local/eaf/app/browser")
          :config
          (setq eaf-browser-auto-import-chrome-cookies 't)
          (setq eaf-browser-chrome-browser-name "chrome")
          (setq eaf-browser-dark-mode nil)
          (setq eaf-browser-keybinding nil)
          (let ((kb 'eaf-browser-keybinding))
            (mapc (lambda (x)
                    (eval `(eab/eaf-bind-key ,x ,kb)))
                  '(
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
                    ("M-D" . "open_link")
                    ;; ("D" . "toggle_dark_mode")
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
          :after (eaf)
          :init
          (add-to-list 'load-path "/home/eab/.emacs.d/private/eab-spacemacs/local/eaf/app/pdf-viewer")
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
                    )))))))
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
      (region-bindings-mode-enable))))
(defun eab-spacemacs/init-smex nil
  (use-package smex)
  (use-package eab-smex
    :after (helm smex eab-minimal)))
(defun eab-spacemacs/init-smartparens nil
  (use-package smartparens
    :config
    (setq sp-ignore-modes-list nil)) ;; fix boundp sp-keymap
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
        ;; TODO tramp default-directory path
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
  (use-package org-ql
    :defer)
  (use-package org-ql-search
    :defer
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
(defun eab-spacemacs/init-org nil
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
(defun eab-spacemacs/init-ob-tmux nil)
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
    (push '("\\.md\\'" . markdown-mode) auto-mode-alist)
    (add-hook 'markdown-mode-hook (lambda () (setq indent-tabs-mode nil)))
    (add-to-list 'auto-mode-alist
                 '("stack\\(exchange\\|overflow\\)\\.com\\.[a-z0-9]+\\.txt"
                   . markdown-mode))))
(defun eab-spacemacs/init-auto-complete nil
  (use-package auto-complete)
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
    :defer
    :config

    (setq yas-snippet-dirs '())
    ;; cd el-get && git clone https://github.com/AndreaCrotti/yasnippet-snippets
    ;; (add-to-list 'yas-snippet-dirs (eab/bind-path eab/yasnippets-path))
    (add-to-list 'yas-snippet-dirs (eab/bind-path eab/eab-snippets-path))

    (setq yas-key-syntaxes '("w_" "w_." "w_.()" "^ "))

    (defun yas-org-very-safe-expand ()
      (yas-minor-mode 't)
      (let ((yas-fallback-behavior 'return-nil)
            )
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
  (use-package power-macros
    :config
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
  
  (defun multi-occur-in-all-buffers ()
    "Show all lines matching REGEXP in all buffers."
    (interactive)
    (multi-occur
     (buffer-list)
     (car (occur-read-primary-args))))

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
  (autoload 'cmaple "maplev" "Start maple process" t)
  (autoload 'emaxima-mode "emaxima" "EMaxima mode" t)
  (autoload 'maplev-mode "maplev" "Maple editing mode" t)
  (autoload 'maxima "maxima" "Running Maxima interactively" t)
  (autoload 'maxima-mode "maxima" "Maxima editing mode" t)
  (add-to-list 'auto-mode-alist '("\\.max\\'" . maxima-mode))
  (add-to-list 'auto-mode-alist '("\\.mpl\\'" . maplev-mode))
  (add-to-list 'load-path (eab/bind-path eab/emaxima-path))

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
  (use-package eab-server))
(defun eab-spacemacs/init-compile nil
  (use-package eab-compile
    :config
    (setq compile-command "make ")
    (setq compilation-exit-message-function 'compilation-exit-autoclose)
    (setq compilation-exit-message-function nil)
    (setq compilation-scroll-output 't)))
(defun eab-spacemacs/init-grep nil
  (use-package eab-grep
    :after (grep-a-lot wgrep)))

(defun eab-spacemacs/init-dired nil
  (use-package dired-async)
  (use-package dired-x)
  (use-package eab-dired
    :after (dired eab-minimal eab-tramp eab-org)
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
  (use-package eab-ido
    :after (flx-ido projectile eab-minimal)))
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
  (use-package bookmark)
  (use-package eab-bookmark
    :after (bookmark eab-minimal eab-workgroups2)))

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
        ;; TODO ace -> avy
        (ace-jump-do (concat "\\b" isearch-string))))))

(defun eab-spacemacs/init-eab-avy ()
  (use-package avy
    :config
    (setq avy-timeout-seconds 0.25)))

(defun eab-spacemacs/init-eab-ui ()
  (use-package eab-ui))
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
  (use-package org)
  (use-package org-clock)
  (use-package org-crypt)
  (use-package org-capture)
  (use-package org-id)
  (use-package org-archive)
  (use-package ol-bbdb)
  (use-package ox-latex)
  (use-package ox-extra)
  (use-package ox-html)
  (use-package tex)
  (use-package tex-site)
  (use-package org-agenda)
  (use-package org-protocol)
  (use-package org-src)
  (use-package ob-tmux)

  (use-package eab-depend)
  (use-package eab-org
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
            eab-minimal))
  (use-package eab-org-publish)
  (use-package eab-org-agenda
    :after (org-agenda)
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
    (setq org-agenda-clockreport-parameter-plist (quote (:link nil :maxlevel 2))))
  (use-package eab-org-protocol
    :after (org-protocol))
  (use-package eab-org-src-babel
    :after (org-src ob-tmux))
  (use-package eab-org-todo)
  (use-package eab-hron-lib)
  (use-package eab-org-latex)
  (use-package eab-greek-to-latex :disabled)
  (use-package eab-org-reftex :disabled)
  (use-package eab-org-extension)

  (require 'eab-postload))
