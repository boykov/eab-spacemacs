;;; eab-desktop.el ---  eab desktop extension

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements:
;; Status: ready

(require 'desktop)

(if (or
     (eab/ondaemon (eab/server-P))
     (eab/ondaemon (eab/server-C))
     (eab/ondaemon "serverM"))
    (add-hook 'desktop-save-hook (lambda ()
                                   ;; (eab/wg-update-all-workgroups)
                                   (eab/wg-save eab/workgroups-save)
                                   )))

;; Activate appointments so we get notifications
(when (and (eab/ondaemon (eab/server-P)) (not noninteractive))
  (appt-activate t)
  (run-at-time nil nil (lambda () (message "%s" "hello")))
  (run-at-time 60 3600 (lambda ()
                         (interactive)
                         (if desktop-file-modtime
                             (desktop-save (eab/desktop-dir))))))

;; edit timer-idle-list
(when (eab/ondaemon (eab/server-P))
  (run-with-idle-timer
   15 't (lambda () (interactive) (save-some-buffers 't))))

(when (eab/ondaemon (eab/server-P))
  (run-with-idle-timer
   5 't (lambda () (interactive) (eab/update-query-on-idle 'eab/org-ql-H-query))))

(when (eab/onhost "chronos-emacs")
  (run-with-idle-timer
   100 't (lambda () (interactive) (eab/update-gr-status-on-idle))))


(defun eab/load-desktop ()
  ;; TODO don't setup defadvice wg-switch-to-workgroup before it
  (eab/workgroups-save-file-load)
  (ignore-errors (let ((dir (eab/desktop-dir)))
                   (if (file-exists-p (concat dir ".emacs.desktop"))
                       (desktop-read dir)))))

(defun eab/desktop-ignore-workgroups-mode (desktop-buffer-file-name)
       "Function to ignore workgroups-mode minor modes during restore of buffers"
       nil)

(defun eab/desktop-ignore-undo-tree-mode (desktop-buffer-file-name)
       "Function to ignore undo-tree-mode minor modes during restore of buffers"
       nil)

(defun eab/desktop-ignore-guide-key-mode (desktop-buffer-file-name)
       "Function to ignore guide-key-mode minor modes during restore of buffers"
       nil)

(defun eab/desktop-ignore-auto-complete-mode (desktop-buffer-file-name)
       "Function to ignore auto-complete-mode minor modes during restore of buffers"
       nil)

(defun eab/desktop-ignore-global-auto-revert-mode (desktop-buffer-file-name)
       "Function to ignore global-auto-revert-mode minor modes during restore of buffers"
       nil)

(add-to-list 'desktop-minor-mode-handlers
             '(guide-key-mode . eab/desktop-ignore-guide-key-mode))

(add-to-list 'desktop-minor-mode-handlers
             '(workgroups-mode . eab/desktop-ignore-workgroups-mode))

(add-to-list 'desktop-minor-mode-handlers
             '(global-auto-revert-mode . eab/desktop-ignore-global-auto-revert-mode))

(add-to-list 'desktop-minor-mode-handlers
             '(undo-tree-mode . eab/desktop-ignore-undo-tree-mode))

(add-to-list 'desktop-minor-mode-handlers
             '(undo-tree-mode . eab/desktop-ignore-auto-complete-mode))

(provide 'eab-desktop)
