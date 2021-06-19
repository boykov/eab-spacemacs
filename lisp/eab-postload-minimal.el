
(defun eab/load-personal-minimal ()
  (interactive)
  ;; TODO don't setup defadvice wg-switch-to-workgroup before it
  (eab/workgroups-save-file-load)
  (if (fboundp 'grep-a-lot-clear-stack)
      (grep-a-lot-clear-stack))
  ;; (ignore-errors (let ((dir (eab/desktop-dir)))
  ;; 		   (if (file-exists-p (concat dir ".emacs.desktop"))
  ;; 		       (desktop-read dir))))
  (winner-mode)
  )

(if (and (or (eab/ondaemon "serverP") (eab/ondaemon "server")) (not noninteractive))
    (progn
      (eab/load-personal-minimal)
      (load-theme 'spacemacs-dark 't)))

(setq desktop-load-locked-desktop 't)
(if (and (not noninteractive))
    (progn
      (if configuration-layer-error-count
	  (add-to-list 'mode-line-modes '(t " [ERROR] ")))
      ;; TODO раньше был nil, потом стало глючить
      ;; из-за enable-local-variables
      (setq-default TeX-master t)))

(defun eab/test-dotemacs ()
  (if (not configuration-layer-error-count)
      (progn
	(server-eval-at "serverP" '(sauron-add-event 'eab 3 "OK Dotemacs is loaded! Expectations OK!"))
	(kill-emacs))
    (progn
	(server-eval-at "serverP" '(sauron-add-event 'eab 3 "Dotemacs is failed!"))
	(kill-emacs))))

;; TODO приходится вручную еще раз запускать, почему?
;; может быть это связано с нововведением dbus-launch?
;; Наоборот, пришлось убрать dbus-launch, т.к. из-за него
;; накапливались лишние процессы, а все по-прежнему
;; (when (and
;;        (eq window-system 'x)
;;        (fboundp 'dbus-register-signal))
;;   (dbus-register-signal
;;    :session nil "/org/gnome/evince/Window/0"
;;    "org.gnome.evince.Window" "SyncSource"
;;    'th-evince-sync))

(setq default-input-method "russian-computer")

(provide 'eab-postload-minimal)
