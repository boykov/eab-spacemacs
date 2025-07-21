;;; eab-desktop.el ---  eab desktop extension

;; Copyright (C) 2010-2025 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements:
;; Status: ready

(require 'desktop)

(if (or (eab/ondaemon (eab/server-P)) (eab/ondaemon (eab/server-C)) (eab/ondaemon "serverM"))
    (add-hook 'desktop-save-hook (lambda ()
                                   ;; (eab/wg-update-all-workgroups)
                                   (eab/wg-save eab/workgroups-save)
                                   )))
;; see also eab-appt.el

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
