;;; eab-words.el ---  eab words extension

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: edit-list abbrev dictionary
;; Status: ready

(require 'abbrev)

(defmacro eab/search-word (funcname name function &optional funargs)
  "Wrapper for search word interface."
  `(defun ,funcname (&optional arg)
     (interactive "P")
     (let ((word (if arg
                     (read-string (concat ,name " word: ") (current-word))
                   (current-word))))
       (,function ,@funargs))))

(eab/search-word eab/edit-list-at-point "Edit-list at point" eab/edit-list-1 (word))
(eab/search-word eab/browse-paper-at-point "browse paper" eab/browse-paper-1 (word))
(eab/search-word eab/org-agenda-search "agenda search" org-search-view (nil word))
;; (eab/search-word eab/org-agenda-search
;;               "agenda ql search" org-ql-search
;;               (org-agenda-files '(and (clocked 560) (not (tags "noagenda"))) :super-groups '((:auto-dir-name)) :sort 'priority))
(eab/search-word eab/add-eab-abbrev "abbrev save" define-abbrev (eab-abbrev-table word word))
(eab/search-word eab/google-translate "google translate" eab/shell-translate (word))
(eab/search-word eab/google-translate "google translate" eab/shell-translate-remote (word))
(eab/search-word eab/ido-at-point "Ido at point" eab/ido-at-point-1 (word))

;; TODO (ffap-guesser) curl --remote-name for sync-redmine link inside json

;; TODO see eab/paper-link
(defun eab/abbrev-link (abbrev name)
  (if (string= name "")
      ""
    (concat "[[" abbrev ":" name "][" name "]]")))

(defun eab/replace-selection ()
  (interactive)
  (let* ((text (if mark-active
                  (buffer-substring (region-beginning) (region-end))
                 ""))
         (link (eab/abbrev-link "google" text)))
    (delete-region (region-beginning) (region-end))
    (insert link)))

(provide 'eab-words)
