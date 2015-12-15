(setq org-todo-keywords (quote ((sequence
				 "TODO(t)" "STARTED(s!)" "|" "DONE(d!/!)")
				(sequence
				 "WAITING(w@/!)" "SOMEDAY(S!)" "OPEN(O@)" "|" "CANCELLED(c@/!)")
				(sequence
				 "CLEANTODO(C)" "|" "DONE(d!/!)")
				(type "CLEANTODO" "|" "DONE")
				(type "NF" "|" "DONE")
				(type
				 "NOTCH(N)" "PROBLEM(P)" "DIRECTION(D)" "AIM(A)"))))

(setq org-todo-keyword-faces (quote (("TODO" :foreground "red" :weight bold)
				     ("CLEANTODO" :foreground "red" :weight bold)
				     ("STARTED" :foreground "blue" :weight bold)
				     ("DONE" :foreground "forest green" :weight bold)
				     ("NF" :foreground "forest green" :weight bold)
				     ("WAITING" :foreground "orange" :weight bold)
				     ("SOMEDAY" :foreground "magenta" :weight bold)
				     ("CANCELLED" :foreground "forest green" :weight bold)
				     ("DIRECTION" :foreground "forest green" :weight bold)
				     ("AIM" :foreground "red" :weight bold)
				     ("PROBLEM" :foreground "red" :weight bold)
				     ("NOTCH" :foreground "orange" :weight bold)
				     ("OPEN" :foreground "blue" :weight bold))))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
	      ("WAITING" ("WAITING" . t) ("NEXT"))
	      ("SOMEDAY" ("WAITING" . t))
	      (done ("NEXT") ("WAITING"))
	      ("TODO" ("WAITING") ("CANCELLED") ("NEXT"))
	      ("DONE" ("WAITING") ("CANCELLED") ("NEXT")))))

(setq org-export-latex-todo-keyword-markup '(("DONE" . "\\done{%s}") ("TODO" . "\\todo{%s}")))
(setq org-icalendar-include-todo 'all)
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

(provide 'eab-org-todo)
