;;; eab-grep.el --- eab grep extension

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: grep-a-lot wgrep
;; Status: not intended to be distributed yet

;; require grep-a-lot

(require 'grep-a-lot)
(require 'wgrep)
(setq wgrep-enable-key "r")
(setq wgrep-default-line-header-regexp "^\\(.*?[^/\n]\\)\\([:-][ \t]*\\)\\([1-9][0-9]*\\)[ \t]*[-]:")

(setq grep-use-null-device nil)

;; TODO test wgrep mode
;; (setcar (car grep-regexp-alist) "^\\(.+?\\)\\(:[ \t]*\\)\\([1-9][0-9]*\\)[ \t]*\\2")
;; (setcar (car grep-regexp-alist)   "^\\(.*?[^/\n]\\):[   ]*\\([1-9][0-9]*\\)[    ]*:")
(setcar (car grep-regexp-alist) "^\\(.+?\\):[ \t]*\\([1-9][0-9]*\\)[ \t]*:")

(defun eab/grep-align ()
  (interactive)
  (read-only-mode -1)
  (toggle-truncate-lines 1)
  (save-excursion
    (beginning-of-buffer)
    (compilation-next-error 1)
    (call-interactively 'set-mark-command)
    (end-of-buffer)
    (backward-paragraph)
    (align-regexp (region-beginning) (region-end) "\\(:[0-9]+\\)\\(\\):" 2 1 t))
  (read-only-mode 1))

(defun eab/wgrep-change-to-wgrep-mode ()
  (interactive)
  (eab/grep-align)
  (call-interactively 'wgrep-change-to-wgrep-mode))

(defun eab/grep-utf ()
  (interactive)
  (let* ((ss (split-string (car compilation-arguments) "LANG=C "))
	 (compilation-arguments
	  (append
	   (if (> (length ss) 1) (list (cadr ss)) (list (car compilation-arguments)))
	   (cdr compilation-arguments))))
    (eab/recompile)))

(defun eab/grep-switch ()
  (interactive)
  (let* ((ss-0 (cadr (split-string (car compilation-arguments) eab/grep-command)))
	 (ss (car (split-string ss-0 " `git ls-files \\\\`git rev-parse --show-toplevel\\\\``")))
	 (compilation-arguments
	  (append (list (concat eab/grep-command "\"^- <20(\\n[^\*-]|.)*?(.*|\\n)"
			  ss
			  "(\\n|.)*?((?=\\n- <)|(?=\\n\\*)|(?=\\Z))\" `git ls-files \\`git rev-parse --show-toplevel\\`` | sort -t$':' -k1,1 -k2n"))
	  (cdr compilation-arguments))))
    (eab/recompile)))

(defun eab/gz-grep (extension)
  (if (string= extension "gz")
      "zgrep"
    "rg"))

(setq grep-highlight-matches 'auto-detect)

;; DONE fixed bug (grep-compute-defaults): if grep-history is empty than
;; grep-command isn't parsed correctly
;; (setq grep-history '("grep -i -nH -e test  `git ls-files \\`git rev-parse --show-toplevel\\``"))

(setq eab/grep-command-args " --color never --no-heading --pcre2 -U -i -nH -e ")
(setq eab/grep-command (concat "rg" eab/grep-command-args))
(setq eab/grep-ls " `git ls-files \\`git rev-parse --show-toplevel\\``")
(setq eab/grep-ls-recurse " `git ls-files --recurse-submodules \\`git rev-parse --show-toplevel\\``")

(defun eab/grep-gitmodules (arg)
  (let* ((gitmodules-1 (concat
			top-level
			"/.gitmodules"))
	 (gitmodules (concat
		      remote-prefix
		      gitmodules-1))
	 (grepmoduleignore-1 (concat
			      top-level
			      "/.grepmoduleignore"))
	 (grepmoduleignore (concat
			    remote-prefix
			    grepmoduleignore-1)))
    (if (file-exists-p gitmodules)
	(if (equal arg 2)
	    (if (file-exists-p grepmoduleignore)
		eab/grep-ls
	      eab/grep-ls-recurse)
	  eab/grep-ls)
      eab/grep-ls)))

(defun eab/grep (arg)
  (interactive "P")
  ;; TODO disable toplevel if a simple directory
  (eab/with-git-toplevel
   (let* ((grep-host-defaults-alist nil)
	  (extension (ignore-errors
		       (file-name-extension buffer-file-name)))
	  (str (concat (eab/gz-grep extension) eab/grep-command-args))
	  (grep-command-no-list
	   (concat 
	    (if (or (file-exists-p (concat default-directory "/.gitignore"))
		    (string= (shell-command-to-string "git clean -n `pwd` | wc -l") "0\n"))
		`,(concat str (eab/grep-gitmodules arg))
	      `,(concat str " *."
			extension)) " | sort -t$':' -k1,1 -k2n"))
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
     (if (or (not arg) (equal arg 2))
	 (let ((current-prefix-arg nil))
	   (call-interactively 'grep))
       (compilation-start
	(if (and grep-use-null-device null-device)
	    (concat  grep-command-complete " " null-device)
	  grep-command-complete)
	'grep-mode)))))

(defun eab/find-grep ()
  (interactive)
  (let ((grep-host-defaults-alist nil)
        (grep-find-command
         `(, (concat "find . -iname '**' -type f -print0 | xargs -0 -e " eab/grep-command "\"\" | sort -t$':' -k1,1 -k2n") . 102)))
    (call-interactively 'find-grep)))

(defun eab/clock-grep ()
  (interactive)
  (let ((grep-host-defaults-alist nil)
        (grep-command
         `(, (concat eab/grep-command "\"^- <20(\\n[^\*-]|.)*?(.*|\\n)(\\n|.)*?((?=\\n- <)|(?=\\n\\*)|(?=\\Z))\" `git ls-files \\`git rev-parse --show-toplevel\\`` | sort -t$':' -k1,1 -k2n") . 79)))
    (call-interactively 'grep)))

(grep-a-lot-advise eab/grep)

(provide 'eab-grep)
