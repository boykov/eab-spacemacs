;;; eab-depend.el --- 

;; Copyright (C) 2010, 2011, 2012, 2013, 2014 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'docker)

(require 'rec-mode)

(require 'view)

(require 'restclient)
(require 'json-pretty-print)

(require 'color-moccur)
(require 'moccur-edit)

(eval-after-load "replace" '(progn (require 'replace+)))

(require 'bookmark+) ;; конфликтует с pymacs-load ropemacs
(eab/bind-path bmkp-last-as-first-bookmark-file)
(eab/bind-path bookmark-default-file)

(require 'dbus)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


(setq ibuffer-formats '((mark modified read-only " "
			      (name 18 18 :left :elide))))

;; (require 'el-expectations) ;; DONE devel minimalist unit testing framework
;; (setq exps-last-testcase nil)

(require 'one-key)

(require 'guide-key)
;; (setq guide-key/guide-key-sequence '("C-e"))
(guide-key-mode 1) ; Enable guide-key-mode


(require 'shell-history)
(require 'shell-command-queue)
;; (setq eshell-rc-script nil)

(eab/bind-path eshell-history-file-name)

(setq 
 mark-ring-max 64
 global-mark-ring-max 64
 history-length 1000
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

(require 'python-mode)
;; (require 'ipython)
;; (require 'pymacs)
(require 'pydoc-info)

(setq py-python-command "ipython")
(defvar py-mode-map python-mode-map)
(setq py-start-run-py-shell nil)
(setq py-force-py-shell-name-p 't) ;; DONE error with #!/usr/bin/python
(setq ipython-completion-command-string "print(';'.join(get_ipython().Completer.all_completions('%s')))\n")


(require 'redo+)
(require 'smart-operator)
(require 'alossage)

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

(require 'comint)

(require 'gnuplot)

(setq explicit-bash-args '("--noediting" "-i"))
(setq shell-file-name "/bin/bash")

(require 'dired-x)
(setq diredp-hide-details-initially-flag nil)
(require 'dired+)
;; TODO почему приходится делать unload?
;; (unload-feature 'dired-details+ 't)
;; (require 'ede) ; error with dired
;; (require 'dired-sort-menu)  

;; (require 'w3m)

(require 'nnir)

(require 'gnus-dired)
(require 'smtpmail-async)

(require 'buffer-move)


(require 'ps-print)
(require 'ps-mule)

(require 'htmlize)
;; (require 'xbbcode-mode)

;; (require 'sudo-save)

(require 'bbdb-loaddefs)
(require 'bbdb)
(require 'bbdb-anniv)
(eab/bind-path bbdb-file)
(bbdb-initialize 'gnus 'message 'sc) ;; 'w3m)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(setq bbdb-north-american-phone-numbers-p nil)

(require 'twittering-mode)
(setq twittering-use-native-retweet 't)
(setq twittering-initial-timeline-spec-string ":home")
(setq twittering-use-master-password t)
(eab/bind-path eab/twittering-mode)
(eab/bind-path eab/twittering-modeN)
(if (eab/ondaemon "server")
    (setq twittering-private-info-file eab/twittering-mode))
(if (eab/ondaemon "serverN")
    (setq twittering-private-info-file eab/twittering-modeN))

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

(require 'string-edit)



;; anything yasnippet auto-config etags
;; (require 'anything-complete) ;; problem with anything-match-plugin version
;; (require 'anything-extension)
;; (require 'anything-grep)
;; (require 'anything-c-shell-history)
;; (require 'anything-dabbrev-expand)
;; (require 'descbinds-anything)
;; (require 'anything-show-completion)
;; (require 'anything-ipython)
;; (require 'anything-c-moccur)

;; (require 'dictem)
;; (setq dictem-server "localhost")

(setq ispell-dictionary "english")
(setq ispell-local-dictionary "english")
(setq flyspell-default-dictionary "english")

(require 'gnugol)

;; (require 'far-search) ;; работает ужасно
;; (require 'grep-edit) ;; странно себя вел

(require 'oneonone)

(require 'purty-mode)
(require 'org-link-minor-mode)
(require 'idle-highlight-mode)

;; (require 'cask)
;; (require 'pallet)
;; (pallet-init)
;; (cask-initialize)

;; (require 'ignoramus)
;; (ignoramus-setup)

(require 'emacsc)

(add-to-list 'after-load-alist
	     '(rfc2104
	       (require 'keepass)))

(require 'diminish)
(diminish 'undo-tree-mode "UT")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     	       	 __  __	       	  _    	      
;;		|  \/  | ___   __| | ___  ___ 
;;		| |\/| |/ _ \ /	_` |/ _	\/ __|
;;		| |  | | (_) | (_| |  __/\__ \
;;		|_|  |_|\___/ \__,_|\___||___/
;;		       	       	       	      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("AUTOEXEC\\." . 'bat-mode))
(add-to-list 'auto-mode-alist '("CONFIG\\." . 'bat-mode))
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
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."    . crontab-mode))
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

(add-hook 'ielm-mode-hook (lambda () (setq comint-process-echoes nil)))
(add-hook 'comint-mode-hook (lambda () (setq comint-process-echoes t)))
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
(add-hook 'gnus-summary-prepared-hook 'gnus-summary-hide-all-threads)
;; (add-hook 'gnus-summary-prepared-hook 'gnus-summary-insert-old-articles)
;; (add-hook 'gnus-summary-prepared-hook
;; 	  (lambda () (interactive) (gnus-summary-insert-old-articles 100))) ;; don't need add old articles for dovecot?
(add-hook 'gnus-summary-prepare-hook 'gnus-summary-sort-by-most-recent-date)

;; (add-hook 'text-mode-hook 'dictionary-tooltip-mode) ; activate for all text-based modes
(add-hook 'cisco-mode-hook 'turn-on-font-lock)

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
