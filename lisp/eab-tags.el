;;; eab-tags.el --- eab tags extension

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: etags-select
;; Status: not intended to be distributed yet

(setq tags-table-list nil)
(setq tags-file-name nil)

(defun eab/etags-find-or-pop ()
  (interactive)
  (if (memq last-command '(eab/etags-find-or-pop))
      (call-interactively 'pop-tag-mark)
    (call-interactively 'etags-select-find-tag-at-point)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
                (push (prin1-to-string x t) tag-names))
              tags-completion-table)
    (etags-select-find (ido-completing-read "Tag: " tag-names))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -regex \"\\(.*el\\\|.*el.gz\\)\" | etags - &"
                          dir-name)))


(defun mpl-create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -name \"*mpl\" | etags - &"
                          dir-name)))

(defun py-create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -name \"*py\" | etags - &"
                          dir-name)))


(defun c-and-fortran-create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -regex \"\\(.*\\.c\\\|.*\\.cpp\\\|.*\\.h\\\|.*\\.hpp\\\|.*\\.F90\\\|.*\\.F\\\|.*\\.f\\\|.*\\.f90\\\|.*\\.for\\\|.*\\.FOR\\|.*py\\)\" | ctags-exuberant -e  -f TAGS -L - &"
                          dir-name)))

(defun c-create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -regex \"\\(.*.c\\\|.*.h\\)\" | etags - &"
                          dir-name)))

(provide 'eab-tags)
