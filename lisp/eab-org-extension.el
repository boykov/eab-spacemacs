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

(defun eab/org-clock-dispersion (func frac range)
  (let* ((minutes (cl-map 'vector #'org-duration-string-to-minutes range))
         (len (length minutes))
         (msum (cl-reduce '+ minutes))
         (mean (/ msum len))
         (tmp (cl-map 'vector #'(lambda (x) (- mean x)) minutes))
         (mmin0 (cl-reduce #'min minutes))
         (mmax0 (cl-reduce #'max minutes))
         (mmin (apply func (list mmax0 (abs mmin0))))
         ;; (mmax (max mmax0 (abs mmin0)))
         (minresult (* (string-to-number frac) (/ (* (+ msum mmin) len) (* (+ len 1) msum))))
         ;; (maxresult (* (string-to-number frac) (/ (* (+ msum mmax) len) (* (+ len 1) msum))))
         ;; (result (vector (/ (round (* minresult 100)) 100.0) (/ (round (* maxresult 100)) 100.0)))
         (result minresult)
         )
    result))

(defvar org-babel-default-header-args:ledger
  '((:results . "output") (:cmdline . "bal"))
  "Default arguments to use when evaluating a ledger source block.")

(defun org-babel-execute:ledger (body params)
  "Execute a block of Ledger entries with org-babel.  This function is
called by `org-babel-execute-src-block'."
  (message "executing Ledger source code block")
  (let ((cmdline (cdr (assq :cmdline params)))
        (in-file (org-babel-temp-file "ledger-"))
	(out-file (org-babel-temp-file "ledger-output-")))
    (with-temp-file in-file (insert body))
    (message "%s" (concat "ssh chronos /home/eab/.local/bin/hledger -s"
			  " -f " (org-babel-process-file-name in-file)
			  " " cmdline))
    (with-output-to-string
      (shell-command (concat "ssh chronos /home/eab/.local/bin/hledger -s"
			     " -f " (org-babel-process-file-name in-file)
			     " " cmdline
			     " > " (org-babel-process-file-name out-file))))
    (with-temp-buffer (insert-file-contents out-file) (buffer-string))))

(defun org-babel-prep-session:ledger (_session _params)
  (error "Ledger does not support sessions"))


(provide 'eab-org-extension)
