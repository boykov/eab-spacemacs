;; require ido, projectile, workgroups

;; (require 'flx-isearch)
(require 'ido) ;; fix boundp ido-file-dir-completion-map, ido-file-completion-map,
(require 'ido-at-point)
;; (ido-at-point-mode) ;; conflicts with minibuffer completion
(require 'flx-ido)

(eab/bind-path ido-save-directory-list-file)

(ido-mode t) ;; fix boundp ido-buffer-completion-map
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-faces nil) ;; disable ido faces to see flx highlights.
(flx-ido-mode 1) ;; see eab/org-insert-link-fast: (let ((ido-mode nil)))
(setq flx-ido-threshold 16000)
(setq ido-max-directory-size 90000)
(setq ido-max-work-directory-list 999)
(setq ido-max-work-file-list 999)
(setq ido-file-extensions-order '(".Rnw" ".tex"))
(setq ido-file-extensions-order '(".py" ".r" ".cpp" ".tex" ".txt"))


(defvar eab/cxb-ido-item 'list "list: only projectile's buffers, buffer: all buffers")

(defun eab/toggle-cxb-ido-item ()
  "Toggle `eab/cxb-ido-item'"
  (interactive)
  (if (eq eab/cxb-ido-item 'list)
      (setq eab/cxb-ido-item 'buffer)
    (setq eab/cxb-ido-item 'list))
  (setq ido-exit 'eab-refresh)
  (exit-minibuffer))

;; DONE сделать cache для projectile-project-buffer-names
;; см. patch projectile-project-buffer-p
(defun eab/cxb ()
  "`ido-switch-buffer' modification with `projectile-project-buffer-names'"
  ;; and `eab/wg-names'
  (interactive)
  (let ((tmp wg-dissociate-buffer-on-kill-buffer))
    (setq wg-dissociate-buffer-on-kill-buffer nil)
    (setq eab/cxb-ido-item
	  ;; (if (ignore-errors (projectile-project-buffer-names))
	  (if (projectile-project-p)
	      'list
	    'buffer))
    ;; prevent run-hook wg-auto-dissociate-buffer-hook for
    ;; with-temp-buffer in expand-file-name
    (eab/cxb-1)
    (setq wg-dissociate-buffer-on-kill-buffer tmp)))

(eab/patch-this-code
 'projectile-project-buffer-p
 "(file-truename default-directory)" "(expand-file-name default-directory)")

(eab/patch-this-code
 'projectile-file-truename
 "(file-truename file-name)" "(expand-file-name file-name)")

(eab/patch-this-code
 'projectile-project-root
 "(file-truename default-directory)" "(expand-file-name default-directory)")

;; TODO добавить в список буферов "projectile-switch-project",
;; аналогично wg-switch-to-workgroup?  Или, может быть, лучше делать
;; больше work groups, добавить для draft, например
(defun eab/cxb-1 (&optional eab-ido-initial)
  (interactive)
  (let* ((ido-context-switch-command nil)
         (ido-directory-nonreadable nil)
         (ido-directory-too-big nil)
         (require-match (confirm-nonexistent-file-or-buffer))
	 (ido-choice-list
	  (ignore-errors
	    (let
		((l (projectile-project-buffer-names)))
	      (append (cdr l) (list (car l))))))
         (buf (ido-read-internal
	       eab/cxb-ido-item
	       (concat (symbol-name eab/cxb-ido-item) ": ")
	       'ido-buffer-history
	       nil
	       require-match eab-ido-initial)))
    (cond
     ((eq ido-exit 'eab-refresh)
      (eab/cxb-1 ido-text))
     ((eq ido-exit 'eab-ido-exit)
      (progn
	(ibuffer)
	(ace-jump-mode 0)))
     ((eq ido-exit 'eab-main)
      (progn
	;; (ido-buffer-internal 'display nil nil nil ido-text nil)
	(let ((bufsw (ido-name (car ido-matches))))
	  ;; (ido-visit-buffer bufsw 'display t)))) ;; DONE добирается до рез-та только со второго раза
	  (switch-to-buffer bufsw))))
     (t
      (if (string= ido-text buf)
	  (helm nil ido-text nil nil nil nil)
	;;        (ido-buffer-internal ido-default-buffer-method nil nil nil ido-text nil)
	(if ido-matches
	    ;; (let ((bufsw (ido-name (car ido-matches))))
	    ;;   (if (remove-if-not (lambda (x) (equal x bufsw)) (eab/wg-names))
	    ;; 	  (progn
	    ;; 	    (eab/wg-switch-to-workgroup bufsw)
	    ;; 	    (eab/wg-switched-msg))
	    ;; 	(progn
	    ;; 	  (eab/wg-update bufsw)
	    ;; 	  (switch-to-buffer bufsw))))
	    (switch-to-buffer (ido-name (car ido-matches)))))))))

(defun ido-set-matches ()
  "Set `ido-matches' to the list of items matching prompt"
  (when ido-rescan
    (setq ido-matches
          (ido-set-matches-1
           (reverse
            ;; (if (eq ido-cur-item 'buffer)
            ;;     (append ido-cur-list (eab/wg-names))
            ;;   ido-cur-list)
	    ido-cur-list)
           (not ido-rotate)) ido-rotate nil)))

(defun eab/ido-main ()
  "Select the buffer or file named by the prompt.
    If no buffer or file exactly matching the prompt exists, maybe create a new one."
  (interactive)
  (setq ido-exit 'eab-main)
  (exit-minibuffer))

(provide 'eab-ido)
