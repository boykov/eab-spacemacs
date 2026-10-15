;; require abbrev?

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

(defun eab-protocol-open-link (id)
  (ignore-errors (eab/wg-switch-to-workgroup ":clock:"))
  (org-open-link-from-string
   (concat "[[id:"
           (plist-get (org-protocol-parse-parameters id nil '(:id)) :id) "]]")))

(defun eab-protocol-save-abbrev (word)
  (let ((unhex-word (org-link-unescape word)))
    (define-abbrev eab-abbrev-table unhex-word unhex-word))
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/open-heading-browser ()
  (interactive)
  (let* ((fname (file-name-nondirectory (buffer-file-name (buffer-base-buffer))))
         (prop (org-entry-properties))
         (path (if prop
                   (cl-find-if
                    (lambda (x) (if (string= "FILE" (car x)) 't nil)) prop)
                 (cons 'bogus (buffer-file-name (buffer-base-buffer)))))
         (id (cl-find-if
              (lambda (x)
                (if (string= "ID" (car x)) 't nil))
              (org-entry-properties nil 'standard)))
         (prefix (replace-regexp-in-string
                  "eab\/git\/org-chronos" "eab/pub/org" (cdr path))))
    (if current-prefix-arg
        (eab/browse-url0
         (concat "file://" (replace-regexp-in-string
                            "\.org$" ".html" prefix) "#ID-" (cdr id)))
      (eab/browse-url0
       (concat "https://my.eab.su/org/clock/"
               (replace-regexp-in-string "\.org$" ".html" fname) "#ID-" (cdr id))))))

(defun eab/open-corresponding-html ()
  (interactive)
  (let ((path (replace-regexp-in-string
               (file-truename org-directory)
               eab/org-publish-directory
               (buffer-file-name))))
    (find-file (replace-regexp-in-string "\.org$" ".html" path))))

(defun eab/browse-paper ()
  (interactive)
  (let ((name (org-entry-get nil "Custom_BIB")))
    (if current-prefix-arg
        (browse-url
         (concat
          "https://share.eab.su/papers/" name ".pdf"))
      (eaf-open (eab/papers-eaf name)))))

(defun eab/browse-paper-1 (word)
  (browse-url
   (concat
    "https://share.eab.su/papers/"
    word ".pdf")))

(eab/search-word eab/browse-paper-at-point "browse paper" eab/browse-paper-1 (word))

(provide 'eab-org-protocol)
