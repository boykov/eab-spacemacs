;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	     __	       __      	  _    	__ _
;;	     \ \      /	/__  _ __| | __/ _| | _____    	 __
;;	      \	\ /\ / / _ \| '__| |/ /	|_| |/ _ \ \ /\	/ /
;;	       \ V  V /	(_) | |	 |   <|	 _| | (_) \ V  V /
;;	       	\_/\_/ \___/|_|	 |_|\_\_| |_|\___/ \_/\_/
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Workflow

(require 'key-chord)
(setq key-chord-two-keys-delay 0.05)

(defun er/add-text-mode-expansions ()
  (make-variable-buffer-local 'er/try-expand-list)
  (setq er/try-expand-list (append
                            er/try-expand-list
                            '(mark-paragraph
                              mark-page))))

(add-hook 'text-mode-hook 'er/add-text-mode-expansions)

;; prevent annoying switching on rk in region-bindings-mode on set-mark-command
;; DONE возможно, из-за этой настройки что-то начнет работать "странно"
(add-hook 'window-configuration-change-hook (lambda ()
					      (if (and mark-active (not (use-region-p)))
						  (deactivate-mark))))


(defun eab/insert-greek ()
  (interactive)
  (let ((method current-input-method))
    (set-input-method 'greek)
    (insert-char (read-char "Insert greek: " 't))
    (set-input-method 'russian-computer)
    (set-input-method method)))

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


(defvar eab/revert-buffer "u")

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defadvice winner-undo (before eab-winner-undo-before activate)
  (region-bindings-mode-disable))

(defadvice winner-undo (after eab-winner-undo-after activate)
  (region-bindings-mode-enable))

(defadvice winner-redo (before eab-winner-redo-before activate)
  (region-bindings-mode-disable))

(defadvice winner-redo (after eab-winner-redo-after activate)
  (region-bindings-mode-enable))


(provide 'eab-workflow)
