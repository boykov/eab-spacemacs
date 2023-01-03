;;; eab-hron-lib.el --- 

;; Copyright (C) 2010-2023 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: org-mode
;; Status: not intended to be distributed yet

(add-to-list 'org-publish-project-alist
	     `("html-base"
	       :base-directory ,(concat org-directory "archive/")
	       :exclude "timeline.org"
	       :publishing-directory ,(concat eab/org-publish-directory "archive/")
	       :base-url ,(concat eab/org-publish-directory-file "archive/")
	       :working-directory ,(concat eab/org-publish-directory "archive/")
	       :online-suffix ".html"
	       :working-suffix ".org"
	       ;; :recursive t
	       :with-drawers ("CLOCK")
	       :section_numbers nil
	       :table-of-contents nil
	       :base-extension "org"
	       :publishing-function org-html-publish-to-html
	       :auto-sitemap t                ; Generate sitemap.org automagically...
	       :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
	       :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
	       :style-include-default t
	       :author-info nil
	       :creator-info nil))

(add-to-list 'org-publish-project-alist
	     `("html-clock"
	       :base-directory ,(concat (file-truename org-directory) "clock/")
	       :exclude "timeline.org"
	       :publishing-directory ,(concat eab/org-publish-directory "clock/")
	       :base-url ,(concat eab/org-publish-directory-file "clock/")
	       :working-directory ,(concat eab/org-publish-directory "clock/")
	       :online-suffix ".html"
	       :working-suffix ".org"
	       :recursive t
	       :with-drawers ("CLOCK")
	       :section_numbers nil
	       :table-of-contents nil
	       :base-extension "org"
	       :publishing-function org-html-publish-to-html
	       :auto-sitemap nil                ; Generate sitemap.org automagically...
	       :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
	       :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
	       :style-include-default t
	       :author-info nil
	       :creator-info nil))

(add-to-list 'org-publish-project-alist
	     `("html-gen"
	       :base-directory ,(concat org-directory "gen/")
	       :publishing-directory ,(concat eab/org-publish-directory "gen/")
	       :base-url ,(concat eab/org-publish-directory-file "gen/")
	       :working-directory ,(concat eab/org-publish-directory "gen/")
	       :online-suffix ".html"
	       :working-suffix ".org"
	       ;; :recursive t
	       :with-drawers ("CLOCK")
	       :section_numbers nil
	       :table-of-contents nil
	       :base-extension "org"
	       :publishing-function org-html-publish-to-html
	       :auto-sitemap t                ; Generate sitemap.org automagically...
	       :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
	       :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
	       :style-include-default t
	       :author-info nil
	       :creator-info nil))

;; TODO don't use (org-publish-remove-all-timestamps) after fixing bug
;; in org-mode
;; TODO предварительно закрыть все *.org буферы в server?
(defun eab/batch-publish (&optional fast)
  (progn
    (require 'yasnippet)
    (require 'org)
    (sleep-for 1)
    (if fast
	(eab/gotify "fast publish..." "started" 0)
      (eab/gotify "publish..." "Come in to eab/batch-publish" 0)
      )
    (shell-command (concat "cd " org-directory " && git pull"))
    (sleep-for 1)
    (revert-all-buffers)
    (unless fast
      (eab/send-csum)
      (eab/check-csum-all)
      (eab/send-csum-all))
    (unless fast
      (eab/update-all-dblocks) ;; DONE why doesn't work?
      ;; DONE it seems to hangs up `eab/update-reports-nightly'
      (eab/update-reports-nightly)
      (org-publish-remove-all-timestamps))
    (org-publish-project "html-base" (not fast))
    (org-publish-project "html-clock" (not fast))
    ;; (eab/shell-command "git stash save batch")
    (if fast
	(eab/gotify "...fast finished" "success" 0)
      (eab/gotify "...finished" "success" 0)
      )
    ))

