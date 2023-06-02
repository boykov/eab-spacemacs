;;; eab-dired.el --- eab dired extension

;; Copyright (C) 2010-2023 Evgeny Boykov
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
           (add-to-list
            'load-path
            ,(file-name-directory
              (buffer-file-name
               (car (find-function-noselect 'docker-tramp-add-method)))))
           (require 'tramp)
           (add-to-list 'tramp-methods ',eab/sussh)
           (require 'docker-tramp))))))
 :lexical 't)

(dired-async-mode)
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

;; DISABLED ARCHIVE
;; (setq eab/ansible-path ...)
(defun eab/ansible-copy (&optional arg)
  "Copy remote file, e.g. /sudo:root@jupiter:/etc/pbstools.conf to
   respective place (templates/) in jupiter ansible role. C-u for files/"
  (interactive "p")
  (let* ((df (dired-file-name-at-point))
         (file (if df df (buffer-file-name)))
         (local (file-remote-p file 'localname))
         (dir (file-name-directory local))
         (ansdir (if (eq arg 1)
                     (concat eab/ansible-path "templates" dir)
                   (concat eab/ansible-path "files" dir))))
    (make-directory ansdir 't)
    (copy-file file (concat ansdir (file-name-nondirectory local)) 't)))

(defun eab/dired-singularity ()
  "Dired singularity.img at point"
  (interactive)
  (let* ((path (dired-file-name-at-point))
         (local (file-remote-p path 'localname))
         (method (file-remote-p path 'method))
         (host (file-remote-p path 'host))
         (file (file-name-nondirectory local))
         (tramp-methods (append
                         (list
                          (eab/singularity (file-name-directory local)))
                         tramp-methods)))
    (find-file (concat "/" method ":" host "|singularity:" file ":/"))))

(provide 'eab-dired)
