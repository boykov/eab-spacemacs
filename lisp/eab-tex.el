;;; eab-tex.el --- eab tex extension

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)
(setq-default TeX-master 't)
(unless (eab/ondaemon (eab/server-P)) (setq-default TeX-master 't))
(setq TeX-open-quote "<<")
(setq TeX-close-quote ">>")
;; (load "preview-latex.el" nil t t)
;; (TeX-global-PDF-mode)

(setq eab/tex-commands-extra (list
                              (list "View" "evince %s.pdf" 'TeX-run-command t nil)
                              (list "BibLaT" "bibtex %s; pdflatex -shell-escape -file-line-error -interaction nonstopmode %t" 'TeX-run-TeX nil t)
                              (list "EAB" "pdflatex -shell-escape -interaction nonstopmode %t ; bibtex %s ; pdflatex -shell-escape -interaction nonstopmode %t ; pdflatex -shell-escape -interaction nonstopmode %t ; cp -f %s.pdf ~/downloads/" 'TeX-run-command nil nil)))

(eval-after-load "tex"
  '(progn (setcdr (assoc "LaTeX" TeX-command-list)
                  '("pdflatex -shell-escape -file-line-error -interaction nonstopmode %t"
                  ;; '("%`%l%(mode) -shell-escape%' %t"
                    TeX-run-TeX
                    ;; TeX-run-command
                    nil (latex-mode doctex-mode) :help "Run LaTeX"))
          (setq TeX-command-list (append eab/tex-commands-extra TeX-command-list))))

(setq TeX-view-program-selection '(((output-dvi style-pstricks)
                                    "dvips and gv")
                                   (output-dvi "xdvi")
                                   (output-pdf "Evince")
                                   ;; (output-pdf "xpdf")
                                   (output-html eab/xdg-open)))

(setq TeX-command-default "EAB")

(provide 'eab-tex)
