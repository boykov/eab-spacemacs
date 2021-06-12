;;; eab-org-extension.el --- tree-based completion -*- lexical-binding: t -*-

(defun org-clock-sum (&optional tstart tend headline-filter propname)
  "Sum the times for each subtree.
Puts the resulting times in minutes as a text property on each headline.
TSTART and TEND can mark a time range to be considered.
HEADLINE-FILTER is a zero-arg function that, if specified, is called for
each headline in the time range with point at the headline.  Headlines for
which HEADLINE-FILTER returns nil are excluded from the clock summation.
PROPNAME lets you set a custom text property instead of :org-clock-minutes."
  (with-silent-modifications
    (let* ((re (concat "^\\(\\*+\\)[ \t]\\|^[ \t]*"
		       org-clock-string
		       "[ \t]*\\(?:\\(\\[.*?\\]\\)-+\\(\\[.*?\\]\\)\\|=>[ \t]+\\([0-9]+\\):\\([0-9]+\\)\\)"))
	   (lmax 30)
	   (ltimes (make-vector lmax 0))
	   (level 0)
	   (tstart (cond ((stringp tstart) (org-time-string-to-seconds tstart))
			 ((consp tstart) (float-time tstart))
			 (t tstart)))
	   (tend (cond ((stringp tend) (org-time-string-to-seconds tend))
		       ((consp tend) (float-time tend))
		       (t tend)))
	   (t1 0)
	   time)
      (remove-text-properties (point-min) (point-max)
			      `(,(or propname :org-clock-minutes) t
				:org-clock-force-headline-inclusion t))
      (save-excursion
	(goto-char (point-max))
	(while (re-search-backward re nil t)
	  (cond
	   ((match-end 2)
	    ;; Two time stamps.
	    (let* ((ts (float-time
			(apply #'encode-time
			       (save-match-data
				 (org-parse-time-string (match-string 2))))))
		   (te (float-time
			(apply #'encode-time
			       (org-parse-time-string (match-string 3)))))
		   (dt (- (if tend (min te tend) te)
			  (if tstart (max ts tstart) ts))))
	      (when (> dt 0) (cl-incf t1 (floor dt 60)))))
	   ((match-end 4)
	    ;; A naked time.
	    (setq t1 (+ t1 (string-to-number (match-string 5))
			(* 60 (string-to-number (match-string 4))))))
	   (t	 ;A headline
	    ;; Add the currently clocking item time to the total.
	    (when (and org-clock-report-include-clocking-task
		       (eq (org-clocking-buffer) (current-buffer))
		       (eq (marker-position org-clock-hd-marker) (point))
		       tstart
		       tend
		       (>= (float-time org-clock-start-time) tstart)
		       (<= (float-time org-clock-start-time) tend))
	      (let ((time (floor (org-time-convert-to-integer
				  (org-time-since org-clock-start-time))
				 60)))
		(setq t1 (+ t1 time))))
	    (let* ((headline-forced
		    (get-text-property (point)
				       :org-clock-force-headline-inclusion))
		   (headline-included
		    (or (null headline-filter)
			(save-excursion
			  (save-match-data (funcall headline-filter))))))
	      (setq level (- (match-end 1) (match-beginning 1)))
	      (when (>= level lmax)
		(setq ltimes (vconcat ltimes (make-vector lmax 0)) lmax (* 2 lmax)))
	      (when (or (>= t1 0) (> (aref ltimes level) 0))
		(when (or headline-included headline-forced)
		  (if headline-included
		      (cl-loop for l from 0 to level do
			       (aset ltimes l (+ (aref ltimes l) t1))))
		  (setq time (aref ltimes level))
		  (goto-char (match-beginning 0))
		  (put-text-property (point) (point-at-eol)
				     (or propname :org-clock-minutes) time)
		  (when headline-filter
		    (save-excursion
		      (save-match-data
			(while (org-up-heading-safe)
			  (put-text-property
			   (point) (line-end-position)
			   :org-clock-force-headline-inclusion t))))))
		(setq t1 0)
		(cl-loop for l from level to (1- lmax) do
			 (aset ltimes l 0)))))))
	(setq org-clock-file-total-minutes (aref ltimes 0))))))

(defun org-clock-get-table-data (file params)
  "Get the clocktable data for file FILE, with parameters PARAMS.
FILE is only for identification - this function assumes that
the correct buffer is current, and that the wanted restriction is
in place.
The return value will be a list with the file name and the total
file time (in minutes) as 1st and 2nd elements.  The third element
of this list will be a list of headline entries.  Each entry has the
following structure:

  (LEVEL HEADLINE TAGS TIMESTAMP TIME PROPERTIES)

LEVEL:      The level of the headline, as an integer.  This will be
            the reduced level, so 1,2,3,... even if only odd levels
            are being used.
HEADLINE:   The text of the headline.  Depending on PARAMS, this may
            already be formatted like a link.
TAGS:       The list of tags of the headline.
TIMESTAMP:  If PARAMS require it, this will be a time stamp found in the
            entry, any of SCHEDULED, DEADLINE, NORMAL, or first inactive,
            in this sequence.
TIME:       The sum of all time spend in this tree, in minutes.  This time
            will of cause be restricted to the time block and tags match
            specified in PARAMS.
PROPERTIES: The list properties specified in the `:properties' parameter
            along with their value, as an alist following the pattern
            (NAME . VALUE)."
  (let* ((maxlevel (or (plist-get params :maxlevel) 3))
	 (timestamp (plist-get params :timestamp))
	 (ts (plist-get params :tstart))
	 (te (plist-get params :tend))
	 (ws (plist-get params :wstart))
	 (ms (plist-get params :mstart))
	 (block (plist-get params :block))
	 (link (plist-get params :link))
	 (tags (plist-get params :tags))
	 (match (plist-get params :match))
	 (properties (plist-get params :properties))
	 (inherit-property-p (plist-get params :inherit-props))
	 (matcher (and match (cdr (org-make-tags-matcher match))))
	 cc st p tbl)

    (setq org-clock-file-total-minutes nil)
    (when block
      (setq cc (org-clock-special-range block nil t ws ms)
	    ts (car cc)
	    te (nth 1 cc)))
    (when (integerp ts) (setq ts (calendar-gregorian-from-absolute ts)))
    (when (integerp te) (setq te (calendar-gregorian-from-absolute te)))
    (when (and ts (listp ts))
      (setq ts (format "%4d-%02d-%02d" (nth 2 ts) (car ts) (nth 1 ts))))
    (when (and te (listp te))
      (setq te (format "%4d-%02d-%02d" (nth 2 te) (car te) (nth 1 te))))
    ;; Now the times are strings we can parse.
    (if ts (setq ts (org-matcher-time ts)))
    (if te (setq te (org-matcher-time te)))
    (save-excursion
      (org-clock-sum ts te
		     (when matcher
		       `(lambda ()
			  (let* ((todo (org-get-todo-state))
				 (tags-list (org-get-tags))
				 (org-scanner-tags tags-list)
				 (org-trust-scanner-tags t))
			    (funcall ,matcher todo tags-list nil)))))
      (goto-char (point-min))
      (setq st t)
      (while (or (and (bobp) (prog1 st (setq st nil))
		      (get-text-property (point) :org-clock-minutes)
		      (setq p (point-min)))
		 (setq p (next-single-property-change
			  (point) :org-clock-minutes)))
	(goto-char p)
	(let ((time (get-text-property p :org-clock-minutes)))
	  (when (and time (>= time 0) (org-at-heading-p))
	    (let ((level (org-reduced-level (org-current-level))))
	      (when (<= level maxlevel)
		(let* ((headline (org-get-heading t t t t))
		       (hdl
			(if (not link) headline
			  (let ((search
				 (org-link-heading-search-string headline)))
			    (org-link-make-string
			     (if (not (buffer-file-name)) search
			       (format "id:%s"
				       (save-match-data (org-id-get-create))))
			     ;; Prune statistics cookies.  Replace
			     ;; links with their description, or
			     ;; a plain link if there is none.
			     (org-trim
			      (org-link-display-format
			       (replace-regexp-in-string
				"\\[[0-9]*\\(?:%\\|/[0-9]*\\)\\]" ""
				headline)))))))
		       (tgs (and tags (org-get-tags)))
		       (tsp
			(and timestamp
			     (cl-some (lambda (p) (org-entry-get (point) p))
				      '("SCHEDULED" "DEADLINE" "TIMESTAMP"
					"TIMESTAMP_IA"))))
		       (props
			(and properties
			     (delq nil
				   (mapcar
				    (lambda (p)
				      (let ((v (org-entry-get
						(point) p inherit-property-p)))
					(and v (cons p v))))
				    properties)))))
		  (push (list level hdl tgs tsp time props) tbl)))))))
      (list file org-clock-file-total-minutes (nreverse tbl)))))

(defun org-html-section (section contents info)
  "Transcode a SECTION element from Org to HTML.
CONTENTS holds the contents of the section.  INFO is a plist
holding contextual information."
  (let ((parent (org-export-get-parent-headline section)))
    ;; Before first headline: no container, just return CONTENTS.
    (if (not parent) contents
      ;; Get div's class and id references.
      (let* ((class-num (+ (org-export-get-relative-level parent info)
			   (1- (plist-get info :html-toplevel-hlevel))))
	     (section-number
	      (and (org-export-numbered-headline-p parent info)
		   (mapconcat
		    #'number-to-string
		    (org-export-get-headline-number parent info) "-"))))
        ;; Build return value.
	(format "<div class=\"outline-text-%d\" id=\"ID-%s\">\n%s</div>\n"
		class-num
		(or (org-element-property :ID parent)
		    (org-element-property :CUSTOM_ID parent)
		    section-number
		    (org-export-get-reference parent info))
		(or contents ""))))))

(provide 'eab-org-extension)
