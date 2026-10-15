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
  (setq recentf-save-file (eab/config (concat (eab/history-dir) "recentf")))
  (setq recentf-max-saved-items 200)
  (recentf-mode 1)
  (defun eab/recentf-filter (sequence)
    (seq-filter
     (lambda (x)
       (file-exists-p x))
     (seq-filter
      (lambda (x)
        (or
         (let ((s "/home/eab/git/"))
           (and (length> x (length s)) (string= (substring x 0 (length s)) s)))
         (let ((s "/home/eab/pnt/lion/git/"))
           (and (length> x (length s)) (string= (substring x 0 (length s)) s)))
         (let ((s "/home/eab/pnt/lion/data/"))
           (and (length> x (length s)) (string= (substring x 0 (length s)) s)))))
      (seq-filter
       (lambda (x)
         (let ((s "/home/eab/git/org"))
           (and
            (length> x (length s))
            (not (string= (substring x 0 (length s)) s)))))
       sequence))))
  (defun eab/recentf-set-flag ()
    (unwind-protect
        (save-window-excursion
          (let ((autosaved-buffers))
            (dolist (buffer (buffer-list))
	      (with-current-buffer buffer
	        (when (buffer-modified-p)
	          (push (buffer-name) autosaved-buffers))))
            (if (eab/recentf-filter
                 (mapcar
                  (lambda (x) (buffer-file-name (get-buffer x)))
                  autosaved-buffers))
                (if (not (file-exists-p "/tmp/user/1000/isync-syncoid"))
                    (progn
                      (async-start
                       `(lambda ()
                          (require 'server)
                          (let ((server-use-tcp 't))
                            (server-eval-at "kairosP" '(call-process-shell-command
                                                        "touch /tmp/user/1000/isync-flag")))))
                      (async-start
                       `(lambda ()
                          (require 'server)
                          (let ((server-use-tcp 't))
                            (server-eval-at "chronosP" '(call-process-shell-command
                                                         "touch /tmp/user/1000/isync-flag"))))))))))))
  (add-hook 'before-save-hook 'eab/recentf-set-flag)
;;  (remove-hook 'before-save-hook 'eab/recentf-set-flag)
  (defun eab/recentf-eabpool ()
    (mapcar
     (lambda (x)
       (replace-regexp-in-string
        (concat "^" (regexp-quote "/home/eab/")) ""
        (replace-regexp-in-string
         (concat "^" (regexp-quote "/home/eab/pnt/lion/")) "" x)))
     (eab/recentf-filter
      (cl-remove-duplicates
       (mapcar
        'file-truename
        recentf-list)
       :test #'string=))))
  (add-hook 'after-save-hook
            (lambda ()
              (f-write-text
               (string-join
                (eab/recentf-eabpool) "\n")
               'utf-8
               (concat recentf-save-file "-eabpool")))))

(provide 'eab-config-recentf)
