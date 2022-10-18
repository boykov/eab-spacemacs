;; * TODO
;; 

;; Activate appointments so we get notifications
(when (and (eab/ondaemon (eab/server-P)) (not noninteractive))
  (appt-activate t)
  (run-at-time nil nil (lambda () (message "%s" "hello")))
  (run-at-time nil 3600 'org-save-all-org-buffers)
  (run-at-time 60 3600 (lambda ()
			 (interactive)
			 (if desktop-file-modtime
			     (desktop-save (eab/desktop-dir))))))

;; TODO too much?
(setq appt-message-warning-time 12)
(setq appt-display-interval 12)

;; edit timer-idle-list
(when (eab/ondaemon (eab/server-P))
  (run-with-idle-timer 15 't (lambda () (interactive) (save-some-buffers 't))))

(when (eab/ondaemon (eab/server-P))
  (run-with-idle-timer 5 't (lambda () (interactive) (eab/update-query-on-idle 'eab/org-ql-H-query))))

(provide 'eab-appt)
