;;; eab-bookmark.el --- eab bookmark extension

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: bookmark
;; Status: not intended to be distributed yet

(eab/bind-path bookmark-default-file)
(setq bookmark-watch-bookmark-file 'silent)
(bookmark-maybe-load-default-file)

(setq bookmark-history bookmark-alist)
(setq bookmark-automatically-show-annotations nil)
(setq bookmark-fringe-mark nil)

(general-define-key
 :keymaps 'bookmark-minibuffer-read-name-map
 "C-l" (ilam
        (let ((string
               (with-current-buffer
                   bookmark-current-buffer
                 (eab/replace-in-string "{{{kb_hide}}}" "" (thing-at-point 'line)))))
          (insert (substring string 0 -1)))))

(defun eab/bookmark-set ()
  (interactive)
  (call-interactively 'bookmark-set)
  (let ((bm (car bookmark-alist)))
    (bookmark-set-annotation bm (wg-workgroup-name (wg-current-workgroup t)))
    (setq bookmark-history (append (list bm) bookmark-history)))
  (let ((inhibit-message t))
    (bookmark-save)))

(defun eab/bookmark-delete ()
  (interactive)
  (call-interactively 'bookmark-delete)
  (setq bookmark-history bookmark-alist)
  (let ((inhibit-message t))
    (bookmark-save)))

(defun eab/bookmark-jump ()
  (interactive)
  (progn
    (let* ((dedup (cl-remove-duplicates
                   (mapcar (lambda (x) (if (stringp x) x (car x)))
                           bookmark-history)
                    :test #'string=))
           (swap (if (> (length dedup) 2)
                     (append (list (cadr dedup)) (list (car dedup)) (cddr dedup))
                   dedup)) 
           (bm (ido-completing-read "Ido bookmarks: " swap nil nil nil))
           (wg (bookmark-get-annotation bm)))
      (if wg (wg-switch-to-workgroup wg))
      (bookmark-jump
       bm))))

(provide 'eab-bookmark)
