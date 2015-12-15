;;; eab-org.el --- 

;; Copyright (C) 2010-2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;; (unload-feature 'org 't)
(require 'org)
(require 'org-clock)
(require 'org-checklist)
(require 'org-crypt)
(require 'remember)
(require 'org-capture)
(require 'org-id)
(require 'org-archive)
(require 'org-bbdb)
(require 'ox-latex)

(require 'tex)
(require 'tex-site)

(eab/bind-path org-directory)
(eab/bind-path eab/org-publish-directory)
(eab/bind-path eab/org-publish-directory-file)
(eab/bind-path org-link-abbrev-alist)
(eab/bind-path org-id-locations-file)
(eab/bind-path org-clock-persist-file)
(eab/bind-path org-mobile-directory)
(eab/bind-path bibtex-files)
(eab/bind-path org-ditaa-jar-path)

;; (org-mobile-create-sumo-agenda) - Create a file that contains all custom agenda views.

;; TODO move this functionality to eab/bind-path
(if (not (boundp 'eab/org-publish-directory-file))
    (setq eab/org-publish-directory-file "ERROR"))

(if (not (boundp 'eab/org-publish-directory))
    (setq eab/org-publish-directory "ERROR"))

(add-hook 'bibtex-mode-hook (lambda () (bibtex-set-dialect 'BibTeX)))
(add-hook 'grep-mode-hook 'org-link-minor-mode)

;; DONE не помогает! Надо еще какое-то шаманство, чтобы заработали ID на org-store-link по-умолчанию
;; DONE после этой команды (featurep 'org-id) дает nil
(setq org-id-link-to-org-use-id 'create-if-interactive)
;; (require 'org-wikinodes) ;; TODO лезут ошибки, после обновления до 8 версии
(setq org-wikinodes-create-targets 't)

(setq org-bbdb-anniversary-field 'birthday)

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull (concat org-directory "archive/flagged.org"))
(setq org-mobile-files
      (mapcar (lambda (x)
		(concat org-directory "archive/" x))
	      '(
		"refile.org"
		"todo.org"
		)))

(setq org-default-notes-file (concat org-directory "archive/refile.org"))

(setq org-archive-location (concat org-directory "archive/archive.org::* From %s"))
(setq org-archive-mark-done nil)
(setq org-archive-default-command 'org-archive-set-tag)

(setq org-tags-exclude-from-inheritance (quote ("crypt")))
(org-crypt-use-before-save-magic)
(setq org-crypt-key nil)

(setq
 org-capture-templates
 `(
   ("t" "Todo" entry (file ,(concat org-directory "archive/refile.org")) "* TODO %?\n  %u\n  %a\n  %i")
   ("n" "note" entry (file ,(concat org-directory "archive/refile.org")) "* %?              :NOTE:\n  %u\n  %a\n  %i")
   ("N" "NOTCH" entry (file ,(concat org-directory "archive/refile.org")) "* NOTCH %?\n  SCHEDULED: <2013-12-18 Ср. 01:30 .+1y>\n  %u\n  %a")
   ("w" "org-protocol" entry (file ,(concat org-directory "archive/refile.org")) "* Review %c  :NOTE:\n  %U\n  %i" :immediate-finish 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-return-follows-link t)

(add-hook 'org-mode-hook (lambda () (toggle-truncate-lines)))

(setq org-export-default-language "ru")
(setq org-export-with-broken-links 't)


(setq org-completion-use-ido t)

;; TODO обнаружился еще один глюк: в новой нынешней конфигурации, с
;; clock/ каталогом, уровни внутренних файлов начинаются не с первого
;; (т.е. с 3-го или др.), и org-refile просто не работает, глючит
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
(setq org-refile-use-cache 't)

;; Targets start with the file name - allows creating level 1 tasks
;; TODO появился баг, типа невозможности рефайлинга в корень git/org/todo.org\
;; просит уточнить место, а требуется остановиться
;; (setq org-refile-use-outline-path (quote full-file-path))
(setq org-refile-use-outline-path (quote file))

;; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)

(org-clock-persistence-insinuate)
(setq org-clock-history-length 35)
(setq org-clock-in-resume t)
(setq org-clock-in-switch-to-state "STARTED")
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK" "CLOCK")))
(setq org-clock-into-drawer "CLOCK")
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-out-when-done nil)
(setq org-clock-persist t)

(setq org-global-properties
      (quote (("Effort_ALL" . "0:10 0:30 1:00 2:00 4:00 6:00 8:00 12:00 16:00 24:00 40:00"))))

(setq org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM %TAGS")

(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 80)

(setq org-cycle-separator-lines 0)
(setq org-insert-heading-respect-content t)
(setq org-deadline-warning-days 30)

(setq org-log-done (quote time))
(setq org-log-into-drawer t)

(defsubst org-set-local (var value)
  "Make VAR local in current buffer and set it to VALUE."
  (set (make-local-variable var) value))

(provide 'eab-org)
