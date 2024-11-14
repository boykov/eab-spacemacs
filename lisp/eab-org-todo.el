(setq org-todo-keywords (quote ((sequence
                                 "TODO(t)" "STARTED(s!)" "|" "DONE(d!/!)")
                                (sequence
                                 "WAITING(w@/!)" "SOMEDAY(S!)" "OPEN(O@)" "|" "CANCELLED(c@/!)")
                                (sequence
                                 "CLEANTODO(C)" "|" "DONE(d!/!)")
                                (type "CLEANTODO" "|" "DONE")
                                (type "NF" "|" "DONE")
                                (type
                                 "PROBLEM(P)" "DIRECTION(D)" "AIM(A)"))))

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
(setq org-html-checkbox-type 'html)

(setq org-html-checkbox-types
      '((unicode
        (on . "&#x2611;")
        (off . "&#x2610;")
        (trans . "&#x2610;"))
       (ascii
        (on . "<code>[X]</code>")
        (off . "<code>[&#xa0;]</code>")
        (trans . "<code>[-]</code>"))
       (html
        (on . "<input type='checkbox' checked='checked' disabled='disabled'/>")
        (off . "<input type='checkbox' disabled='disabled' />")
        (trans . "<input type='checkbox' disabled='disabled' />"))))

(provide 'eab-org-todo)
