(require 'org-src)

(defun eab/tangle-init ()
  "Function is used in init.org, testbedhub"
  (org-babel-tangle)
  (ergoemacs-close-current-buffer))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((clojure . t)
   (fortran . t)
   (makefile . t)
   (R . t) ;; DONE manual recompile ob-R.el in org-plus-contrib
   (python . t)
   (ruby . t)
   (dot . t)
   (latex . t)
   (ditaa . t)
   (gnuplot . t)
   (screen . t)
   (emacs-lisp . t)
   (shell . t)
   ))

(add-to-list 'org-babel-default-header-args:dot '(:cmdline . "-Tpng"))

(setq org-confirm-babel-evaluate nil)

(setq org-edit-src-content-indentation 0)
(setq org-src-preserve-indentation 't)
(setq org-src-window-setup 'current-window)
(setq org-src-fontify-natively 't)
(setq org-src-lang-modes '(
			   ("screen" . sh)
			   ("ocaml" . tuareg)
			   ("elisp" . emacs-lisp)
			   ("lisp" . lisp)
			   ("ditaa" . artist)
			   ("asymptote" . asy)
			   ("cl" . lisp)
			   ("dot" . graphviz-dot)))

(provide 'eab-org-src-babel)
