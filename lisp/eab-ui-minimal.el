;;; eab-ui-minimal.el --- 

;; Copyright (C) 2010, 2011, 2012, 2013, 2014, 2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: ansi-color, moz, autorevert, async-eval
;; Status: not intended to be distributed yet

(eab/bind-path custom-file)
(eab/bind-path auto-save-list-file-prefix)
(eab/bind-path backup-directory-alist)
(eab/bind-path auto-save-file-name-transforms)
(eab/bind-path save-place-file)
(eab/bind-path url-configuration-directory)

(require 'autorevert)
(global-auto-revert-mode)
;; TODO remove this fix
(setq auto-revert-use-notify nil)

(require 'async-eval)

(require 'ansi-color)
(setq ansi-color-names-vector [zenburn-bg zenburn-red zenburn-green zenburn-yellow zenburn-blue zenburn-magenta zenburn-cyan zenburn-fg])

(defvar eab/recently-saved-files-list '())

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

(require 'moz)
;; TODO :general: если нет javascript-mode-hook, то можно так
(defadvice javascript-mode (after eab-javascript-mode-after activate)
  (moz-minor-mode 1))

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

(setq enable-recursive-minibuffers t)
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

(setq x-select-enable-clipboard t)
(column-number-mode 1)

(provide 'eab-ui-minimal)
