;;; eab-config-compile.el --- eab-config compile configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package smart-compile
  :config
  (setq-default smart-compile-check-makefile nil)
  (setq-default smart-compile-check-build-system nil)
  (add-to-list 'smart-compile-alist '(graphviz-dot-mode . "xdot.py %F"))
  (add-to-list 'smart-compile-alist '(python-mode . "python %F"))
  (add-to-list 'smart-compile-alist '(textile-mode . "make push id=%f"))
  (add-to-list 'smart-compile-alist '("\\.xml\\'" . "cd `git rev-parse --show-toplevel` && make push id=%F"))
  (add-to-list 'smart-compile-alist '("\\.jira\\'" . "make push id=%n"))
  (add-to-list 'smart-compile-alist '("\\.html\\'" . "make push id=%n")))

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
             (ansi-color-apply-on-region (point-min) (point-max)))))))

(use-package eab-compile
  :after (ansi-color eab-minimal eab-notify)
  :init
  (defvar eab/explore-map (make-sparse-keymap)
    "Keymap for minimal configuration")
  (general-define-key
   :keymaps 'eab/explore-map
   "t"          'git-timemachine
   "a"          'vc-annotate
   "o"          'org-sort
   "e"          'ediff-buffers
   "c"          'eab/switch-or-clone-indirect-buffer
   "C"          (ilam (call-interactively 'clone-a-lot-goto-prev))
   "f"          'eab/magit-status
   "C-f"        'eab/magit-status
   "C-j"        'eab/magit-amend-modified
   "s"          'sort-lines
   "u"          'untabify
   "C-w"        'whitespace-mode
   "w"          'whitespace-mode)
  (general-define-key
   "C-f"          eab/explore-map
   )
  (global-set-key (kbd "C-d") nil)
  (general-define-key
   :prefix "C-d"
   "q"    'eab/nocommand
   "a"    'eab/compile-helm
   "e"    eab/explore-map
   "d"    'eab/projectile-compile-project
   "C-d"  'eab/projectile-compile-project
   "s"    (ilam (smart-compile 4))
   "S"    (ilam (eab/projectile-compile-project-custom "make push_unstaged"))
   "l"    (ilam (TeX-command "LaTeX"   'TeX-master-file))
   "b"    (ilam (TeX-command "BibTeX"  'TeX-master-file))
   "L"    (ilam (TeX-command "LaTeX"   'TeX-master-file))
   "p"    (ilam (eab/projectile-compile-project-custom "make push_all"))
   "c"    (ilam (eab/projectile-compile-project-custom "make clear"))
   "t"    (ilam (eab/projectile-compile-project-custom "make test"))
   "2"    (ilam (eab/projectile-compile-project-custom "make test2")))
  (defvar eab/compile-map (make-sparse-keymap)
    "Compile keymap.")
  ;; TODO: 
  (setq eab/compile-map (lookup-key global-map (kbd "C-d")))
  :config
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
  (setq compile-command "make ")
  (setq compilation-exit-message-function 'compilation-exit-autoclose)
  (setq compilation-exit-message-function nil)
  (setq compilation-scroll-output 't))

(use-package eab-gr
  :after (eab-compile eab-notify))

(provide 'eab-config-compile)
