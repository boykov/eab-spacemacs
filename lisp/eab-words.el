(require 'edit-list)
(require 'abbrev)
(require 'dictionary)
(setq dictionary-server "localhost")
(eab/bind-path abbrev-file-name)
(if (file-exists-p abbrev-file-name)
    (quietly-read-abbrev-file abbrev-file-name))

(defun eab/edit-list-1 (word)
  (edit-list (intern word)))

(defmacro eab/search-word (funcname name function &optional funargs)
  "Wrapper for search word interface."
  `(defun ,funcname (word)
     (interactive
      (list (read-string (concat ,name " word: ") (current-word))))
     (,function ,@funargs)))

(eab/search-word eab/edit-list-at-point "Edit-list at point" eab/edit-list-1 (word))
(eab/search-word eab/gnugol-search "gnugol search" gnugol (word))
(eab/search-word eab/org-agenda-search "agenda search" org-search-view (nil word))
(eab/search-word eab/twit-search "twitter search" twittering-search (word)) ;; SOMEDAY команда сохраняется в command-history и её можно повторить
(eab/search-word eab/add-eab-abbrev "abbrev save" define-abbrev (eab-abbrev-table word word))
(eab/search-word eab/google-translate "google translate" eab/shell-translate (word))
(eab/search-word eab/google-translate "google translate" eab/shell-translate-remote (word))
(eab/search-word eab/ido-at-point "Ido at point" eab/ido-at-point-1 (word))

;; TODO see eab/paper-link
(defun eab/abbrev-link (abbrev name)
  (if (not (string= name ""))
      (concat "[[" abbrev ":" name "][" name "]]")
    ""))

(defun eab/replace-selection ()
  (interactive)
  (let* ((text (if mark-active
		  (buffer-substring (region-beginning) (region-end))
		 ""))
	 (link (eab/abbrev-link "google" text)))
    (delete-region (region-beginning) (region-end))
    (insert link)))

(defadvice dictionary-search (after eab-dictionary-abbrev activate)
  "Put searched word for dictionary to eab-abbrev-table"
  (let ((word (ad-get-arg 0)))
    (if (not (string-equal word ""))
	(define-abbrev eab-abbrev-table word word))))

(provide 'eab-words)
