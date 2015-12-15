(defvar eab/twittering-oauth-access-token-alist nil)
(defvar eab/twittering-oauth-access-token-alistN nil)

(defun eab/switch-twitter-account ()
  (interactive)
  (if (string= twittering-private-info-file eab/twittering-modeN)
      (progn
	(if (not eab/twittering-oauth-access-token-alist)
	    (setq eab/twittering-oauth-access-token-alist
		  (cdar (read (twittering-read-from-encrypted-file eab/twittering-mode)))))
	(setq twittering-edit-buffer "*artscan: twittering-edit*")
	(setq twittering-oauth-access-token-alist eab/twittering-oauth-access-token-alist)
	(setq twittering-private-info-file eab/twittering-mode))
    (progn
      (if (not eab/twittering-oauth-access-token-alistN)
	  (setq eab/twittering-oauth-access-token-alistN
		(cdar (read (twittering-read-from-encrypted-file eab/twittering-modeN)))))
      (setq twittering-edit-buffer "*ea2b: twittering-edit*")
      (setq twittering-oauth-access-token-alist eab/twittering-oauth-access-token-alistN)
      (setq twittering-private-info-file eab/twittering-modeN))))

(defun eab/twittering-update-status-interactive (arg)
  (interactive "P")
  (if (not arg)
      (progn
	(define-key twittering-edit-mode-map (kbd "C-c C-c") 'twittering-edit-post-status)
	(call-interactively 'twittering-update-status-interactive))
    (progn
      ;; (eab/switch-twitter-account)
      (define-key twittering-edit-mode-map (kbd "C-c C-c") 'eab/twittering-edit-post-status)
      (let ((twittering-edit-buffer "*ea2b: twittering-edit*")
	    (twittering-oauth-access-token-alist eab/twittering-oauth-access-token-alistN)
	    (twittering-private-info-file eab/twittering-modeN))
	(call-interactively 'twittering-update-status-interactive)))))

(defun eab/twittering-edit-post-status ()
  (interactive)
  (let ((twittering-edit-buffer "*ea2b: twittering-edit*")
	(twittering-oauth-access-token-alist eab/twittering-oauth-access-token-alistN)
	(twittering-private-info-file eab/twittering-modeN))
    (call-interactively 'twittering-edit-post-status)))

(defun eab/twittering-retweet ()
  (interactive)
  (let ((twittering-edit-buffer "*ea2b: twittering-edit*")
	(twittering-oauth-access-token-alist eab/twittering-oauth-access-token-alistN)
	(twittering-private-info-file eab/twittering-modeN))
    (call-interactively 'twittering-retweet)))

(defun eab/twittering-follow ()
  (interactive)
  (let ((twittering-edit-buffer "*ea2b: twittering-edit*")
	(twittering-oauth-access-token-alist eab/twittering-oauth-access-token-alistN)
	(twittering-private-info-file eab/twittering-modeN))
    (call-interactively 'twittering-follow)))

(defun eab/twit-filter ()
  (interactive)
  (moccur-search "^  [^@].*//" t (list (current-buffer))))

;; (twittering-load-private-info-with-guide)

(provide 'eab-twit)
