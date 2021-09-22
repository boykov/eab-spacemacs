;;; eab-lexical.el ---  -*- lexical-binding: t -*-

;; It doesn't work. Tried to replace ox-extra
(defun eab/ignore-headline (contents backend info)
  "Ignore headlines with tag `ignore'."
  (when (and (org-export-derived-backend-p backend 'latex 'html 'ascii)
             (string-match "\\`.*ignore.*\n"
			   (downcase contents)))
    (replace-match "" nil nil contents)))

;; (add-to-list 'org-export-filter-headline-functions 'eab/ignore-headline)

(defun eab/org-agenda-to-appt ()
  ;; Dangerous!!!  This might remove entries added by `appt-add' manually.
  (org-agenda-to-appt t "TODO"))

;; It slows org-ql-search
;; (add-hook 'org-agenda-mode-hook 'eab/org-agenda-to-appt)

(defun eab/org-clock-get-last-clock-out-time ()
  "Get the last clock-out time for the current headline."
  (save-excursion
    (let ((end (save-excursion (or (outline-next-heading) (point-max)))))
      (when (re-search-forward (concat org-clock-string
				       ".*\\]--\\(\\[[^]]+\\]\\)") end t)
	(org-time-string-to-time (match-string 1))))))

(defun eab/very-old ()
  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (if (and (eab/is-newer "2007-01-01") (not (eab/is-newer "2012-01-01")))
	nil
      next-headline)))

(defun eab/is-newer (date)
  (let ((time (ignore-errors (eab/org-clock-get-last-clock-out-time))))
    (if (and time (> (org-float-time time) (org-float-time (apply 'encode-time (org-parse-time-string date)))))
	't
      nil)))

(defun eab/skip-old ()
  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (if (eab/is-newer "2018-04-01")
	nil
      next-headline)))

(provide 'eab-lexical)