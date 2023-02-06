(require 'org-agenda)

(defun eab/replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(setq eab/org-ql-H-query '(and (or (not (tags "noagenda")) (tags "agenda")) (not (tags "neveragenda")) (clocked 600) ))
(setq eab/org-ql-O-query '(and (or (not (tags "noagenda")) (tags "agenda")) (not (tags "neveragenda")) (clocked 6000) (not (clocked 400))))
'((setq eab/org-ql-O-query '(clocked)))
(setq eab/org-ql-W-query '(and (and (or (tags "w1c") (tags "fz")) (or (not (tags "noagenda")) (tags "agenda")) (not (tags "neveragenda"))) (clocked 560)))

(defun eab/org-ql-query-buffer (query)
  (concat "*Org QL View: "
	  (prin1-to-string query) "*"))

(defun eab/org-ql-switch (query)
  (let* ((buffer-name (eab/org-ql-query-buffer query))
	 (window (get-buffer-window buffer-name)))
    (if window
	(select-window window)
      (switch-to-buffer buffer-name))
    (when (or (not (boundp 'eab/org-ql-select-hash))
	      (not (string= eab/org-ql-select-hash (eab/org-ql-select-md5))))
      (eab/org-ql-view-refresh)
      (setq-local eab/org-ql-select-hash (eab/org-ql-select-md5)))))

(defun eab/update-query-on-idle (query)
  (let* ((buffer-name (eab/org-ql-query-buffer query))
	 (window (get-buffer-window (current-buffer))))
    (if (get-buffer-window buffer-name)
	(progn
	  (eab/org-ql-switch query)
	  (if window
	      (select-window window)))
      (save-window-excursion
	(eab/org-ql-switch query)))))

(defun eab/org-ql-select-md5 ()
  (let ((results (org-ql-select
		   org-ql-view-buffers-files
		   org-ql-view-query
                   :action 'element-with-markers
                   :narrow org-ql-view-narrow
                   :sort org-ql-view-sort)))
    (md5 (prin1-to-string results))))

(defun eab/org-ql-search (query)
  (org-ql-search
    org-agenda-files
    (eval query)
    :super-groups
    '((:auto-dir-name))
    :sort 'priority
    :buffer (eab/org-ql-query-buffer query))
  (switch-to-buffer
   (eab/org-ql-query-buffer query))
  (setq-local org-agenda-buffer-name (buffer-name)))

;; TODO instead of org-ql-view-refresh with wrong rename-buffer
(defun eab/org-ql-view-refresh (&optional prompt)
  "Refresh current `org-ql-search' buffer.
If PROMPT is non-nil (interactively, with prefix), prompt to
update search arguments."
  (interactive "P")
  (unless org-ql-view-buffers-files
    (user-error "Not an Org QL View buffer"))
  (let* ((current-string (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
         (old-line (current-line))
         (old-column (current-column))
         (defaults (list org-ql-view-buffers-files
                         org-ql-view-query
                         :sort org-ql-view-sort
                         :narrow org-ql-view-narrow
                         :super-groups org-ql-view-super-groups
                         :title org-ql-view-title))
         (org-ql-view-buffer (current-buffer)))
    (if prompt
        (call-interactively #'org-ql-search)
      (apply #'org-ql-search defaults))
    ;; Now in the results buffer.
    (goto-char (point-min))
    (or (when (search-forward current-string nil t)
          (beginning-of-line))
        (progn
	  (goto-line (if (eq old-column 0) old-line (1- old-line)))
	  (move-to-column old-column)))
    (message "View refreshed")))

(defun eab/bury-buffer ()
  (interactive)
  (let ((replace? (frame-parameter nil 'eab-replace-bury-buffer)))
    (if replace?
	(delete-frame)
      (bury-buffer))))

(defun eab/org-agenda-files ()
  (remove-if
   (lambda (s) (or (string= s (concat org-directory "archive/archive.org"))
		   (string= s (concat org-directory "clock/level-0.org"))
		   ))
   (append
    (file-expand-wildcards (concat org-directory "archive/*.org"))
    (file-expand-wildcards (concat org-directory "clock/*.org")))))

(defun eab/org-insert-link-fast ()
  (interactive)
  (let ((ido-mode nil))
    (execute-kbd-macro (read-kbd-macro "C-c C-l M-i RET RET"))))

(defun eab/short-name-agenda ()
  (let ((old-name (buffer-name)))
    (if (> (length old-name) 20)
	(let ((new-name (concat (substring old-name 0 20) ")*")))
	  ;; (rename-buffer new-name)
	  (setq-local org-agenda-buffer-name old-name)
	  ;;  (setq org-agenda-this-buffer-name new-name)
	  (setq-local mode-line-buffer-identification (propertized-buffer-identification new-name))
	  (setq-local default-directory (expand-file-name (file-name-as-directory org-directory)))
	  ))))

(defun eab/fix-agenda-buffer-name ()
  (setq-local org-agenda-buffer-name (buffer-name)))

;; DONE для C-c s eab/org-agenda-search используется org-search-view
;; т.е. команда org-agenda не вызывается и advice не используется
;; также, если обновить буфер по "g" это не вызывается
(defadvice org-agenda (after eab-advice-agenda activate)
  (eab/short-name-agenda))

;; (defadvice org-ql-search (after eab-org-ql-search activate)
;;   (eab/fix-agenda-buffer-name))
;; (ad-remove-advice 'org-ql-search 'after 'eab-org-ql-search)
;; (ad-deactivate 'org-ql-search)
;; (ad-activate 'org-ql-search)

(defadvice org-search-view (after eab-advice-search-view activate)
  (eab/short-name-agenda))

(defadvice org-agenda-redo (after eab-advice-agenda-redo activate)
  (eab/short-name-agenda))
;; (ad-remove-advice 'org-search-view 'after 'eab-advice-search-view)
;; (ad-deactivate 'org-search-view)

(provide 'eab-org-agenda)
