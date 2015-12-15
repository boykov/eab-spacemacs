;; require dired

(setq dired-listing-switches "-al --group-directories-first -h")
(setq dired-dwim-target 't)

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


(provide 'eab-dired)
