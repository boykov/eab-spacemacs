(require 'auto-complete)
(require 'auto-complete-config)
;; (require 'ac-anything)
(require 'ac-dabbrev)
;; (require 'auto-complete-emacs-lisp)
(require 'mode-local)

(eab/bind-path ac-comphist-file)

(global-auto-complete-mode t)
(setq ac-dwim t)
;; TODO auto-complete тормозит при малых значениях параметра
(setq ac-auto-start 5)
(setq ac-candidate-limit 100)

(setq ac-auto-show-menu 0.8)
(defvar-mode-local org-mode ac-auto-start nil)
(defvar-mode-local org-mode ac-use-quick-help nil)
(setq-default ac-sources '(ac-source-abbrev ac-source-words-in-buffer))

(setq ac-modes
      (append ac-modes
	      '(org-mode
		text-mode
		)))

;; emacs auto-complete-dictionary

;; (ac-define-source words-in-f90-buffers
;;   '((init . ac-update-word-index)
;;    (candidates ac-word-candidates
;; 	       (lambda
;; 		 (buffer)
;; 		 (derived-mode-p
;; 		  (buffer-local-value 'major-mode buffer))))))
;; create variable ac-source-words-in-f90-buffers
;; and function ac-complete-words-in-f90-buffers
;; see words-in-same-mode-buffers

(setq ac-sources
      (list ac-source-dabbrev
	    ))

(eab/bind-path eab/american-english)
(setq ac-source-american-english
      '((candidates
	 . (lambda ()
	     (all-completions ac-prefix eab/american-english)))))

(defadvice ac-inline-show (after eab-ac-expand activate)
  (if (> (length ac-candidates) 1)
      (let ((ac-common-part (try-completion ac-prefix ac-candidates)))
	(ac-expand-common))
    (progn
      (ac-expand-string ac-common-part)
      (ac-inline-hide)))
  (setq eab-last-selected-candidate ac-selected-candidate))

;; (ad-remove-advice 'ac-inline-show 'after 'eab-ac-expand)
;; (ad-deactivate 'ac-inline-show)


(defun eab/completion-at-point ()
  (interactive)
  (flet ((ac-candidates () `(,eab-last-selected-candidate)))
    (ac-fuzzy-complete))
  (ac-expand))

;; (ad-remove-advice 'ac-inline-show 'after 'eab-ac-expand)
;; (ad-deactivate 'ac-inline-show)
;; (ad-activate 'ac-inline-show)

(add-hook 'python-mode-hook
	  (lambda ()
	    (setq ac-sources
		  '(ac-source-symbols ac-source-words-in-same-mode-buffers))))
(add-hook 'f90-mode-hook
	  (lambda ()
	    (setq ac-sources
		  '(ac-source-symbols ac-source-words-in-same-mode-buffers))))
(add-hook 'c++-mode-hook
	  (lambda ()
	    (setq ac-sources
		  '(ac-source-abbrev ac-source-symbols ac-source-words-in-same-mode-buffers))))
;; see also eval-expression-minibuffer-setup-hook
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (setq ac-sources
		  '(ac-source-words-in-buffer ac-source-symbols))))
(add-hook 'text-mode-hook
	  (lambda ()
	    (setq ac-sources
		  '(ac-source-words-in-buffer ac-source-american-english))))
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq ac-sources
		  '(ac-source-words-in-buffer ac-source-american-english ac-source-symbols))))

(provide 'eab-auto-complete)
