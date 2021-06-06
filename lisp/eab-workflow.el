;;; eab-workflow.el ---  eab workflow extension

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements:
;; Status: ready

(defvar eab/revert-buffer "u")

(defun eab/unbound-var ()
  (interactive)
  (let ((sym (symbol-at-point)))
    (setq eab/unbound-var-temp (list sym (symbol-value sym)))
    (makunbound sym)))

(defun eab/unbound-fun ()
  (interactive)
  (let ((sym (symbol-at-point)))
    (setq eab/unbound-fun-temp (list sym (symbol-function sym)))
    (fmakunbound sym)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/revert-buffer ()
  (interactive)
  (if (not (buffer-modified-p))
      (cond ((string= eab/revert-buffer "u")
             (progn
	       (let ((revert-without-query (list (buffer-file-name))))
		 (revert-buffer-with-coding-system 'cp1251))
	       (setq eab/revert-buffer "w")))
            ((string= eab/revert-buffer "w")
             (progn (let ((revert-without-query (list (buffer-file-name))))
		      (revert-buffer-with-coding-system 'utf-8))
                    (setq eab/revert-buffer "d")))
            ((string= eab/revert-buffer "d")
             (progn (let ((revert-without-query (list (buffer-file-name))))
		      (revert-buffer-with-coding-system 'cp866))
                    (setq eab/revert-buffer "u"))))))

(defun eab/fix-windows-coding ()
  (interactive)
  (shell-command (concat "sed -i 's/\r$//g' " (buffer-file-name)))
  (revert-buffer 't 't))


(provide 'eab-workflow)
