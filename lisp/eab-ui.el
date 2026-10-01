;;; eab-ui.el --- eab ui extension -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements:
;; Status: not intended to be distributed yet

(use-package xterm-color)
(use-package view)
(use-package ps-print)
(use-package ps-mule)
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward))
(use-package savehist
  :config
  (setq savehist-file (eab/config (concat (eab/history-dir) "history")))
  (savehist-mode 1))

(eab/add-hook help-mode-hook eab/help-hook
    (general-define-key
     :keymaps 'help-mode-map
     "o"  'ace-link-help
     "B"  'help-go-back
     "F"  'help-go-forward))

(setq ring-bell-function 'ignore)

(setq disabled-command-function nil)
(fset 'yes-or-no-p 'y-or-n-p)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

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

(setq
 history-length 500
 max-lisp-eval-depth 10000
 gc-cons-threshold 100000000
 )

;; failed to provide feature ‘subr’
(setq max-specpdl-size 10000)

(mapc (lambda (x) (add-to-list 'read-expression-history x))
      '(
        "(setq input-method-function 'key-chord-input-method)"
        "(tramp-term--initialize \"jupiter\")"
        ))

(xterm-mouse-mode 0)
(setq x-select-enable-clipboard t)

(setq enable-recursive-minibuffers t)
(setq-default truncate-lines 't)
(setq truncate-partial-width-windows nil)
(add-hook 'conf-colon-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'sh-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'js-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'emacs-lisp-mode-hook (lambda () (setq indent-tabs-mode nil)))

(unless window-system ;; Only use in tty-sessions.
  (defvar arrow-keys-map (make-sparse-keymap) "Keymap for arrow keys")
  (define-key esc-map "O" arrow-keys-map)
  (define-key arrow-keys-map "A" 'previous-line)
  (define-key arrow-keys-map "B" 'next-line)
  (define-key arrow-keys-map "C" 'forward-char)
  (define-key arrow-keys-map "D" 'backward-char))

;; (setq paragraph-start ...)
;; (setq paragraph-separate ...)
(setq page-delimiter "^$")

;; socks unstable, use privoxy or socks2http
;; Once converted, route Emacs traffic using the native url-proxy-services variable
;; (setq url-gateway-method 'socks)
;; (setq socks-server '("Default server" "192.168.2.19" 9050 5))
(setq url-proxy-services
      '(("http"  . "192.168.2.19:8118")
        ("https" . "192.168.2.19:8118")))

(provide 'eab-ui)
