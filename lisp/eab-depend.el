;;; eab-depend.el --- 

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet


(require 'view)
(require 'dbus)
(require 'uniquify)

(setq uniquify-buffer-name-style 'forward)


(setq ibuffer-formats '((mark modified read-only " "
			      (name 18 18 :left :elide))
			(mark modified read-only " " (name 18 18 :left :elide) " "
			      (size 9 -1 :right) " " (mode 16 16 :left :elide) " " filename-and-process)))

;; (require 'el-expectations) ;; DONE devel minimalist unit testing framework
;; (setq exps-last-testcase nil)



;; (setq eshell-rc-script nil)

(eab/bind-path eshell-history-file-name)

(setq 
 mark-ring-max 64
 global-mark-ring-max 64
 history-length 500
 kill-ring-max 500
 eshell-history-size 1000
 )

(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 10000)

(setq slime-lisp-implementations '((sbcl ("sbcl"))))
;; (require 'slime) ;; DONE возможно, из-за elpa, не нужно прописывать, как это было с jabber
(setq slime-net-coding-system 'utf-8-unix)
;; (slime-setup)
;; (slime-setup '(slime-fancy))
(setq slime-enable-evaluate-in-emacs t)
;; (setq slime-net-coding-system 'utf-8-unix)


(require 'epa)
(require 'epg)
(require 'epa-file)
(epa-file-enable)
(setq epa-file-select-keys 'silent) 
(setenv "GPG_AGENT_INFO" nil) ; use gpg without gui window
(setq epg-gpg-program "gpg")

(require 'tramp)
(eab/bind-path tramp-persistency-file-name)
(setq tramp-default-method "ssh")
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
(add-to-list 'tramp-methods eab/sussh)
(add-to-list 'tramp-methods eab/sudo)
(add-to-list 'tramp-methods (let ((eab/singularity-dir "`pwd`/")) (eab/singularity)))

(require 'comint)


(setq explicit-bash-args '("--noediting" "-i"))
(if (file-exists-p "/bin/bash") (setq shell-file-name "/bin/bash"))


(require 'nnir)

(require 'gnus-dired)
(require 'smtpmail-async)

(require 'ps-print)
(require 'ps-mule)

(require 'erc-log)
(eab/bind-path erc-log-channels-directory)
(erc-log-enable)
(setq erc-server-history-list "localhost")
(setq erc-log-file-coding-system 'utf-8) 
(setq erc-save-buffer-on-part nil
      erc-save-queries-on-quit nil
      erc-log-write-after-send t
      erc-log-write-after-insert t)

(eval-after-load "erc"
    '(set-face-foreground 'erc-nick-default-face "magenta"))

;; (require 'dictem)
;; (setq dictem-server "localhost")

(setq ispell-dictionary "english")
(setq ispell-local-dictionary "english")
(setq flyspell-default-dictionary "english")
(defun eab/flyspell-buffer (arg)
  (interactive "P")
  (let ((ispell-local-dictionary (if arg "en" "ru")))
    (flyspell-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     	       	 __  __	       	  _    	      
;;		|  \/  | ___   __| | ___  ___ 
;;		| |\/| |/ _ \ /	_` |/ _	\/ __|
;;		| |  | | (_) | (_| |  __/\__ \
;;		|_|  |_|\___/ \__,_|\___||___/
;;		       	       	       	      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(push '("\\.md\\'" . markdown-mode) auto-mode-alist)
(add-to-list 'auto-mode-alist '("\\.spec\\|\\.spec\\.in" . rpm-spec-mode))
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-to-list 'auto-mode-alist '("/\\.ssh/config\\'"     . ssh-config-mode))
(add-to-list 'auto-mode-alist '("/sshd?_config\\'"      . ssh-config-mode))
(add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
(add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode))
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
(add-to-list 'auto-mode-alist '("\\.redmine\\'" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.pp\\'" . puppet-mode))
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c-mode))
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."    . crontab-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("/keys.yml"             . ansible-vault-mode))
(add-to-list 'auto-mode-alist '("\\.dired$" . dired-virtual-mode))
(add-to-list 'auto-mode-alist '("\\.tmpl$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("AUTOEXEC\\." . 'bat-mode))
(add-to-list 'auto-mode-alist '("CONFIG\\." . 'bat-mode))
(add-to-list 'auto-mode-alist '("\\.cuf\\'" . f90-mode))
(add-to-list 'auto-mode-alist '("\\.F90\\'" . f90-mode))
(add-to-list 'auto-mode-alist '("\\.[bB][aA][tT]$" . 'bat-mode))
(add-to-list 'auto-mode-alist '("\\.\\(frm\\|bas\\|cls\\|vbs\\)$" . visual-basic-mode))
(add-to-list 'auto-mode-alist '("\\.ahk$" . ahk-mode))
(add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode))
(add-to-list 'auto-mode-alist '("\\.lsp\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.max\\'" . maxima-mode))
(add-to-list 'auto-mode-alist '("\\.mpl\\'" . maplev-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.rtf\\'" . rtf-mode))
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
(add-to-list 'auto-mode-alist '("\\.wiki\\'" . wikipedia-mode))
(add-to-list 'auto-mode-alist '("\\.wikipedia\\.org.*\\.txt\\'" . wikipedia-mode))
(add-to-list 'auto-mode-alist '("en\\.wikipedia\\.org" . wikipedia-mode))
(add-to-list 'auto-mode-alist '("stack\\(exchange\\|overflow\\)\\.com\\.[a-z0-9]+\\.txt" . markdown-mode))

(add-to-list 'load-path (eab/bind-path eab/emaxima-path))
(eab/bind-path ebib-file-search-dirs)
(eab/bind-path ebib-preload-bib-files)

(autoload 'org-grep "org-grep" nil t)
(autoload 'rtf-mode "rtf-mode" "RTF" t)
(autoload 'ahk-mode "ahk-mode")
(autoload 'anchored-transpose "anchored-transpose" nil t)
(autoload 'bat-mode "bat-mode" "DOS and WIndows BAT files" t)
(autoload 'cmaple "maplev" "Start maple process" t)
(autoload 'ebib "ebib" "Ebib, a BibTeX database manager." t)
(autoload 'emaxima-mode "emaxima" "EMaxima mode" t)
(autoload 'flyspell-auto-correct-previous-word "flyspell" "Auto correct the first mispelled" t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'maplev-mode "maplev" "Maple editing mode" t)
(autoload 'maxima "maxima" "Running Maxima interactively" t)
(autoload 'maxima-mode "maxima" "Maxima editing mode" t)
(autoload 'python-mode "python-mode" "Python Mode." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(autoload 'wikipedia-mode "wikipedia-mode.el" "Major mode for editing documents in Wikipedia markup." t)

(defalias 'perl-mode 'cperl-mode)
(setq cperl-extra-newline-before-brace t
      cperl-brace-offset              -2
      cperl-merge-trailing-else        nil)

(add-hook 'textile-mode-hook (lambda () (toggle-truncate-lines -1)))
(add-hook 'ielm-mode-hook (lambda () (setq comint-process-echoes nil)))
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
(add-hook 'gnus-summary-prepared-hook 'gnus-summary-hide-all-threads)
;; (add-hook 'gnus-summary-prepared-hook 'gnus-summary-insert-old-articles)
;; (add-hook 'gnus-summary-prepared-hook
;; 	  (lambda () (interactive) (gnus-summary-insert-old-articles 100))) ;; don't need add old articles for dovecot?
(add-hook 'gnus-summary-prepare-hook 'gnus-summary-sort-by-most-recent-date)

;; (add-hook 'text-mode-hook 'dictionary-tooltip-mode) ; activate for all text-based modes
;; (add-hook 'cisco-mode-hook 'turn-on-font-lock)

;; eab-misc

(require 'gnugol)

(require 'dired-x)
(setq diredp-hide-details-initially-flag nil)
(require 'dired+)
(require 'dired-details)
;; TODO почему приходится делать unload?
;; (unload-feature 'dired-details+ 't)
;; (require 'ede) ; error with dired
;; (require 'dired-sort-menu)  

(require 'alossage)
(require 'shell-history)
(require 'shell-command-queue)
(require 'one-key)
(require 'json-pretty-print)
(require 'rec-mode)
(require 'color-moccur)
(require 'moccur-edit)
(eval-after-load "replace" '(progn (require 'replace+)))

(defun multi-occur-in-all-buffers ()
  "Show all lines matching REGEXP in all buffers."
  (interactive)
  (multi-occur
   (buffer-list)
   (car (occur-read-primary-args))))

(require 'smart-operator)
(add-hook 'maplev-mode-hook
          (lambda ()
	    ;;            (smart-operator-mode-on)
            (setq maplev-mint-start-options (list "-q" "-P"))
            (setq maplev-executable-alist '(("11" "maple" nil "maple")
                                            ("10" "maple" nil "mint")
                                            ("9" "maple" nil "mint")
                                            ("8" "maple" nil "mint")
                                            ("7" "maple" nil "mint")
                                            ("6" "maple" nil "mint")
                                            ("5.1" "maple" nil "mint")
                                            ("5" "maple" nil "mint")
                                            ("4" "maple" nil "mint")))))


(provide 'eab-depend)
