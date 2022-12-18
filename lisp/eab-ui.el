;;; eab-ui.el --- 

;; Copyright (C) 2010-2022 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: ansi-color, autorevert, async
;; Status: not intended to be distributed yet

(eab/bind-path custom-file)
(eab/bind-path auto-save-list-file-prefix)
(eab/bind-path backup-directory-alist)
(eab/bind-path auto-save-file-name-transforms)
(eab/bind-path save-place-file)
(eab/bind-path url-configuration-directory)
(eab/bind-path source-directory)
(eab/bind-path recentf-save-file)
(eab/bind-path custom-file)

(setq find-function-C-source-directory source-directory)

(require 'autorevert)
(global-auto-revert-mode)
;; TODO with notify my workflow breaks
;; not all org buffers auto reverts, i.e. a bug?
;; (setq auto-revert-use-notify 't)
;; (setq auto-revert-avoid-polling 't)
(setq auto-revert-use-notify nil)
;; (setq auto-revert-remote-files 't) it breaks magit-status buffer

(require 'async)

(require 'ansi-color)
(setq ansi-color-names-vector [zenburn-bg zenburn-red zenburn-green zenburn-yellow zenburn-blue zenburn-magenta zenburn-cyan zenburn-fg])

(defvar eab/recently-saved-files-list '())

(setq ring-bell-function 'ignore)

(add-hook 'after-save-hook
	  (lambda ()
	    (interactive)
	    (add-to-list 'eab/recently-saved-files-list buffer-file-name)))

;; see eab-compile.el
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))

;; TODO why concrete buffer-name only?
(defadvice display-message-or-buffer (before ansi-color activate)
  "Process ANSI color codes in shell output."
  (let ((buf (ad-get-arg 0)))
    (and (bufferp buf)
         (string= (buffer-name buf) "*Shell Command Output*")
         (with-current-buffer buf
           (ansi-color-apply-on-region (point-min) (point-max))))))


(setq disabled-command-function nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq make-backup-files nil)

;; DONE теперь не работают TeX-master "main" в LaTeX-mode
;; уже привык их задавать вручную
(setq enable-local-variables nil)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq frame-title-format `("emacs"
                           ,(if (stringp (daemonp)) (daemonp) "")
                           "@"
                           ,(system-name)
			   " "
                           ;; ": -<{" (:eval (ignore-errors (eab/wg-current-workgroup))) "}>- "
                           (:eval (if (buffer-file-name)
                                      (abbreviate-file-name (buffer-file-name))
                                    "%b"))))

;;(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(xterm-mouse-mode 0)

(setq enable-recursive-minibuffers t)
(setq-default truncate-lines 't)
(setq truncate-partial-width-windows nil)
(setq require-final-newline nil)
(setq mode-require-final-newline nil)
(setq indent-tabs-mode nil)
(add-hook 'conf-colon-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'org-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'sh-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'go-mode-hook (lambda ()
			  (setq indent-tabs-mode nil)
			  (setq-local tab-width 2)
			  ))
(add-hook 'nxml-mode-hook (lambda ()
			    (setq indent-tabs-mode nil)
			    (setq-local nxml-child-indent 4)
			    ))
(add-hook 'markdown-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'ansible-vault-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'js-mode-hook (lambda () (setq indent-tabs-mode nil)))

(setq x-select-enable-clipboard t)
(column-number-mode 1)

(setq system-time-locale "ru_RU.UTF-8")

(unless window-system ;; Only use in tty-sessions.
  (defvar arrow-keys-map (make-sparse-keymap) "Keymap for arrow keys")
  (define-key esc-map "O" arrow-keys-map)
  (define-key arrow-keys-map "A" 'previous-line)
  (define-key arrow-keys-map "B" 'next-line)
  (define-key arrow-keys-map "C" 'forward-char)
  (define-key arrow-keys-map "D" 'backward-char))

(setq browse-url-browser-function (quote browse-url-firefox))
(setq browse-url-firefox-program "/usr/local/bin/browser-remote")

(defun google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
			   (buffer-substring (region-beginning) (region-end))
			 (read-string "Google: "))))))

(provide 'eab-ui)
