(require 'org-agenda)

(defun eab/replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(setq eab/org-ql-H-query '(and (or (not (tags "noagenda")) (tags "agenda")) (clocked 560) ))
(setq eab/org-ql-W-query '(and (and (or (tags "w1c") (tags "fz")) (or (not (tags "noagenda")) (tags "agenda"))) (clocked 560)))


(setq org-sort-agenda-notime-is-late nil)

(setq org-agenda-sorting-strategy
      '((agenda habit-down time-up priority-down category-keep)
	(todo timestamp-down)
	(tags priority-down category-keep)
	(search category-keep)))

(defun eab/org-agenda-files ()
  (remove-if
   (lambda (s) (or (string= s (concat org-directory "archive/archive.org"))
		   (string= s (concat org-directory "clock/level-0.org"))
		   (string= s (concat org-directory "clock/common.org"))
		   ;; (member s (file-expand-wildcards (concat org-directory "clock/*arch.org")))
		   ))
   (append
    (file-expand-wildcards (concat org-directory "archive/*.org"))
    (file-expand-wildcards (concat org-directory "clock/*.org")))))

;; see file:eab-hron-lib.el
(setq org-agenda-files (eab/org-agenda-files))

(setq org-agenda-custom-commands
      (quote (("S" "Started Tasks" todo "STARTED"
	       ((org-agenda-todo-ignore-scheduled nil)
		(org-agenda-todo-ignore-deadlines nil)
		(org-agenda-todo-ignore-with-date nil)))
	      ("w" "Tasks waiting on something" tags "WAITING/!"
	       ((org-use-tag-inheritance nil)))
	      ("r" "Refile New Notes and Tasks" tags "LEVEL=1+REFILE"
	       ((org-agenda-todo-ignore-with-date nil)
		(org-agenda-todo-ignore-deadlines nil)
		(org-agenda-todo-ignore-scheduled nil)))
	      ("n" "Notes" tags "NOTE" nil)
	      ("d" "All todo entries" tags-todo "/!-DIRECTION" nil)
	      ("g" "Clean agenda" tags-todo "clean" nil)
	      ;; ("H" "Chrono" tags "LEVEL<4+repeat-norepeat+CLOCK>=\"<-1y>\"|LEVEL<3+repeat" nil)
	      ("F" "frequency" tags "+CLOCKSUM={[3-9]d.*}+CLOCK>=\"<-1m>\"-ARCHIVE-noagenda" nil)
	      ("Q" "all" tags "+CLOCKSUM<=\"0:25\"+CLOCKSUM>\"0:05\"-ARCHIVE-noagenda" nil)
	      ("O" "eab/very-old" tags "-ARCHIVE-noagenda-noexport" ((org-agenda-skip-function 'eab/very-old)))
	      ("H" "Chrono" tags "-ARCHIVE-noagenda" ((org-agenda-skip-function 'eab/skip-old)))
	      ;; ("H" "Chrono ql"
	      ;;  ((org-ql-block '(and (clocked 560) (not (tags "noagenda")))
	      ;; 		      ((org-ql-block-header "Chrono ql")))))
	      ("W" "Work" tags-todo "+w1c")
	      ("M" "Work" tags "+media" ((org-agenda-skip-function 'eab/skip-old)))
	      ("D" "Day" tags "+CLOCK>=\"<-2d>\"+CLOCK<=\"<-1d>\"-ARCHIVE-noagenda" nil)
	      ("J" "Chrono" tags "LEVEL<5+CLOCK>=\"<-5d>\"-ARCHIVE-noagenda" nil)
	      ("f" "Filter" tags-todo "-STYLE=\"habit\"-СЛОН-exclude-DONE/-SOMEDAY" nil)
	      ("N" "Next" tags "NEXT-WAITING-CANCELLED/!" nil)
	      ("p" "Projects" tags-todo "LEVEL=1" nil)
	      ("A" "Tasks to be Archived" tags "LEVEL=2/DONE|CANCELLED" nil)
	      ("h" "Habits" tags "STYLE=\"habit\""
	       ((org-agenda-todo-ignore-with-date nil)
		(org-agenda-todo-ignore-scheduled nil)
		(org-agenda-todo-ignore-deadlines nil)))
	      ("c" . "Priority views")
	      ("ca" "#A" todo ""
	       ((org-agenda-entry-types '(:scheduled))
		(org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp
								     "\\[#A\\]"))))
	      ("cb" "#B" agenda ""
	       ((org-agenda-entry-types '(:scheduled))
		(org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp
								     "\\[#B\\]"))))
	      ("cc" "#C" agenda ""
	       ((org-agenda-entry-types '(:scheduled))
		(org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp
								     "\\[#C\\]"))))
	      )))

(setq eab/agenda-H-command (concat "*Org Agenda(H:" (cadddr (assoc "H" org-agenda-custom-commands)) ")*"))
(setq eab/agenda-W-command (concat "*Org Agenda(W:" (cadddr (assoc "W" org-agenda-custom-commands)) ")*"))
(setq eab/agenda-M-command (concat "*Org Agenda(M:" (cadddr (assoc "M" org-agenda-custom-commands)) ")*"))

(setq eab/agenda-a-command "*Org Agenda(a)*")

(defun eab/org-insert-link-fast ()
  (interactive)
  (let ((ido-mode nil))
    (execute-kbd-macro (read-kbd-macro "C-c C-l M-i RET RET"))))

(defun eab/save-W ()
  (interactive)
  (save-window-excursion
    (switch-to-buffer (get-buffer eab/agenda-W-command))
    (execute-kbd-macro
     (read-kbd-macro
      "C-x C-w agW.org"))
    (find-file "agW.org")
    (beginning-of-buffer)
    (insert
     "#+TITLE: Планирование
#+SETUPFILE: level-0.org

")
    (save-buffer)
    (ergoemacs-close-current-buffer)))

(add-hook 'org-agenda-mode-hook (lambda () (hl-line-mode 1)))

(setq org-agenda-hide-tags-regexp nil)
(org-toggle-sticky-agenda t)

(setq org-mobile-agendas '("S" "g" "a"))

(setq org-agenda-include-diary nil)
(setq org-agenda-archives-mode 't)
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))
(setq org-agenda-clockreport-parameter-plist (quote (:link nil :maxlevel 2)))

(defun eab/kill-buffer (name)
  (let ((buf (get-buffer name)))
    (if buf
	(kill-buffer buf))))

(defun eab/renew-agenda ()
  (interactive)
  (eab/clock-sum-all)
  (eab/kill-buffer eab/agenda-H-command)
  (execute-kbd-macro (read-kbd-macro "C-c a H"))
  (setq-local default-directory (expand-file-name (file-name-as-directory org-directory)))
  (eab/kill-buffer eab/agenda-W-command)
  (execute-kbd-macro (read-kbd-macro "C-c a W"))
  (setq-local default-directory (expand-file-name (file-name-as-directory org-directory)))
  ;; TODO emacs 25.1.50.2 problem with listp org-link
  (eab/kill-buffer eab/agenda-a-command)
  (execute-kbd-macro (read-kbd-macro "C-c a a"))
  (setq-local default-directory (expand-file-name (file-name-as-directory org-directory)))
  (eab/kill-buffer eab/agenda-M-command)
  (execute-kbd-macro (read-kbd-macro "C-c a M"))
  (setq-local default-directory (expand-file-name (file-name-as-directory org-directory))))

(defun eab/short-name-agenda ()
  (let ((old-name (buffer-name)))
    (if (> (length old-name) 20)
	(let ((new-name (concat (substring old-name 0 20) ")*")))
	  ;; (rename-buffer new-name)
	  (setq-local org-agenda-buffer-name old-name)
	  ;;  (setq org-agenda-this-buffer-name new-name)
	  (setq-local mode-line-buffer-identification (propertized-buffer-identification new-name))
	  (setq-local default-directory (expand-file-name (file-name-as-directory org-directory)))
	  ))))

(defun eab/fix-agenda-buffer-name ()
  (setq-local org-agenda-buffer-name (buffer-name)))

;; DONE для C-c s eab/org-agenda-search используется org-search-view
;; т.е. команда org-agenda не вызывается и advice не используется
;; также, если обновить буфер по "g" это не вызывается
(defadvice org-agenda (after eab-advice-agenda activate)
  (eab/short-name-agenda))

(defadvice org-ql-search (after eab-org-ql-search activate)
  (eab/fix-agenda-buffer-name))
;; (ad-remove-advice 'org-ql-search 'after 'eab-org-ql-search)
;; (ad-deactivate 'org-ql-search)
;; (ad-activate 'org-ql-search)

(defadvice org-search-view (after eab-advice-search-view activate)
  (eab/short-name-agenda))

(defadvice org-agenda-redo (after eab-advice-agenda-redo activate)
  (eab/short-name-agenda))
;; (ad-remove-advice 'org-search-view 'after 'eab-advice-search-view)
;; (ad-deactivate 'org-search-view)

(provide 'eab-org-agenda)
