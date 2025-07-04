;;; eab-workgroups2.el --- eab workgroup2 extension   -*- lexical-binding: t -*-

;; Copyright (C) 2010-2024 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: workgroups2
;; Status: ready

(require 'workgroups2)

(defvar eab/wg-path nil "")
(defvar eab/workgroups-save nil "")
(defvar eab/wg-update-list nil "")
(defvar eab/wg-workgroups-history nil "")
(defvar eab/wg-update-hash
  (make-hash-table :test 'equal)
  "Directory : workgroup")

;; (eab/print-0 (wg-workgroup-names))
(defun eab/wg-init ()
  (unless (boundp 'eab/workgroups-save)
    (setq eab/workgroups-save wg-session-file))
  (if (boundp 'eab/wg-update-list)
      (mapcar
       (lambda (lst)
         (puthash (car lst) (cadr lst) eab/wg-update-hash))
       eab/wg-update-list)))

(defun eab/wg-create-workgroup (path)
  (let* ((true-path (file-truename path))
         (nondir (file-name-nondirectory path))
         (name nondir))
    (when (file-exists-p true-path)
      (unless (wg-get-workgroup name 't)
        (wg-create-workgroup name 't)
        (find-file true-path)
        (if (file-regular-p true-path)
            (execute-kbd-macro (read-kbd-macro "M-1 M-@ C-f c C-f c")))
        (eab/wg-update-workgroup "dflt"))
      (eab/wg-add-workgroup-to-history
       (wg-workgroup-uid (wg-get-workgroup name 't))))))

;; TODO можно использовать `gr list` вместо wg/*: все-равно вручную
;; пополняю оба эти списка хотя, симлинки требуют меньше зависимостей
;; (на чистой системе это важно)
(defun eab/create-workgroups ()
  (interactive)
  (mapcar 'eab/wg-create-workgroup
          (file-expand-wildcards eab/wg-path))
  (wg-save-session t))

(defun eab/wg-add-workgroup-to-history (id)
  (interactive)
  (setq eab/wg-workgroups-history
        (reverse
         (remove-duplicates
          (reverse
           (append (list id) eab/wg-workgroups-history))))))

(defun eab/show-wg-workgroups-history ()
  (mapcar 'wg-workgroup-name
          (remove-if
           (lambda (x) (not x))
           (mapcar
            (lambda (uid) (wg-find-workgroup-by :uid uid t))
            eab/wg-workgroups-history))))

(defadvice wg-switch-to-workgroup (before eab-wg-switch-to-workgroup activate)
  (let ((workgroup (wg-current-workgroup t)))
    (if workgroup
        (if (eab/wg-base? (wg-workgroup-name workgroup))
            (eab/wg-add-workgroup-to-history (wg-workgroup-uid workgroup))))))

;; (ad-remove-advice 'wg-switch-to-workgroup 'before 'eab-wg-set-previous-workgroup)
;; (ad-deactivate 'wg-switch-to-workgroup)

(defun eab/wg-update (bufsw)
  "Update current workgroup by current directory"
  (let* ((wg-name (gethash
                   (if (buffer-file-name (get-buffer bufsw))
                       (file-name-directory
                        (abbreviate-file-name (buffer-file-name (get-buffer bufsw)))))
                   eab/wg-update-hash))
         (wg-defined (if wg-name (wg-get-workgroup wg-name) nil))
         (wg-current (wg-current-workgroup 't)))
    (unless (equal wg-defined wg-current)
      (if wg-defined (wg-switch-to-workgroup wg-defined)))))

(defun eab/wg-revert-and-update ()
  "Revert current workgroup and update selected workgroup by current config"
  (interactive)
  (let ((wg-target (wg-read-workgroup-name)))
    (wg-add-to-wconfig-kill-ring
     (wg-workgroup-working-wconfig (wg-current-workgroup)))
    (call-interactively 'eab/wg-revert-workgroup)
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

(defun eab/wg-update-workgroup (wg-config)
  "Save wg-config for current workgroup"
  (interactive)
  (let* ((workgroup (wg-current-workgroup))
         (name wg-config)
         (wconfig (wg-current-wconfig)))
    (setf (wg-wconfig-name wconfig) name)
    (wg-workgroup-save-wconfig wconfig workgroup)
    (wg-fontified-message
      (:cmd "Saved: ")
      (:cur name))))

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

(defvar eab/wg-ido-item 'list "list: only `(eab/show-wg-workgroups-history)`, buffer: all workgroups")

(defun eab/wg-switch-to-workgroup-history (&optional noerror)
  (interactive)
  (eab/wg-switch-to-workgroup-history-1))

(defvar ido-directory-nonreadable nil "")
(defvar ido-directory-too-big nil "")
(defvar ido-context-switch-command nil "")
(defvar ido-choice-list nil "")

(defun eab/wg-switch-to-workgroup-history-1 ()
  (interactive)
  (let ((ido-current-directory nil)
        (ido-directory-nonreadable nil)
        (ido-directory-too-big nil)
        (ido-context-switch-command nil)
        (ido-choice-list
         (if (eq eab/wg-ido-item 'list)
             (eab/show-wg-workgroups-history)
           (wg-workgroup-names))))
    (ido-read-internal 'list "Workgroup history: " 'ido-buffer-history nil))
  (cond
   ((eq ido-exit 'eab-refresh)
    (eab/wg-switch-to-workgroup-history-1))
   (t
    (if ido-matches
        (progn
          (setq eab/wg-ido-item 'list)
          (wg-switch-to-workgroup (ido-name (car ido-matches))))))))

(defun eab/wg-switch-to-previous-workgroup ()
  (interactive)
  (if (eq last-command-event 26)
      (eab/wg-switch-to-previous-workgroup-1)
    (wg-switch-to-previous-workgroup)))

(defun eab/wg-switch-to-previous-workgroup-1 ()
  (interactive)
  (let* ((wg-cur (wg-workgroup-name (wg-current-workgroup)))
        (wg-list (-difference (eab/show-wg-workgroups-history) (list wg-cur))))
    (if (or
         (eq last-command 'eab/wg-switch-to-previous-workgroup-1)
         (eq last-command 'wg-switch-to-previous-workgroup)
         (eq last-command 'eab/wg-switch-to-previous-workgroup))
        (wg-switch-to-workgroup (caddr wg-list))
      (wg-switch-to-workgroup (car wg-list)))))

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

(defun eab/wg-create-workgroup-xxx ()
  (interactive)
  (wg-create-workgroup (eab/wg-new-default-workgroup-name (eab/wg-current-workgroup))))

(defun eab/wg-new-default-workgroup-name (name)
  "Return a new, unique, default workgroup name."
  (let ((names (wg-workgroup-names t)) (index -1) result)
    (while (not result)
      (let ((new-name (format (concat (eab/wg-base-name name) "xxx%s") (cl-incf index))))
        (unless (member new-name names)
          (setq result new-name))))
    result))

(defun eab/wg-rotate-base ()
  (interactive)
  (let ((base (eab/wg-base-name (eab/wg-current-workgroup))))
    (if (eab/wg-base? (eab/wg-current-workgroup))
        (let* ((name (format (concat (eab/wg-current-workgroup) "xxx0"))))
          (if (member name (wg-workgroup-names t))
              (wg-switch-to-workgroup name)
            (message "No extra workgroups")))
      (let* ((num (string-to-number (cadr (split-string (eab/wg-current-workgroup) "xxx"))))
             (name (format (concat base "xxx%s") (+ num 1))))
        (if (member name (wg-workgroup-names t))
            (wg-switch-to-workgroup name)
          (wg-switch-to-workgroup (wg-get-workgroup base)))))))

(defun eab/wg-rotate-twice ()
  (interactive)
  (eab/wg-rotate-base)
  (eab/wg-rotate-base))

(defun eab/wg-base? (name)
  (if (string= name (eab/wg-base-name name)) 't nil))

(defun eab/wg-base-name (name)
  (car (split-string name "xxx")))

(defun eab/wg-clone-indirect-buffer ()
  (interactive)
  (call-interactively 'clone-indirect-buffer)
  (setq-local wg-buffer-uid nil)
  (wg-buffer-uid-or-add (current-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar wg-winner-vars nil)
(defvar wg-winner-hash nil)

(setq wg-winner-vars '(winner-ring-alist
                       winner-currents
                       winner-last-command
                       winner-last-frames
                       winner-modified-list
                       winner-point-alist
                       winner-undo-frame
                       winner-undone-data
                       winner-undo-counter
                       winner-pending-undo-ring))

(setq wg-winner-hash (make-hash-table :test 'equal))

(defun wg-winner-put (winner-name)
  (let ((wg (ignore-errors (wg-workgroup-name (wg-current-workgroup)))))
    (if wg
        (puthash (list wg winner-name) (eval winner-name) wg-winner-hash))))

(defun wg-winner-get (winner-name)
  (let ((wg (ignore-errors (wg-workgroup-name (wg-current-workgroup)))))
    (if wg
        (eval `(setq ,winner-name (gethash '(,wg ,winner-name) wg-winner-hash))))))

(defun wg-winner-save ()
  (if winner-mode
      (progn
        (winner-mode -1)
        (defun wg-winner-mode-restore ()
          (winner-mode 1)))
    (defun wg-winner-mode-restore ()))
  (mapcar 'wg-winner-put wg-winner-vars))

(defun wg-winner-load ()
  (mapcar 'wg-winner-get wg-winner-vars)
  (wg-winner-mode-restore))

(defadvice wg-switch-to-workgroup (before wg-winner-before activate)
  (wg-winner-save))

(defadvice wg-switch-to-workgroup (after wg-winner-after activate)
  (wg-winner-load))

;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'eab-workgroups2)
