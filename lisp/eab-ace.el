(require 'ace-jump-mode)
;; (require 'ace-window)

(setq ace-jump-mode-gray-background nil) ;; it is faster

(defun eab/ace-ibuffer ()
  (interactive)
  (setq ido-exit 'eab-ido-exit)
  (exit-minibuffer))

(defun eab/call-ibuffer ()
  (if (equal (buffer-name (current-buffer)) "*Ibuffer*")
      (ibuffer-visit-buffer)))

(add-hook 'ace-jump-mode-end-hook 'eab/call-ibuffer)

(defun eab/isearch-ace-jump ()
  "Invoke `ace-jump' from isearch within `current-buffer'."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search)
        (isearch-buffer (current-buffer))
        (isearch-update-post-hook
	 (lambda ()
	    (interactive)
	    (if (not (equal isearch-string ""))
		(isearch-exit)))))
    (isearch-exit)
    (ace-jump-do (concat "\\b" isearch-string))))

;; Move to [[file:el-get/ace-jump-mode/ace-jump-mode.el][file:~/.emacs.d/el-get/ace-jump-mode/ace-jump-mode.el]]

(provide 'eab-ace)
