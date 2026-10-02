;;; eab-config-simple.el --- eab-config simple configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eab-shell
  :after (eab-minimal files)
  :init
  (setq eab/trans-path (eab/config "~/git/python/trans.py"))
  :config
  (general-define-key
   :keymaps 'eab/ctrl-l-map
   ;; sync and shell-utils over ssh
   "M-d"          (ilam (call-process-shell-command eab/test-dotemacs-command nil 0))
   "M-b"          (ilam
                   (call-process-shell-command
                    (concat eab/dl.sh-command
                            (if region-bindings-mode
                                (buffer-substring (mark) (point))
                              (current-kill 0)))  nil 0))
   "M-s"          (ilam (call-process-shell-command eab/sync-rsync-command nil 0))
   "M-S"          (ilam (call-process-shell-command eab/sync-zfs-command nil 0))
   ;; shell and shell-utils
   "f"            'eab/see-file)
  (general-define-key
   :keymaps 'eab/one-key-map
   "x"    (ilam
           (eab/sh-over-bash eab/emacs-service-command "" 't)))
  (general-define-key
   "M-A"          'eab/call-shell-command
   )
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
  (setq eab/dl.sh-command
        (eab/config (concat "ssh chronos" " dl.sh ")))
  (setq eab/test-dotemacs-command
        ;; host=`dig test-dotemacs.salmon.eab.su TXT +short | tr -d '"'`
        (eab/config (concat "ssh chronos" " ~/git/auto/test-dotemacs.sh")))
  (let ((emacs-alist
         (eab/config
          `(
            ("kairosP"         . "docker-compose-emacs")
            ("chronosP"        . "docker-compose-emacs")
            ("microcyclos"     . "docker-compose-micro")
            ("cyclos"          . "cyclos-emacs")
            ("chronosC"        . "docker-compose-clocksum")
            ("chronosCclient"  . "docker-clocksum-gui")
            ))))
    (setq eab/emacs-service-command
          (eab/config
           (concat
            eab/ssh-host-local
            " 'sudo systemctl restart "
            (cdr
             (assoc eab/daemon-name emacs-alist)))))
    (setq eab/emacs-client-command
          (eab/config
           (concat
            eab/ssh-host-local
            " 'systemctl --user restart "
            (cdr (assoc (concat eab/daemon-name "client") emacs-alist)))))))

(use-package abbrev
  :after (eab-minimal simple)
  :config
  (general-define-key
   "C-c c"        'eab/add-eab-abbrev)
  (eab/search-word eab/add-eab-abbrev "abbrev save" define-abbrev (eab-abbrev-table word word))
  (setq abbrev-file-name
        (eab/config (concat (eab/history-dir) ".abbrev_defs")))
  (if (file-exists-p abbrev-file-name)
      (progn
        (setq save-abbrevs 'silently)
        (quietly-read-abbrev-file abbrev-file-name))))

(use-package dictionary
  :config
  (general-define-key
   "C-c t"        'dictionary-search
   "C-x t"        'dictionary-search
   )
  (setq dictionary-server "localhost")
  (define-advice dictionary-search (:after (&rest args) eab-dictionary-abbrev)
    "Put searched word for dictionary to eab-abbrev-table"
    (let ((word (car args)))
      (unless (string-equal word "")
        (define-abbrev eab-abbrev-table word word))))
  (general-define-key
   :keymaps 'dictionary-mode-map
   "t"  'dictionary-search
   "B"  'dictionary-previous))

(use-package files
  :config
  (general-define-key
   "C-s"          (ilam (save-some-buffers 't))
   )
  ;; DONE: auto-save и торможение при C-s
  (defconst emacs-tmp-dir
    (format "%s/%s%s/"
            (concat (eab/history-dir) "backup")
            (concat "emacs" eab/daemon-name)
            (user-uid)))
  (ignore-errors (make-directory emacs-tmp-dir))
  (setq backup-directory-alist (eab/config `((".*" . ,emacs-tmp-dir))))
  (setq auto-save-file-name-transforms (eab/config `((".*" ,emacs-tmp-dir t))))
  (setq mode-require-final-newline nil)
  (setq require-final-newline nil)
  (setq make-backup-files nil)
  ;; DONE теперь не работают TeX-master "main" в LaTeX-mode
  ;; уже привык их задавать вручную
  (setq enable-local-variables nil))


(use-package replace
  :config
  (general-define-key
   :keymaps 'query-replace-map
   "C-e"  'edit
   "C-r"  'delete-and-edit))

(use-package minibuffer
  :config
  (general-define-key
   :keymaps 'minibuffer-inactive-mode-map
   "o"    'eab/screen-off
   "t"    (ilam (eab/gnome-terminal) (suspend-frame))
   "q"    'suspend-frame)
  (general-define-key
   :keymaps 'minibuffer-local-completion-map
   "M-g"  'nil
   "C-r"  'nil
   "M-n"  'nil
   "M-p"  'nil
   "M-v"  'nil
   "M-s"  'nil)
  (general-define-key
   :keymaps 'minibuffer-local-map
   "C-q"          'quoted-insert
   "M-;"          'isearch-backward
   "C-l M-i"      'previous-line
   "C-l M-k"      'next-line
   "M-RET"        (ilam
                   (run-with-timer
                    0.01 nil
                    `(lambda ()
                       (eab/helm-org-goto-marker ,eab/helm-org-goto-marker)))
                   (if (string= (minibuffer-contents) "")
                       (abort-recursive-edit)
                     (exit-minibuffer)))
   "M-c"          (ilam
                   (run-with-timer
                    0.01 nil
                    `(lambda ()
                       (save-window-excursion
                         (eab/helm-org-goto-marker ,eab/helm-org-goto-marker)
                         (call-interactively 'org-store-link))))
                   (if (string= (minibuffer-contents) "")
                       (abort-recursive-edit)
                     (exit-minibuffer)))
   "M-i"          'previous-history-element
   "M-r"          'nil
   "M-p"          'nil
   "M-n"          'nil
   "M-x"          'nil
   "M-I"          'previous-matching-history-element
   "M-K"          'next-matching-history-element
   "M-v"          'nil
   "M-:"          'helm-minibuffer-history
   "M-k"          'next-history-element
   "C-d"          'eab/clear-extended-history
   "C-|"          'eab/minibuffer-see-file
   "M-E"          (ilam (delete-minibuffer-contents))))

(use-package simple
  :config
  (column-number-mode 1)
  (setq 
   mark-ring-max 64
   global-mark-ring-max 64
   indent-tabs-mode nil
   kill-ring-max 500
   )
  (mapc (lambda (x) (add-to-list 'extended-command-history x))
        '(
          "tramp-cleanup-this-connection"
          "eab/create-workgroups"
          "eab/clear-extended-history"
          "eab/load-personal"
          ))
  (general-define-key
   :keymaps 'eab/ctrl-l-map
   "S"            'toggle-truncate-lines)
  (general-define-key
   :keymaps 'read-expression-map
   "M-g"  'nil))

(use-package eshell
  :config
  (eab/add-hook eshell-mode-hook eab/eshell-hook
    (general-define-key
     :keymaps 'eshell-mode-map
     "M-s"        'nil
     "M-s"        'nil))
  (setq
   eshell-history-file-name (eab/config "~/.bash_history")
   eshell-history-size 1000
   ))

(provide 'eab-config-simple)
