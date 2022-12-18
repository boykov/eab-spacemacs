;;; eab-auto-complete.el --- eab auto-complete extension -*- lexical-binding: t -*-

;; Copyright (C) 2010-2022 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: auto-complete auto-complete-config ac-dabbrev mode-local
;; Status: not intended to be distributed yet

(global-auto-complete-mode t)

(defadvice kmacro-start-macro (before eab-kmacro-start activate)
  (if auto-complete-mode
      (call-interactively 'auto-complete-mode)))

(defadvice kmacro-end-macro (after eab-kmacro-end activate)
  (unless auto-complete-mode
    (call-interactively 'auto-complete-mode)))

(setq ac-dwim t)
;; TODO auto-complete тормозит при малых значениях параметра
(setq ac-auto-start 5)
(setq ac-candidate-limit 100)

(setq ac-auto-show-menu 0.8)
(setq-default ac-sources '(ac-source-abbrev ac-source-words-in-buffer))

(setq ac-modes
      (append ac-modes
	      '(org-mode
		text-mode
		)))

(setq ac-sources
      (list ac-source-dabbrev
	    ))


(setq ac-source-american-english
      '((candidates
	 . (lambda ()
	     (all-completions ac-prefix eab/american-english)))))

(defun eab/completion-at-point ()
  (interactive)
  (flet ((ac-candidates () `(,eab-last-selected-candidate)))
    (ac-fuzzy-complete))
  (ac-expand 0))

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

;; (defadvice ac-inline-show (after eab-ac-expand activate)
;;   (if (> (length ac-candidates) 1)
;;       (let ((ac-common-part (try-completion ac-prefix ac-candidates)))
;; 	(ac-expand-common))
;;     (progn
;;       (ac-expand-string ac-common-part)
;;       (ac-inline-hide)))
;;   (setq eab-last-selected-candidate ac-selected-candidate))

;; (ad-remove-advice 'ac-inline-show 'after 'eab-ac-expand)
;; (ad-deactivate 'ac-inline-show)

;; (ad-remove-advice 'ac-inline-show 'after 'eab-ac-expand)
;; (ad-deactivate 'ac-inline-show)
;; (ad-activate 'ac-inline-show)
