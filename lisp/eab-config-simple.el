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
  (setq eab/translate-path (eab/config "~/bin/translate"))
  (setq eab/trans-path (eab/config "~/git/python/trans.py")))

(general-define-key  "C-s"          (ilam (save-some-buffers 't)))

;; Also files.el
(setq backup-directory-alist (eab/config '`((".*" . ,emacs-tmp-dir))))
(setq auto-save-file-name-transforms (eab/config '`((".*" ,emacs-tmp-dir t))))
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
                 "%b"))))

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
 "M-a"          'eab/smex-extended
 "C-w"          'eab/smex-repeat
 "M-E"          (ilam (delete-minibuffer-contents)))

(column-number-mode 1)
(setq 
 mark-ring-max 64
 global-mark-ring-max 64
 indent-tabs-mode nil
 )
(setq eshell-history-file-name (eab/config "~/.bash_history"))
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
