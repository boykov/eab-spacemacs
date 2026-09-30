;;; eab-config-helm.el --- eab-config helm configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eab-helm
  :after (eab-org ergoemacs-functions helm)
  :init
  (defvar browse-url-galeon-program nil)
  (defun browse-url-galeon nil)
  (defvar browse-url-netscape-program nil)
  (defun browse-url-netscape nil)
  :config
  (general-define-key
   "M-V"          'helm-show-kill-ring)
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
        (setf addr 'eab/helm-find-file-or-marked))))

(use-package helm-org
  :after (eab-helm eab-org)
  :config
  ;; see also minibuffer-local-map
  (add-to-list 'helm-org-headings-actions '("eab/helm-org-goto-marker" . eab/helm-org-goto-marker))
  (add-to-list 'helm-org-headings-actions '("eab/helm-note-todo" . eab/helm-note-todo))
  (add-to-list 'helm-org-headings-actions '("eab/helm-org-switch-ql" . eab/helm-org-switch-ql))
  (add-to-list 'helm-org-headings-actions '("eab/helm-org-store-link" . eab/helm-org-store-link))
  (add-to-list 'helm-org-headings-actions '("eab/helm-hron-todo" . eab/helm-hron-todo)))

(use-package helm-org-ql
  :after (org-ql)
  :config
  (add-to-list 'helm-org-ql-actions '("eab/hron-todo" . eab/helm-hron-todo)))

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
  (add-to-list 'helm-org-rifle-actions '("eab/note-todo" . eab/rifle-note-todo)))