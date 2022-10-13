;;; eab-org-extension.el --- tree-based completion -*- lexical-binding: t -*-

(defun org-clock-time% (total &rest strings)
  "Compute a time fraction in percent.
TOTAL s a time string like 10:21 specifying the total times.
STRINGS is a list of strings that should be checked for a time.
The first string that does have a time will be used.
This function is made for clock tables."
  (let ((re "\\([0-9]*?\\)\\(?:d \\)*\\([0-9]+\\):\\([0-9]+\\)")
	tot s)
    (save-match-data
      (catch 'exit
	(if (not (string-match re total))
	    (throw 'exit 0.)
	  (setq tot (+ (string-to-number (match-string 3 total))
		       (* 60 (string-to-number (match-string 2 total)))
		       (* (string-to-number (match-string 1 total)) 24 60)))
	  (if (= tot 0.) (throw 'exit 0.)))
	(while (setq s (pop strings))
	  (if (string-match re s)
	      (throw 'exit
		     (/ (* 100.0 (+ (string-to-number (match-string 3 s))
				    (* 60 (string-to-number
					   (match-string 2 s)))
				    (* (string-to-number (match-string 1 s)) 24 60)))
			tot))))
	0))))

(provide 'eab-org-extension)
