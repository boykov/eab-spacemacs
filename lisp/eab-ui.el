;;; eab-ui.el --- 

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: ansi-color, async
;; Status: not intended to be distributed yet

(eab/bind-path custom-file)
(eab/bind-path auto-save-list-file-prefix)
(eab/bind-path backup-directory-alist)
(eab/bind-path auto-save-file-name-transforms)
(eab/bind-path save-place-file)
(eab/bind-path url-configuration-directory)
(eab/bind-path source-directory)
(eab/bind-path custom-file)

(setq find-function-C-source-directory source-directory)

(setq ring-bell-function 'ignore)

(setq disabled-command-function nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq make-backup-files nil)

;; DONE теперь не работают TeX-master "main" в LaTeX-mode
;; уже привык их задавать вручную
(setq enable-local-variables nil)

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
(add-hook 'emacs-lisp-mode-hook (lambda () (setq indent-tabs-mode nil)))


(setq x-select-enable-clipboard t)
(column-number-mode 1)

(setq system-time-locale "ru_RU.utf8")

(unless window-system ;; Only use in tty-sessions.
  (defvar arrow-keys-map (make-sparse-keymap) "Keymap for arrow keys")
  (define-key esc-map "O" arrow-keys-map)
  (define-key arrow-keys-map "A" 'previous-line)
  (define-key arrow-keys-map "B" 'next-line)
  (define-key arrow-keys-map "C" 'forward-char)
  (define-key arrow-keys-map "D" 'backward-char))

(defun eab/helm-org-setup ()
  (progn
    (setq eab/helm-org-goto-flag nil)
    (remove-hook 'org-mode-hook 'eab/org-hook)
    (ergoemacs-fix-arrow-keys global-map)
    (ergoemacs-fix-arrow-keys org-mode-map)
    (let ((helm-full-frame 't))
      (eab/helm-org-agenda-files-headings))
    (if (not eab/helm-org-goto-flag)
        (delete-frame))
    ))


(setq eww-search-prefix "https://duckduckgo.com/html/?q=")

(setq page-delimiter "^$")
;; (setq paragraph-start ...)
;; (setq paragraph-separate ...)

(provide 'eab-ui)
