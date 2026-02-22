;;; eab-dired.el --- eab dired extension

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
           (require 'tramp)
           (require 'tramp-container)
           (add-to-list 'tramp-methods ',eab/sussh))))))
 :lexical 't)

(dired-async-mode 0)
(dired-async--modeline-mode 0)
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
