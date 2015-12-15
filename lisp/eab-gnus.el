(eab/bind-path gnus-init-file)
(eab/bind-path gnus-startup-file)
(eab/bind-path nnmail-message-id-cache-file)

(setq gnus-large-newsgroup 100)
(setq gnus-always-read-dribble-file t)
(setq gnus-message-archive-group (quote ((if (message-news-p) "sent-news" "nnimap+Dovecot:[Gmail]/Sent Mail"))))
(setq gnus-select-method (quote (nnml "")))

(setq mail-sources nil)

(setq user-full-name "Evgeny Boykov")

(setq smtpmail-local-domain nil)
(setq send-mail-function 'smtpmail-send-it)
(setq message-send-mail-function 'smtpmail-send-it)

(setq send-mail-function 'async-smtpmail-send-it ;; smtpmail-send-it
      message-send-mail-function 'async-smtpmail-send-it) ;; smtpmail-send-it

(setq smtpmail-debug-info t)
(load-library "smtpmail")
(load-library "message")


;;***********************************

(setq gnus-secondary-select-methods '((nnml "")))

;; Dovecot
(add-to-list 'gnus-secondary-select-methods '(nnimap "Dovecot"
						     (nnimap-address "localhost")
						     (nnimap-server-port 143)
						     (nnimap-stream network)
						     (nnimap-authenticator login)))

(setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
(setq imap-ssl-program "gnutls-cli --port %p %s")
(setq gnus-summary-line-format "%U%R%z%I%(%[%4L: %-23,25D %-23,23f% %-23,43F%]%) %s\n")
(setq gnus-ignored-from-addresses "[artscan@list\\.ru|eugeniy.boykov@gmail\\.com|boykov@as\\.khb\\.ru]") ;; exclude my addresses for valid field %f

(setq nnmail-split-methods '(
                             ("NOT-RU" "^\\(To\\|From\\|Cc\\):.*@\\.ru")
                             ("inbox" "")
                             ("contacts" ".*moikrug.*")
                             ))

(setq mail-user-agent 'gnus-user-agent)
;; always queue mail, see eab-path.el with idle-timer
;; gnus-group-send-queue

;; doesn't work, because message-send save to "sent mail" before move it
;; to queue
;; (setq gnus-agent-queue-mail 'always)

;; Не использовать кэш при работе с локальным imap сервером!
(setq gnus-agent-cache nil)

(defun eab/message-send ()
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer)
  (let ((mail-buffer (current-buffer)))
    (message-bury mail-buffer)
    (run-with-idle-timer 2 nil
			 `(lambda ()
			    (save-window-excursion
			      (switch-to-buffer ,mail-buffer)
			      (call-interactively 'message-send-and-exit))))))
  
(defun eab/gnus-inbox ()
  (interactive)
  (gnus-summary-exit)
  (gnus-group-read-group t t "nnimap+Dovecot:inbox"))

(defun eab/gnus-group-select (&optional all)
  (interactive "P")
  (gnus-group-select-group (if all all 100)))

(provide 'eab-gnus)
