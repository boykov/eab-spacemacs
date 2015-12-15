;;; eab-workgroups2.el --- 

;; Copyright (C) 2010-2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: workgroups2
;; Status:

(require 'workgroups2)

(setq eab/wg-workgroups-history ())

(defun eab/wg-add-workgroup-to-history (id)
  (interactive)
  (setq eab/wg-workgroups-history
	(reverse
	 (remove-duplicates
	  (reverse
	   (append (list id) eab/wg-workgroups-history))))))

(defadvice wg-switch-to-workgroup (before eab-wg-switch-to-workgroup activate)
  (let ((workgroup (wg-current-workgroup t)))
    (if workgroup
	(eab/wg-add-workgroup-to-history (wg-workgroup-uid workgroup)))))

;; (ad-remove-advice 'wg-switch-to-workgroup 'before 'eab-wg-set-previous-workgroup)
;; (ad-deactivate 'wg-switch-to-workgroup)


(eab/bind-path eab/workgroups-save)
(eab/bind-path wg-session-file)

(if (not (boundp 'eab/workgroups-save))
    (setq eab/workgroups-save wg-session-file))

(setq wg-use-default-session-file 't)
(setq wg-control-frames 'nil)
(setq wg-session-load-on-start nil)
(ignore-errors (workgroups-mode 1))

(setq wg-mode-line-decor-divider "")

(defvar eab/wg-update-hash nil "Directory : workgroup")

(setq eab/wg-update-hash (make-hash-table :test 'equal))

(eab/bind-path eab/wg-update-list)

(if (boundp 'eab/wg-update-list)
    (mapcar
     (lambda (lst)
       (puthash (car lst) (cadr lst) eab/wg-update-hash))
     eab/wg-update-list))

(defun eab/wg-update (bufsw)
  "Update current workgroup by current directory"
  (let* ((wg-name (gethash
                   (if (buffer-file-name (get-buffer bufsw))
                       (file-name-directory
			(abbreviate-file-name (buffer-file-name (get-buffer bufsw)))))
                   eab/wg-update-hash))
         (wg-defined (if wg-name (wg-get-workgroup wg-name) nil))
         (wg-current (wg-current-workgroup 't)))
    (if (not (equal wg-defined wg-current))
        (if wg-defined (wg-switch-to-workgroup wg-defined)))))

(defun eab/wg-revert-and-update ()
  "Revert current workgroup and update selected workgroup by current config"
  (interactive)
  (let ((wg-target (wg-read-workgroup-name)))
    (wg-kill-ring-save-working-wconfig (wg-current-workgroup))
    (call-interactively 'wg-revert-workgroup)
    (wg-switch-to-workgroup wg-target)
    (with-output-to-string (wg-yank-wconfig)))
  (message "eab/wg-revert-and-update finished."))

(defun eab/workgroups-save-file-load ()
  (let ((file eab/workgroups-save))
    (if (file-exists-p file)
	(wg-find-session-file file))))

;; DONE load from eab/eab-workgroups
(defun eab/wg-revert-workgroup ()
  "Load \"dflt\" wconfig for current workgroup"
  (interactive)
    (let ((workgroup (wg-current-workgroup)))
      (wg-restore-wconfig-undoably
       (wg-workgroup-get-saved-wconfig "dflt")
       workgroup)))

(defun eab/wg-update-workgroup ()
  "Save \"dflt\" wconfig for current workgroup"
  (interactive)
  (execute-kbd-macro
   (read-kbd-macro
    "M-a wg-save-wconfig RET dflt RET")))

;; (eab/bind-path eab/eab-workgroups)

;; (defun eab/eab-wg-save ()
;;   "Save workgroups to `eab/eab-workgroups' and reset `wg-file'"
;;   (interactive)
;;   (eab/wg-save eab/eab-workgroups)
;;   (setf (wg-session-file-name (wg-current-session)) eab/workgroups-save))

;; (defun eab/eab-wg-load ()
;;   "Load workgroups from `eab/eab-workgroups' and reset `wg-file'"
;;   (interactive)
;;   (eab/wg-load eab/eab-workgroups)
;;   (setf (wg-session-file-name (wg-current-session)) eab/workgroups-save))

(defun eab/wg-kill-tmp ()
  (interactive)
  (let ((wg (wg-get-workgroup ":tmp:" 't)))
    (if wg
	(wg-delete-workgroup wg))))

(defun eab/wg-switch-to-workgroup (name)
  (wg-switch-to-workgroup (wg-get-workgroup name)))

(defun eab/wg-names ()
  (wg-workgroup-names))

(defun eab/wg-switched-msg ()
  (wg-fontified-message (:cmd "Switched: ") (wg-workgroup-list-display)))

(defun eab/wg-load (file)
  (wg-find-session-file file))

(defun eab/wg-save (file)
  (wg-write-session-file file))

;; (defun eab/wg-update-all-workgroups ()
;;   (wg-update-all-base-wconfigs))

(defun eab/wg-current-workgroup ()
  (wg-workgroup-name (wg-current-workgroup)))

(provide 'eab-workgroups2)
