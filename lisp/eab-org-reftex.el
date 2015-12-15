(eab/bind-path reftex-default-bibliography)

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
	 (reftex-parse-all)
					;add a custom reftex cite format to insert links
	 (reftex-set-cite-format
	  '((?b . "[[bib:%l][%l-bib]]")
	    (?n . "[[contents:%l][%l-contents]]")
	    (?p . "[[papers:%l][%l-paper]]")
	    (?t . "%t")
	    (?h . "* %t\n  :PROPERTIES:\n  :Custom_ID: %l\n  :END:\n  [[papers:%l][%l-paper]]")
	    (?d . "* %t\n  :PROPERTIES:\n  :Custom_ID: %l\n  :END:\n  [[djvu:%l][%l-djvu]]")))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))

(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(defun org-mode-reftex-search ()
  ;;jump to the notes for the paper pointed to at from reftex search
  (interactive)
  (org-open-link-from-string (format "[[contents:%s]]" (reftex-citation t))))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ;; reftex - ref, labels и т.д. в LaTeX
(setq reftex-plug-into-AUCTeX t)

(provide 'eab-org-reftex)
