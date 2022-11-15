;; require abbrev?

(require 'org-protocol)

;; TODO path: org-directory vs archive?
(setq org-protocol-project-alist
      `((,eab/org-publish-directory-file
         :online-suffix ".html"
         :working-suffix ".org"
         :base-url ,eab/org-publish-directory-file
         :working-directory ,(expand-file-name org-directory))))

(setq org-protocol-protocol-alist
      '(("eab-open-link"
         :protocol "open-link"
         :function eab-protocol-open-link)
	("eab-save-abbrev"
         :protocol "save-abbrev"
         :function eab-protocol-save-abbrev)
	))

(defun eab-protocol-open-link (link)
  (ignore-errors (eab/wg-switch-to-workgroup ":ag:"))
  (org-open-link-from-string link))

(defun eab-protocol-save-abbrev (word)
  (let ((unhex-word (org-link-unescape word)))
    (define-abbrev eab-abbrev-table unhex-word unhex-word))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/open-heading-browser ()
  (interactive)
  (let* ((prop (org-entry-properties))
	 (path (if prop (cl-find-if (lambda (x) (if (string= "FILE" (car x)) 't nil)) prop)
		 (cons 'bogus (buffer-file-name))))
	 (id (cl-find-if (lambda (x) (if (string= "ID" (car x)) 't nil)) (org-entry-properties)))
	 (prefix (replace-regexp-in-string "eab\/git\/org" "eab/pub/org" (cdr path))))
    (browse-url
     (concat "file://" (replace-regexp-in-string "\.org$" ".html" prefix) "#ID-" (cdr id)))))

(defun eab/open-heading-browser ()
  (interactive)
  (let* ((fname (file-name-nondirectory (buffer-file-name)))
	 (id (cl-find-if (lambda (x) (if (string= "ID" (car x)) 't nil)) (org-entry-properties nil 'standard))))
    (browse-url
     (concat "http://localhost:3001/org/mock/" (replace-regexp-in-string "\.org$" ".html" fname) "#ID-" (cdr id)))))

(defun eab/open-corresponding-html ()
  (interactive)
  (let ((path (replace-regexp-in-string (file-truename org-directory) eab/org-publish-directory (buffer-file-name))))
    (find-file (replace-regexp-in-string "\.org$" ".html" path))))

(defun eab/browse-paper ()
  (interactive)
  (browse-url
   (concat
    "https://share.homew.keenetic.pro/papers/"
    (org-entry-get nil "Custom_BIB") ".pdf")))

(defun eab/browse-paper-1 (word)
  (browse-url
   (concat
    "https://share.homew.keenetic.pro/papers/"
    word ".pdf")))

(provide 'eab-org-protocol)
