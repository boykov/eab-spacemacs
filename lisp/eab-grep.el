;; require grep-a-lot

(require 'grep-a-lot)
(require 'wgrep)
(setq wgrep-enable-key "r")

(defun eab/gz-grep (extension)
  (if (string= extension "gz")
      "zgrep"
    "grep"))

;; DONE fixed bug (grep-compute-defaults): if grep-history is empty than
;; grep-command isn't parsed correctly
;; (setq grep-history '("grep -i -nH -e test  `git ls-files \\`git rev-parse --show-toplevel\\``"))

(defun eab/grep (arg)
  (interactive "P")
  (let* ((grep-host-defaults-alist nil)
	 (extension (ignore-errors
		      (file-name-extension buffer-file-name)))
	 (str (concat (eab/gz-grep extension) " -i -nH -e  "))
	 (grep-command-no-list
	  (if (file-exists-p ".gitignore")
	      `,(concat str " `git ls-files \\`git rev-parse --show-toplevel\\``")
	    `,(concat str " *."
		      extension)))
	 (len-str (1+ (length str)))
	 (grep-command
	  (if grep-history
	      (cons grep-command-no-list len-str)
	    grep-command-no-list))
	 (grep-command-complete
	  (concat
	   (substring grep-command-no-list 0 len-str)
	   (symbol-name (symbol-at-point)) " "
	   (substring grep-command-no-list len-str))))
    (if (not arg)
	(call-interactively 'grep)
      (compilation-start
       (if (and grep-use-null-device null-device)
	   (concat  grep-command-complete " " null-device)
	 grep-command-complete)
       'grep-mode))))

(defun eab/find-grep ()
  (interactive)
  (let ((grep-host-defaults-alist nil)
        (grep-find-command
         `(,"find . -iname '**' -type f -print0 | xargs -0 -e grep -i -nH -e \"\"" . 17)))
    (call-interactively 'find-grep)))

(grep-a-lot-advise eab/grep)

(provide 'eab-grep)
