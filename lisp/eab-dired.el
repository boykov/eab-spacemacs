;;; eab-dired.el --- eab dired extension -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: dired dired-async eab-find-func
;; Status: not intended to be distributed yet

(eab/patch-this-code
 'dired-async-create-files
 `(("(require 'cl-lib) (require 'dired-aux) (require 'dired-x)" .
    ,(let ((print-quoted 't))
       (prin1-to-string
        `(progn
           (require 'cl-lib)
           (require 'dired-aux)
           (require 'dired-x)
           (add-to-list 'load-path
                        (concat user-emacs-directory "private/eab-spacemacs/" "lisp"))
           (require 'eab-minimal)
           (require 'tramp)
           (require 'tramp-sh)
           (require 'tramp-container)
           (require 'eab-patch-tramp)
           (defun eab/tramp-action-sleep (proc _vec)
             (sleep-for 1))
           (setq eab/tramp-regexp "")
           (add-to-list 'tramp-actions-copy-out-of-band
                        '(eab/tramp-regexp eab/tramp-action-sleep))
           (setq tramp-copy-size-limit nil)
           (setq tramp-use-scp-direct-remote-copying 't)
           ;; DONE eab/sussh в async доступна? подставляется через `,
           (add-to-list 'tramp-methods ',eab/sussh)))))
   ("(funcall fn from dest t)" .
    ,(let ((print-quoted 't))
       (prin1-to-string
        `(if (and (not (cdr (tramp-compute-multi-hops (tramp-dissect-file-name dest))))
                  (and (file-remote-p from) (file-remote-p dest)))
             (funcall fn from
                      (concat
                       (file-name-directory dest)
                       "'" (file-name-nondirectory dest)
                       "'") t)
           (funcall fn from dest t))))))
 :lexical 't)

(dired-async-mode 0)
(dired-async--modeline-mode 0)
(setq dired-async-large-file-warning-threshold 1000000000)
(setq dired-dwim-target 't)

(setq dired-listing-switches "-al -h")
(setq eab/dired-group-directories-off t)

(defun eab/dired-group-directories-toggle ()
  (interactive)
  (if eab/dired-group-directories-off
      (progn
        (setq dired-listing-switches "-al --group-directories-first -h")
        (setq eab/dired-group-directories-off nil))
    (progn
      (setq dired-listing-switches "-al -h")
      (setq eab/dired-group-directories-off 't))))

(defun eab/make-list-paths (&optional arg)
  "In dired-mode set last kill-ring value to full paths of marked files like Total Commander. (e.g)
    in dired: file1 (eab/make-list-paths)  -> /home/john/file1 to kill-ring"
  (interactive "p")
  (let ((diredp-filename-separator "\n"))
    (dired-copy-filename-as-kill 0)))

(provide 'eab-dired)
