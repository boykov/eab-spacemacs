;;; eab-hron-lib.el --- 

;; Copyright (C) 2010-2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: org-mode, sauron
;; Status: not intended to be distributed yet

;; TODO don't use (org-publish-remove-all-timestamps) after fixing bug
;; in org-mode
;; TODO предварительно закрыть все *.org буферы в server?
(defun eab/batch-publish ()
  (progn
    (server-eval-at "server" '(sauron-add-event 'eab 3 "Come in to eab/batch-publish"))
    (eab/update-all-dblocks) ;; DONE why doesn't work?
    ;; DONE it seems to hangs up `eab/update-reports-nightly'
    (eab/update-reports-nightly)
    (org-publish-remove-all-timestamps)
    (org-publish-project "html" t)
    (org-publish-project "html-clock" t)
    (eab/send-csum)
    (eab/check-csum-all)
    (eab/send-csum-all)
    ;; (org-mobile-push)
    (eab/shell-command "git stash save batch")
    (sleep-for 1)
    (eab/update-agenda)))
    ;; (delete-frame nil 'force)))

;; DONE get-buffer по имени буфера: нарушение SPOT!
(defun eab/update-agenda ()
  (interactive)
  (async-eval
    (lambda (result) (message "async result: <%s>" result))
  (progn
    (require 'server)
    (server-eval-at
     "server"
     '(progn
	(auto-revert-buffers)
	(eab/renew-agenda)
	)))))

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
    (with-temp-file eab/org-file (let ((standard-output (current-buffer))) (print body)))
    (funcall `(lambda () ,body))))

