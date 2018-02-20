;; require dired

(require 'dired-async)

(eab/patch-this-code
 'dired-async-create-files
 "(require 'cl-lib) (require 'dired-aux) (require 'dired-x)"
 (let ((print-quoted 't))
   (prin1-to-string
    `(progn
       (require 'cl-lib)
       (require 'dired-aux)
       (require 'dired-x)
       (add-to-list
	'load-path
	,(file-name-directory
	  (buffer-file-name
	   (car (find-function-noselect 'docker-tramp-add-method)))))
       (require 'tramp)
       (add-to-list 'tramp-methods ',eab/sussh)
       (require 'docker-tramp)))) 't)

(dired-async-mode)
(setq dired-dwim-target 't)

(setq dired-listing-switches "-al -h")
(setq eab/dired-group-directories-off t)

(defun eab/dired-group-directories-toggle ()
  (interactive)
  (if eab/dired-group-directories-off
      (progn
	(setq dired-listing-switches "-al --group-directories-first -h")
	(setq eab/dired-group-directories-off nil))
    (progn
      (setq dired-listing-switches "-al -h")
      (setq eab/dired-group-directories-off 't))))

(defun eab/make-list-paths (&optional arg)
  "In dired-mode set last kill-ring value to full paths of marked files like Total Commander. (e.g)
    in dired: file1 (eab/make-list-paths)  -> /home/john/file1 to kill-ring"
  (interactive "p")
  (let* ((dropp (if (eq arg 1) nil 't))
	 (string-my (dired-get-marked-files dropp))
	 (buf-name (symbol-name (gensym))))
    (switch-to-buffer buf-name)
    (dolist (every-str string-my)
      (insert-for-yank-1 (if dropp (eab/add-drop every-str) every-str))
      (newline))
    (delete-backward-char 1)
    (beginning-of-buffer)
    (copy-region-as-kill (mark) (point))
    (kill-buffer buf-name)))

(defun eab/ansible-copy (&optional arg)
  "Copy remote file, e.g. /sudo:root@jupiter:/etc/pbstools.conf to
   respective place in jupiter ansible role"
  (interactive "p")
  (let* ((df (dired-file-name-at-point))
	 (file (if df df (buffer-file-name)))
	 (local (file-remote-p file 'localname))
	 (dir (file-name-directory local))
	 (ansdir (if arg
		     (concat eab/ansible-path "files" dir)
		   (concat eab/ansible-path "templates" dir))))
    (make-directory ansdir 't)
    (copy-file file (concat ansdir (file-name-nondirectory local)) 't)))

(defun eab/dired-singularity ()
  "Dired singularity.img at point"
  (interactive)
  (let* ((path (dired-file-name-at-point))
	 (local (file-remote-p path 'localname))
	 (method (file-remote-p path 'method))
	 (host (file-remote-p path 'host))
	 (file (file-name-nondirectory local))
	 (dir (file-name-directory local))
	 (tramp-methods (append
			 (list
			  `("singularity"
			    (tramp-login-program      "sudo singularity shell ")
			    (tramp-login-args         (("--writable") (,(concat dir "%h"))))
			    (tramp-remote-shell       "/bin/sh")
			    (tramp-remote-shell-args  ("-i" "-c"))))
			 tramp-methods)))
    (find-file (concat "/" method ":" host "|singularity:" file ":/"))))

(provide 'eab-dired)
