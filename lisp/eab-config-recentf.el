;;; eab-config-recentf.el --- eab-config recentf configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package recentf
  :config
  (eab/bind-path recentf-save-file)
  (setq recentf-max-saved-items 200)
  (defun eab/recentf-eabpool ()
    (mapcar
     (lambda (x)
       (replace-regexp-in-string
        (concat "^" (regexp-quote "~/")) ""
        (replace-regexp-in-string
         (concat "^" (regexp-quote "~/pnt/lion/")) "" x)))
     (seq-filter
      (lambda (x)
        (file-exists-p x))
      (seq-filter
       (lambda (x)
         (or
          (let ((s "~/git/"))
            (and (length> x (length s)) (string= (substring x 0 (length s)) s)))
          (let ((s "~/pnt/lion/data/"))
            (and (length> x (length s)) (string= (substring x 0 (length s)) s)))))
       (seq-filter
        (lambda (x)
          (let ((s "~/git/org"))
            (and
             (length> x (length s))
             (not (string= (substring x 0 (length s)) s)))))
        recentf-list)))))
  (add-hook 'after-save-hook
            (lambda ()
              (f-write-text
               (string-join
                (eab/recentf-eabpool) "\n")
               'utf-8
               (concat recentf-save-file "-eabpool")))))