(defun eab/hron-set-current (str)
  "Setup `eab/org-file' and `eab/hron-current-time'"
  (let ((body
	 `(setq eab/hron-current-time
		',(apply 'encode-time (org-parse-time-string str)))))
    (with-temp-file eab/org-file (let ((standard-output (current-buffer))) (print body)))
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
  (eab/org-clock (apply 'encode-time
			(org-parse-time-string
			 (eab/hron-current-time-stamp)))
		 (apply 'encode-time
			(org-parse-time-string
			 (eab/hron-add-current
			  hour
			  minute))))
  (if (eq arg 4)
	nil
      (eab/hron-change-current
       hour
       minute))
  (if eab/hron-todo-from-agenda
      (switch-to-buffer eab/agendah-buffer)))

(defun eab/hron-todo-setup ()
  (interactive)
  (load eab/org-file nil 't)
  (let* ((prompt (eab/hron-current-time-stamp))
	 (hour (string-to-int
		(read-from-minibuffer
		 (concat prompt " hour ") nil nil nil
		 'eab/hron-todo-history)))
	 (minute (string-to-int
		  (read-from-minibuffer
		   (concat prompt " minute ") nil nil nil
		   'eab/hron-todo-history))))
    (setq eab/hron-todo-bulk-hour hour)
    (setq eab/hron-todo-bulk-minute minute)))

(defun eab/hron-todo-bulk ()
  (eab/hron-todo-1 eab/hron-todo-bulk-hour eab/hron-todo-bulk-minute 4))

(defun eab/hron-todo (&optional arg)
  (interactive "p")
  (eab/hron-todo-setup)
  (if org-agenda-bulk-marked-entries
      (progn
	(execute-kbd-macro
	 (read-kbd-macro
	  "B f eab/hron-todo-bulk RET"))
	(eab/hron-change-current
	 eab/hron-todo-bulk-hour
	 eab/hron-todo-bulk-minute))
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
	    h (floor (/ s 3600))
	    s (- s (* 3600 h))
	    m (floor (/ s 60))
	    s (- s (* 60 s)))
      (insert " => " (format "%2d:%02d" h m)))))

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

;; See `eab/nightly-scope' in eab-path-org.el

(setq eab/nightly-scope
      (mapcar (lambda (x)
		(concat org-directory "gen/nightly/" x))
	      '("hron.org"
		"improve.org"
		"media.org"
		"write.org"
		"work.org"
		"persons.org"
		"budget.org"
		"health.org"
		"self.org")))

(defun eab/nightly-scope () eab/nightly-scope)

;; TODO при отсеивании "лишних" #+ строк для nightly может так
;; получиться, что уберутся и src блоки и тогда ссылка
;; call_blockname() перестанет работать: нет такого блока
(defun eab/create-nightly ()
  (interactive)
  (eab/create-template "nightly")
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
    (shell-command (concat org-directory "create-" name ".sh"))
    (mapcar (lambda (x)
	      (shell-command (concat "rm -f " org-directory "gen/" name "/" x)))
	    fnames))
  )

(defun eab/delete-nightly ()
  (interactive)
  (mapcar
   (lambda (x)
     (let ((buf (get-file-buffer x)))
       (if buf (kill-buffer buf))))
     (eab/nightly-scope))
  (shell-command (concat "rm " org-directory "gen/nightly/*")))

(defun eab/update-all-dblocks ()
  (interactive)
  (mapcar (lambda (x)
	     (find-file x)
	     (org-update-all-dblocks)
	     (save-buffer))
	  (eab/clocktable-scope)))

(defun eab/update-reports-nightly ()
  (interactive)
  (eab/create-nightly)
  (ignore-errors (kill-buffer "time-reports-step.org"))
  (shell-command
   (concat "cp -f " org-directory "templates/time-reports-step.org  " org-directory "gen/time-reports-step.org"))
  (find-file (concat org-directory "gen/time-reports-step.org"))
  (org-update-all-dblocks)
  (save-buffer)
  (org-publish-remove-all-timestamps)
  ;; (org-publish-project "html-nightly" t)
  (ignore-errors (kill-buffer "time-reports-nightly.org"))
  (shell-command
   (concat "cp -f " org-directory "templates/time-reports " org-directory "gen/time-reports-nightly.org"))
  (find-file (concat org-directory "gen/time-reports-nightly.org"))
  (auto-revert-buffers)
  (org-update-all-dblocks)
  (save-buffer)
  (org-publish-project "html-gen" t)
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

(defun csum ()
  (org-minutes-to-clocksum-string (org-clock-sum-current-item)))

(defun csum-file ()
  (org-clock-sum)
  (org-minutes-to-clocksum-string org-clock-file-total-minutes))

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
  (mapcar (lambda (f) (eab/org-clock-sum f)) eab/clocktable-scope))

(setq eab/clocktable-scope
       (file-expand-wildcards (concat (file-name-as-directory org-directory) "clock/*.org")))

(defun eab/clocktable-scope () eab/clocktable-scope)


(defun eab/check-csum-day (&optional date)
  (interactive)
  (dired org-directory)
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
  (insert "\" :maxlevel 1 :narrow 80! :link t :tags \"-ЖЖ\" :scope (eab/clocktable-scope)\n")
  (insert "#+END:")
  (previous-line)
  (org-ctrl-c-ctrl-c)
  (eab/extract-csum)
  (kill-buffer (current-buffer))
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
  (org-mode)
  (insert "* контрольная сумма\n")
  (insert "#+BEGIN: clocktable :maxlevel 1 :narrow 80! :tags \"-ЖЖ\" :scope (eab/clocktable-scope)\n")
  (insert "#+END:")
  (previous-line)
  (org-ctrl-c-ctrl-c)
  (eab/extract-csum)
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
  (shell-command (concat "echo " message " | mail -s \"" message "\" eab@" system-name)))

(defun eab/send-csum ()
  (eab/check-csum-day)
  (if (not (string-equal eab/hron-csum-day "*1d 0:00*"))
      (eab/send-mail
       (concat
	"Сумма не равна 24 часа failed: calendar 1d"
	", csum "
	eab/hron-csum-day))
    (eab/send-mail "Совпадает!")))

;; TODO aren't used
(defvar eab/hron-initial-time nil "Date of begining of diarize")
(setq eab/hron-initial-time (apply 'encode-time (org-parse-time-string "<2007-01-01 Пн. 00:00>")))

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
  (if (not (string-equal
	    eab/hron-csum-day
	    (concat "*" (eab/get-all-csum) "*")))
      (progn
	(eab/send-mail
	 (concat
	  "All time failed: calendar "
	  (eab/get-all-csum)
	  ", csum "
	  eab/hron-csum-day))
	(server-eval-at "server" '(add-to-list 'mode-line-modes '(t " [!] ")))
	(sauron-fx-mplayer "/usr/share/sounds/ubuntu/stereo/phone-incoming-call.ogg"))
    (progn
      (setq eab/total-csum eab/hron-csum-day)
      (eab/send-mail "All time Совпадает!")
      (server-eval-at "server" `(progn
				  (setq eab/total-csum ,eab/total-csum)
				  (sauron-add-event 'eab 3 "All time Совпадает!")
				  (setq mode-line-modes (remove '(t " [!] ") mode-line-modes))))
      (sauron-add-event 'eab 3 "All time Совпадает!"))))

(defun eab/send-csum-all-remote (&optional arg)
  (interactive "P")
  ;; (let ((shell-command-switch "-ic")) (eab/shell-command "nemacs"))
  ;; (sleep-for 1)
  ;; (eab/shell-command "wmctrl -r \"emacsserverN\" -b add,below") ;; TODO влияет и на обычный nemacs?
  ;; (eab/shell-command "wmctrl -a \"emacs@\"")
  (let ((fname (if arg 'eab/check-csum-all 'eab/check-csum-all-GREP)))
    (funcall
     `(lambda () (async-eval
		     (lambda (result) (message "async result: <%s>" result))
		   (progn
		     (require 'server)
		     (sleep-for 1)
		     (server-eval-at "serverN" '(progn
						  (auto-revert-buffers)
						  (,fname)
						  (eab/send-csum-all)
						  ))
		     (kill-emacs)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
	     (forecast-hours
	      (* (/ 365.0
		    (string-to-number
		     (cadr
		      (split-string
		       (calendar-day-of-year-string
			(calendar-current-date))))))
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
;; Custom_ID, то можно обойтись без отдельного столбца
;; TODO see eab/abbrev-link
(defun eab/paper-link (name)
  (if (not (string= name ""))
      (concat "[[papers:" name "][" name "]]")
    ""))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'eab-hron-lib)

;;; eab-hron-lib.el ends here
