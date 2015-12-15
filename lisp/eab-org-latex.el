(setq org-latex-pdf-process '("pdflatex -shell-escape -interaction nonstopmode %b" "bibtex %b" "pdflatex -shell-escape -interaction nonstopmode %b" "pdflatex -shell-escape -interaction nonstopmode %b"))

(setq org-latex-listings 'listings)

;; TODO conflicts with org-format-latex-header
;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; also wasysym from org-latex-default-packages-alist
;; conflicts with amsmath in org-format-latex-header
;; [usenames]{color} conflicts with color
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))

(setq org-format-latex-options '(
				 :foreground default
					     :background default
					     :scale 1.5
					     :html-foreground "Black"
					     :html-background "Transparent"
					     :html-scale 1.0
					     :matchers
					     ("begin" "$1" "$" "$$" "\\(" "\\[")))

;; using in org-preview-latex-fragment
;; see eab-path.el
(setq org-format-latex-header "\\documentclass{article}
  [PACKAGES]
  [DEFAULT-PACKAGES]
  \\usepackage{eab-header}")

;; see org-export-latex-default-packages-alist
;; [NO-DEFAULT-PACKAGES] - it's a macro
(add-to-list 'org-latex-classes
      '("article"
	 "\\documentclass[11pt]{article}
         [NO-DEFAULT-PACKAGES]
         \\usepackage{eab-article}
         [PACKAGES]
         \\usepackage{eab-append}"
	 ("\\section{%s}" . "\\section*{%s}")
	 ("\\subsection{%s}" . "\\subsection*{%s}")
	 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	 ("\\paragraph{%s}" . "\\paragraph*{%s}")
	 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
	 ))

(provide 'eab-org-latex)
