;;; eab-outline.el --- eab outline extension

;; Copyright (C) 2010-2023 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: eab-minimal
;; Status: ready

(defvar eab/outline-state 'all)

(eab/add-hook textile-mode-hook eab/textile-outline-hook
  (setq-local outline-regexp "^\\(h[0-9]+\\)")
  (setq-local outline-heading-alist '(("h1" . 2) ("h2" . 3) ("h3" . 4) ("h4" . 5) ("h5" . 6))))

(eab/add-hook ssh-config-mode-hook eab/ssh-config-outline-hook
  (setq-local outline-regexp "##+")
  (setq-local outline-heading-alist '(("##" . 2) ("###" . 3))))

(eab/add-hook yaml-mode-hook eab/yaml-outline-hook
  (setq-local outline-regexp "##+")
  (setq-local outline-heading-alist '(("##" . 2) ("###" . 3))))

(eab/add-hook groovy-mode-hook eab/groovy-outline-hook
  (setq-local outline-regexp "///+")
  (setq-local outline-heading-alist '(("///" . 2) ("////" . 3))))

(defun eab/outline-toggle-children ()
  "Show or hide the current subtree depending on its current state."
  (interactive)
  (cond
   ((yas--templates-for-key-at-point) (call-interactively 'yas-expand))
   ((outline-on-heading-p)
    (call-interactively 'outline-toggle-children))))

(defun eab/outline-toggle-all ()
  "Show or hide the whole buffer depending on its current state."
  (interactive)
  (save-excursion
    (outline-back-to-heading)
    (cond
     ((eq eab/outline-state 'all)
      (progn
        (setq-local eab/outline-state '99)
        (outline-hide-sublevels 99)))
     ((eq eab/outline-state '99)
      (progn
        (setq-local eab/outline-state 'interactive)
        (call-interactively 'outline-hide-sublevels)))
     ((eq eab/outline-state 'interactive)
      (progn
        (setq-local eab/outline-state 'all)
        (call-interactively 'outline-show-all))))))

(provide 'eab-outline)