(defun eab/org-sort-time-func ()
  (ignore-errors
    (save-excursion
      (let* ((pend (save-excursion (org-forward-heading-same-level 1) (point)))
	     (end (if (eq (point) pend) (save-excursion (end-of-buffer) (point)) pend)))
	(if (re-search-forward org-ts-regexp-both end t)
	    (org-time-string-to-seconds (match-string 0))
	  (org-float-time '(11861 17628 167611 772000)))))))

;; DONE debug: org-table-get-specials() conflicts with :tags
(defun eab/work-tags () "w1c|w2c|plan|hron")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  _
;; | |__  _ __ ___  _ __
;; | '_ \| '__/ _ \| '_ \
;; | | | | | | (_) | | | |
;; |_| |_|_|  \___/|_| |_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hron

;; See `eab/org-file' in eab-path-org.el

(setq eab/org-file (concat org-directory "clock/current-time.el"))

(if (file-exists-p eab/org-file)
    (load eab/org-file)) ;; (setq eab/hron-current-time ..

(defun eab/hron-current-time-stamp ()
  (format-time-string "%Y-%m-%d %a %H:%M" eab/hron-current-time))

(defun eab/hron-current-time-stamp1 ()
  (format-time-string "%Y-%m-%d %H:%M" eab/hron-current-time))

(defun eab/hron-add-current (h m)
  (let* ((now (org-parse-time-string (eab/hron-current-time-stamp)))
	 (second (nth 0 now))
	 (minute (nth 1 now))
	 (hour (nth 2 now))
	 (day (nth 3 now))
	 (month (nth 4 now))
	 (year (nth 5 now)))
    (format-time-string "%Y-%m-%d %a %H:%M"
			(apply 'encode-time (list second (+ m minute) (+ h hour) day month year)))))

(defun eab/hron-change-current (h m)
  (let ((body
	 `(setq eab/hron-current-time
		',(apply 'encode-time (org-parse-time-string (eab/hron-add-current h m))))))
    (with-temp-file eab/org-file
      (let ((standard-output (current-buffer))) (print body)))
    (funcall `(lambda () ,body))))

(defun eab/hron-set-current (str)
  "Setup `eab/org-file' and `eab/hron-current-time'"
  (let ((body
	 `(setq eab/hron-current-time
		',(apply 'encode-time (org-parse-time-string str)))))
    (with-temp-file eab/org-file
      (let ((standard-output (current-buffer))) (print body)))
    (funcall `(lambda () ,body))))

(defvar eab/hron-todo-history nil "`eab/hron-todo' history alist")

;; DONE похоже, переключение в другой буфер (и обратно), генерирует
;; какие-то маркеры, которые затем нарушают задуманную работу функции
;; org-agenda-bulk-action
;; ...оказалось, это баг в org-mode, см. [[magit:~/.emacs.d/el-get/org-mode/::commit@f0b6465][org-mode.git commit #f0b6465]]
(defun eab/hron-todo-1 (hour minute arg)
  (if (eq major-mode 'org-agenda-mode)
      (progn
	(setq eab/agendah-buffer (current-buffer))
	(setq eab/hron-todo-from-agenda 't)
	(org-agenda-switch-to))
    (setq eab/hron-todo-from-agenda nil))
  (unless (eq arg 2)
    (eab/org-clock (apply 'encode-time
			  (org-parse-time-string
			   (eab/hron-current-time-stamp)))
		   (apply 'encode-time
			  (org-parse-time-string
			   (eab/hron-add-current
			    hour
			    minute)))))
  (cl-case arg
    (4 nil)
    (2 (eab/hron-update-current-time))
    (otherwise (eab/hron-change-current
		hour
		minute)))
  (if eab/hron-todo-from-agenda
      (switch-to-buffer eab/agendah-buffer)))

(defun eab/org-parse-current-time ()
  (apply 'encode-time
	 (org-parse-time-string
	  (substring
	   (shell-command-to-string
	    (concat "cd " org-directory "clock && ../misc/clock.sh -s getCT"))
	   0 -1))))

(defun eab/hron-update-current-time ()
  (eab/hron-set-current
	 (format-time-string "%Y-%m-%d %a %H:%M"
			     (eab/org-parse-current-time))))

(defun eab/hron-todo-setup ()
  (interactive)
  (load eab/org-file nil 't)
  (let* ((prompt (eab/hron-current-time-stamp))
	 (hour (string-to-number
		(read-from-minibuffer
		 (concat prompt " hour ") nil nil nil
		 'eab/hron-todo-history)))
	 (minute (string-to-number
		  (read-from-minibuffer
		   (concat prompt " minute ") nil nil nil
		   'eab/hron-todo-history))))
    (setq eab/hron-todo-bulk-hour hour)
    (setq eab/hron-todo-bulk-minute minute)))

(defun eab/hron-todo-bulk ()
  (eab/hron-todo-1 eab/hron-todo-bulk-hour eab/hron-todo-bulk-minute 4))

(defadvice org-shiftup (after eab/org-shift-update activate)
  (eab/org-shift-update-1))

(defadvice org-shiftdown (after eab/org-shift-update activate)
  (eab/org-shift-update-1))

(defadvice org-shiftmetaup (after eab/org-shift-update activate)
  (eab/org-shift-update-1))

(defadvice org-shiftmetadown (after eab/org-shift-update activate)
  (eab/org-shift-update-1))

(defvar eab/org-shift-timeout 0.3 "Lock current time delay timeout")
(defvar eab/org-shift-counter 0 "Lock current time instances counter")
(defvar eab/org-shift-updating nil "Lock current time updating flag")

(defun eab/org-shift-update-1 ()
  (incf eab/org-shift-counter)
  (unless eab/org-shift-updating
    (setq eab/org-shift-updating 't)
    (run-with-timer eab/org-shift-timeout nil 'eab/org-shift-update-2)))

(defun eab/org-shift-update-2 ()
  (decf eab/org-shift-counter)
  (if (org-at-clock-log-p)
      (if (< eab/org-shift-counter 1)
	  (progn
	    (save-buffer)
	    (eab/hron-update-current-time)
	    (setq eab/org-shift-updating nil))
	(run-with-timer eab/org-shift-timeout nil 'eab/org-shift-update-2))))

(defun eab/hron-todo (&optional arg)
  (interactive "p")
  (set-transient-map
   (let ((map (make-sparse-keymap)))
     (define-key map "u" (ilam
			  (eab/hron-update-current-time)
			  (run-with-timer 0.01 nil `(lambda ()
						      (call-interactively 'eab/hron-todo)))
			  (abort-minibuffers))) map) 't nil)
  (if (eq arg 2)
      (progn
	(setq eab/hron-todo-bulk-hour 0)
	(setq eab/hron-todo-bulk-minute 0))
    (eab/hron-todo-setup))
  (if org-agenda-bulk-marked-entries
      (save-excursion
	(progn
	  (let ((method current-input-method)
		(len (length org-agenda-bulk-marked-entries)))
	    (if (or (= len 2) (= len 1))
		(execute-kbd-macro 'mark-timeline))
	    (set-input-method method))
	  (execute-kbd-macro
	   (read-kbd-macro
	    "B f eab/hron-todo-bulk RET"))
	  (eab/hron-change-current
	   eab/hron-todo-bulk-hour
	   eab/hron-todo-bulk-minute)))
    (eab/hron-todo-1 eab/hron-todo-bulk-hour eab/hron-todo-bulk-minute arg)))

(defun eab/org-clock (&optional start-time at-time)
  "Insert clock string in current buffer"
  (save-excursion
    (org-clock-find-position nil)
    (insert-before-markers "\n")
    (backward-char 1)
    (org-indent-line)
    (when (and (save-excursion
		 (end-of-line 0)
		 (org-in-item-p)))
      (beginning-of-line 1)
      (org-indent-line-to (- (org-get-indentation) 2)))
    (insert org-clock-string " ")
    (org-insert-time-stamp start-time 'with-hm 'inactive)
    (insert "--")
    (org-insert-time-stamp at-time 'with-hm 'inactive)
    (let (s h m)
      (setq s (- (org-float-time at-time)
		 (org-float-time start-time))
	    ss (cl-signum s)
	    s (abs s)
	    h (floor (/ s 3600))
	    s (- s (* 3600 h))
	    m (floor (/ s 60))
	    s (- s (* 60 s)))
      (insert " => " (let ((fh (cond
				((and (= ss -1) (< h 10))
				 "-%1d")
				((and (= ss -1) (> h 9))
				 "-%2d")
				(t
				 "%2d"))))
			       (format (concat fh ":%02d") h m))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;		  _   _	_      	_     _	  _
;;		 | \ | (_) __ _| |__ | |_| |_  	_
;;		 |  \| | |/ _` | '_ \| __| | | | |
;;		 | |\  | | (_| | | | | |_| | |_| |
;;		 |_| \_|_|\__, |_| |_|\__|_|\__, |
;;		       	  |___/	       	    |___/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Nightly

;; TODO при отсеивании "лишних" #+ строк для nightly может так
;; получиться, что уберутся и src блоки и тогда ссылка
;; call_blockname() перестанет работать: нет такого блока
(defun eab/create-nightly ()
  (interactive)
  (shell-command (concat org-directory "misc/create-" "nightly" ".sh"))
  (if (eab/ondaemon (eab/server-C))
      (shell-command (concat org-directory "misc/fix-" "nightly" ".sh")))
  )

(defun eab/create-template (name)
  (let ((fnames
	 (remove-if
	  (lambda (s) (or (string= s "level-0.org")
			  (string= s "sitemap.org")))
	  (mapcar 'file-name-nondirectory
		  (file-expand-wildcards
		   (concat org-directory "clock/*.org"))))))
    (mapcar
     (lambda (x)
       (shell-command
	(concat "grep -v -e \"^\\#\\+\" " org-directory "clock/" x " > " org-directory "gen/" name "/" x )))
	    fnames)
    (shell-command (concat org-directory "misc/create-" name ".sh"))
    (mapcar (lambda (x)
	      (shell-command (concat "rm -f " org-directory "gen/" name "/" x)))
	    fnames))
  )

(defun eab/delete-nightly ()
  (interactive)
  (let ((pattern (concat org-directory "gen/nightly/*")))
    (mapcar
     (lambda (x)
       (let ((buf (get-file-buffer x)))
	 (if buf (kill-buffer buf))))
     (file-expand-wildcards pattern))
    (shell-command (concat "rm " pattern))))

(defun eab/update-all-dblocks ()
  (interactive)
  (mapcar (lambda (x)
	     (find-file x)
	     (org-update-all-dblocks)
	     (save-buffer))
	  (eab/clocktable-scope)))

(defun eab/update-reports-nightly ()
  (interactive)
  (eab/create-template "plot")
  (ignore-errors (kill-buffer "time-reports-nightly.org"))
  (eab/create-nightly)
  (find-file (concat org-directory "gen/time-reports-nightly.org"))
  (revert-all-buffers)
  (org-update-all-dblocks)
  (save-buffer)
  (org-publish-project "html-gen" t)
  (ignore-errors (kill-buffer "time-reports-nightly.org"))
  (eab/delete-nightly))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	       	____
;;	       / ___|___ _   _ _ __ ___
;;	      |	|   / __| | | |	'_ ` _ \
;;	      |	|___\__	\ |_| |	| | | |	|
;;	       \____|___/\__,_|_| |_| |_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Csum

;; See `eab/clocktable-scope' in eab-path-org.el

(defun eab/total-minutes ()
  (* (- (org-time-stamp-to-now "<2007-01-01 Пн. 00:00>")) 1.12 24 60))

(defun csum-percent ()
  (format "%0.2f" (* (/ (org-clock-sum-current-item)
			(eab/total-minutes)) 100)))

(defun csum-file-percent ()
  (format "%0.2f" (* (/ (org-clock-sum)
     (eab/total-minutes)) 100)))

(defun csum ()
  (org-minutes-to-clocksum-string (org-clock-sum-current-item)))

(defun csum-hours ()
  (org-minutes-to-clocksum-string (org-clock-sum-current-item) '(("h") (special . h:mm))))

(defun csum-file ()
  (org-clock-sum)
  (org-minutes-to-clocksum-string org-clock-file-total-minutes))

(defun csum-file-hours ()
  (org-clock-sum)
  (org-minutes-to-clocksum-string org-clock-file-total-minutes '(("h") (special . h:mm))))

(defun csum-year ()
  (eab/forecast-hron (org-minutes-to-clocksum-string (eab/clock-sum-this-year))))

(defun eab/clock-sum-this-year (&optional headline-filter)
  (interactive)
  (let ((range (org-clock-special-range 'thisyear)))
    (org-clock-sum (car range) (cadr range) nil :org-clock-minutes-this-year)
    org-clock-file-total-minutes))

;; TODO why do begining-of-buffer?
(defun eab/org-clock-sum (file)
  (save-excursion
    (find-file file)
    (beginning-of-buffer)
    (org-clock-sum)
    (set-mark-command 4)))

(defun eab/clock-sum-all ()
  "Do `org-clock-sum' on `eab/clocktable-scope' files."
  (interactive)
  (mapcar (lambda (f) (eab/org-clock-sum f)) (eab/clocktable-scope)))

(defun eab/clocktable-scope-1 ()
  (file-expand-wildcards (concat (file-name-as-directory org-directory) "clock/*.org")))

(setq eab/clocktable-scope (eab/clocktable-scope-1))

(defun eab/clocktable-scope () eab/clocktable-scope)

(defun eab/renew-agenda-files-1 ()
  (setq eab/clocktable-scope (eab/clocktable-scope-1))
  (setq org-agenda-files (eab/org-agenda-files)))

(defun eab/renew-agenda-files ()
  (interactive)
  (eab/renew-agenda-files-1)
  (let ((server-use-tcp serverC-use-tcp))
    (server-eval-at (eab/server-C) '(eab/renew-agenda-files-1)))
  )

(defun eab/check-csum-day (&optional date)
  (interactive)
  (dired org-directory)
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf))
  (require 'yasnippet)
  (require 'org)
  (org-mode)
  (insert "* контрольная сумма\n")
  (insert "#+BEGIN: clocktable :step day :tstart \"")
  (insert
   (format-time-string
    (car org-time-stamp-formats)
    (apply 'encode-time (org-parse-time-string  (eab/hron-add-current -24 0)))))
  (insert "\" :tend \"")
  (insert
   (format-time-string
    (car org-time-stamp-formats)
    (apply 'encode-time  (org-parse-time-string (eab/hron-add-current 0 0)))))
  (if (eab/ondaemon (eab/server-C))
      (insert "\" :maxlevel 1 :narrow 80! :link t :scope eab/clocktable-scope\n")
    (insert "\" :maxlevel 1 :narrow 80! :link t :scope (eab/clocktable-scope)\n"))
  (insert "#+END:")
  (previous-line)
  (org-ctrl-c-ctrl-c)
  (eab/extract-csum)
  (kill-buffer (current-buffer))
  (setq 3GG (eab/days-to-minutes (substring eab/hron-csum-day 1 -1)))
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf))
  (org-mode)
  (insert "* контрольная сумма\n")
  (insert "#+BEGIN: clocktable :step day :tstart \"")
  (insert
   (format-time-string
    (car org-time-stamp-formats)
    (apply 'encode-time (org-parse-time-string  (eab/hron-add-current -24 0)))))
  (insert "\" :tend \"")
  (insert
   (format-time-string
    (car org-time-stamp-formats)
    (apply 'encode-time  (org-parse-time-string (eab/hron-add-current 0 0)))))
  (insert (concat "\" :maxlevel 1 :narrow 80! :link t :scope (\"" org-directory "clock/timeline-time-mining.org\" \"" org-directory "clock/timeline-time-arch.org\") \n"))
  (insert "#+END:")
  (previous-line)
  (org-ctrl-c-ctrl-c)
  (eab/extract-csum)
  (kill-buffer (current-buffer))
  (setq 1GG (eab/days-to-minutes (substring eab/hron-csum-day 1 -1)))
  (setq eab/hron-csum-day (concat "*" (org-minutes-to-clocksum-string (- 3GG (* 2 1GG))) "*"))
  (kill-buffer (current-buffer)))

(defun eab/check-csum-all-GREP ()
  (interactive)
  (if (eq (shell-command (concat "cd " (concat org-directory "clock/") " && test-csum.sh")) 0)
      (setq eab/hron-csum-day (concat "*" (eab/get-all-csum) "*"))
    (setq eab/hron-csum-day (concat "*" "ERROR GREP" "*"))))

(defun eab/check-csum-all ()
  (interactive)
  (dired org-directory)
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf))
  (require 'yasnippet)
  (require 'org)
  (org-mode)
  (insert "* контрольная сумма\n")
  (if (eab/ondaemon (eab/server-C))
      (insert "#+BEGIN: clocktable :maxlevel 1 :narrow 80! :scope eab/clocktable-scope\n")
    (insert "#+BEGIN: clocktable :maxlevel 1 :narrow 80! :scope (eab/clocktable-scope)\n"))
  (insert "#+END:")
  (previous-line)
  (org-ctrl-c-ctrl-c)
  (eab/extract-csum)
  (kill-buffer (current-buffer))
  (setq 3GG (eab/days-to-minutes (substring eab/hron-csum-day 1 -1)))
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf))
  (org-mode)
  (insert "* контрольная сумма\n")
  (insert (concat "#+BEGIN: clocktable :maxlevel 1 :narrow 80! :scope (\"" org-directory "clock/timeline-time-mining.org\" \"" org-directory "clock/timeline-time-arch.org\") \n"))
  (insert "#+END:")
  (previous-line)
  (org-ctrl-c-ctrl-c)
  (eab/extract-csum)
  (setq 1GG (eab/days-to-minutes (substring eab/hron-csum-day 1 -1)))
  (setq eab/hron-csum-day (concat "*" (org-minutes-to-clocksum-string (- 3GG (* 2 1GG))) "*"))
  (kill-buffer (current-buffer))
  (kill-buffer (current-buffer)))

(defvar eab/total-csum "")

(defun eab/extract-csum ()
  (interactive)
  (execute-kbd-macro "\M-;ALL *Total\C-m")
  ;; (execute-kbd-macro "\M-;*nil\C-m")
  (org-cycle)
  (setq eab/hron-csum-day (let ((beg (point)))
			    (execute-kbd-macro "\M-l\M-;*\M-j\M-l")
			    (buffer-substring-no-properties beg (point)))))

;; DONE kairos заменить на hostname
(defun eab/send-mail (message)
  )
  ;; (shell-command (concat "echo " message " | mail -s \"" message "\" eab@" system-name)))

(defun eab/send-csum ()
  (eab/check-csum-day)
  (if (string-equal eab/hron-csum-day "*1d 0:00*")
      (eab/send-mail "Совпадает!")
    (eab/send-mail
     (concat
      "Сумма не равна 24 часа failed: calendar 1d"
      ", csum "
      eab/hron-csum-day))
    ))

;; TODO create arbitrary date instead hard-coded 01-01-2007
(defun eab/get-all-csum ()
  (load eab/org-file)
  (let* ((current-encoded
	  (apply 'encode-time  (org-parse-time-string (eab/hron-add-current 0 0))))
	 (year (- (string-to-number (format-time-string "%Y" current-encoded)) 1))
	 (min
	  (number-to-string (string-to-number (format-time-string "%M" current-encoded))))
	 (hour
	  (+
	   (* (apply '+
		     (mapcar (lambda (y)
			       (calendar-day-number `(12 31 ,y)))
			     (number-sequence 2007 year))) 24)
	   0 ;; transfer time: winter/summer
	   ;; see also CLOCK: [2014-10-26 Вс. 00:00]--[2014-10-26 Вс. 05:00] =>  6:00
	   (* (- (string-to-number
		  (cadr
		   (split-string
		    (calendar-day-of-year-string
		     (read (format-time-string "(%m %d %Y)" current-encoded)))))) 1) 24)
	   (string-to-number (format-time-string "%H" current-encoded)))))
    (concat
     (number-to-string (/ hour 24))
     "d "
     (number-to-string (- hour (* (/ hour 24) 24)))
     ":" (if (= (length min) 1) (concat "0" min) min))))

(defun eab/send-csum-all ()
  (if (string-equal
       eab/hron-csum-day
       (concat "*" (eab/get-all-csum) "*"))
      (eab/gotify "ok csum" "All time Совпадает!" 0)
    (eab/gotify "bad csum" "[!]" 5)))

(defun eab/send-csum-all-remote (&optional arg)
  (interactive "P")
  ;; (let ((shell-command-switch "-ic")) (eab/shell-command "nemacs"))
  ;; (sleep-for 1)
  (let ((fname (if arg 'eab/check-csum-all 'eab/check-csum-all-GREP)))
    (funcall
     `(lambda () (async-start
		   (lambda ()
		     (require 'server)
		     (sleep-for 1)
		     (let ((server-use-tcp ,serverC-use-tcp))
		       (server-eval-at ,(eab/server-C) '(progn
							  (shell-command (concat "cd " org-directory " && git pull"))
							  (revert-all-buffers)
							  (,fname)
							  (eab/send-csum-all)
							  )))
		     (kill-emacs))
		   (lambda (result) (message "async result: <%s>" result)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/days-to-minutes (str)
  (if (string-match
       "\\([0-9]*?\\)\\(?:d \\)*\\([0-9]+\\):\\([0-9]+\\)"
       str)
      (let* ((days
	      (string-to-number (match-string 1 str)))
	     (hours
	      (string-to-number (match-string 2 str)))
	     (minutes
	      (string-to-number (match-string 3 str)))
	     (total-minutes
	      (+ minutes
		 (* hours 60)
		 (* days 24 60))))
	total-minutes)))

(defun eab/forecast-hron (str)
  (if (string-match
       "\\([0-9]*?\\)\\(?:d \\)*\\([0-9]+\\):\\([0-9]+\\)"
       str)
      (let* ((total-days
	      (string-to-number (match-string 1 str)))
	     (total-hours
	      (+ (* total-days 24)
		 (string-to-number (match-string 2 str))
		 (/ (string-to-number (match-string 3 str)) 60.0)))
	     (now (org-parse-time-string (eab/hron-current-time-stamp)))
	     (days
	      (-
	       (string-to-number
		(cadr
		 (split-string
		  (calendar-day-of-year-string (list (nth 4 now) (nth 3 now) (nth 5 now))))))
	       1))
	     (hours (/ (nth 2 now) 24.0))
	     (forecast-hours
	      (* (/ 365.0 (+ days hours))
		 total-hours)))
	;; forecast-hours) 0.0))
	(if (>= forecast-hours 24)
	    (let ((forecast-days
		   (truncate (/ forecast-hours 24))))
	      (concat
	       (number-to-string forecast-days)
	       "d "
	       (number-to-string
		(- (/ (truncate (* forecast-hours 100)) 100) (* forecast-days 24)))
	       ":00"))
	  (concat
	   (number-to-string
	    (/ (truncate (* forecast-hours 100)) 100)) ":00"))) 0.0))

;; TODO если извлекать id из столбца Headline, а затем по id получать
;; Custom_BIB, то можно обойтись без отдельного столбца
;; TODO see eab/abbrev-link
(defun eab/paper-link (name)
  (if (and name (not (string= name "")))
      (concat "[[papers:" name "][" name ".pdf]]")
    ""))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'eab-hron-lib)

;;; eab-hron-lib.el ends here
