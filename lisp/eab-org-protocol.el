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
	("eab-send-string"
         :protocol "send-string"
         :function eab-protocol-send-string)))

(defun eab-protocol-open-link (link)
  (ignore-errors (eab/wg-switch-to-workgroup ":ag:"))
  (org-open-link-from-string link))

(defun eab-protocol-save-abbrev (word)
  (let ((unhex-word (org-link-unescape word)))
    (define-abbrev eab-abbrev-table unhex-word unhex-word))
  nil)

(defun eab-protocol-send-string (string)
  (setq eab-send-string (org-link-unescape string))
  (shell-command "wmctrl -a \"minibuffer\"")
  (save-window-excursion
    (select-frame eab-minibuffer-frame)
    (call-interactively 'eab/ido-firefox-urls))
  (eab/ido-firefox)
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/firefox-get-urls (arg)
  (split-string (if arg
      (car (split-string eab-send-string "8a3444a"))
      (cadr (split-string eab-send-string "8a3444a"))) "7e2197b," t))

(defun eab/ido-firefox-urls ()
  (interactive)
  (let* ((cand
	  (ido-completing-read "Firefox Urls: " (cdr (eab/firefox-get-urls 't))))
	 (num
	  (cl-position-if
	   (lambda (x) (if (string= cand x) 't nil))
	   (eab/firefox-get-urls nil))))
    (with-temp-buffer
      (insert
       (concat
	"gBrowser.mTabContainer.selectedIndex = " (number-to-string num) ";"))
	(moz-send-region (point-min) (point-max)))))

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

(defun eab/open-corresponding-html ()
  (interactive)
  (let ((path (replace-regexp-in-string "eab\/git\/org" "eab/pub/org" (buffer-file-name))))
    (find-file (replace-regexp-in-string "\.org$" ".html" path))))

(provide 'eab-org-protocol)
