;;; eab-sauron.el --- 

;; Copyright (C) 2010, 2011, 2012, 2013, 2014, 2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: sauron sauron-org sauron-notifications
;; Status: not intended to be distributed yet


(require 'sauron)
(require 'sauron-org)
(require 'sauron-notifications)

(setq sauron-separate-frame nil)
(add-hook 'sauron-event-added-functions
	  (lambda (origin prio msg &optional props)
	    (sauron-fx-mplayer "/usr/share/sounds/ubuntu/stereo/service-login.ogg")
	    ;;(notifications-notify :title "Sauron" :body msg)))
	    ))

(provide 'eab-sauron)
