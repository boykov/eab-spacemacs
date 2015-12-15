;; TODO use sudoedit or tramp /sudo:?

(defvar eab/sudo-save-mode nil
  "")

(defun eab/sudo-save-mode-maybe ()
  ""
  ;; из-за этой строки было неправильное поведение
  ;; (if (not (minibufferp (current-buffer)))
  (eab/sudo-save-mode 1))

(define-global-minor-mode eab/global-sudo-save-mode
  eab/sudo-save-mode eab/sudo-save-mode-maybe
  :group 'files)

(define-minor-mode eab/sudo-save-mode
  " Mode for sudo-save"
  ;; The initial value.
  :lighter      " sudo"
  :init-value nil
  :global     t
  ;; The indicator for the mode line.
  )

(defun eab/sudo-save-toggle ()
  (interactive)
  (if eab/global-sudo-save-mode
      (eab/global-sudo-save-mode-off)
    (eab/global-sudo-save-mode-on)))

(defun eab/global-sudo-save-mode-on ()
  ""
  (interactive)
  (eab/global-sudo-save-mode 1))

(defun eab/global-sudo-save-mode-off ()
  ""
  (interactive)
  (eab/global-sudo-save-mode -1))

(provide 'eab-sudo)
