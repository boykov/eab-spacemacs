;;; eab-org.el --- 

;; Copyright (C) 2010-2025 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;; (unload-feature 'org 't)
(require 'org)
(require 'org-clock)
;; (require 'org-checklist)
(require 'org-crypt)
(require 'remember)
(require 'org-capture)
(require 'org-id)
(require 'org-archive)
(require 'ol-bbdb)
(require 'ox-latex)
(require 'ox-extra)
(require 'ox-html)

(require 'tex)
(require 'tex-site)

(setq org-odt-display-outline-level 1)

(eab/patch-this-code
 'org-clocktable-write-default
 '(("(and total-time (> total-time 0))" .
    "(and total-time (>= total-time 0))"))
 :lexical 't
 :native 't)

(eab/patch-this-code
 'org-clock-sum
 '(("(or (> t1 0) (> (aref ltimes level) 0))" .
    "(or (>= t1 0) (> (aref ltimes level) 0))"))
 :lexical 't
 :native 't)

(eab/patch-this-code
 'org-clock-get-table-data
 '(("(> time 0)" .
    "(>= time 0)")
   ("file:%s::%s" .
    "id:%s")
   ("(buffer-file-name) search" .
    "(save-match-data (org-id-get-create))"))
 :lexical 't
 :native 't)

(eab/patch-this-code
 'org-html-section
 '(("text-%s" .
    "ID-%s")
   ("or (org-element-property :CUSTOM_ID parent)" .
    "or (org-element-property :ID parent)
                    (org-element-property :CUSTOM_ID parent)"))
 :lexical 't
 :native 't)

(eab/patch-this-code
 'org-html--format-image
 '(("org-html-close-tag" .
    "")
   ("\"img\"" .
    "let* ((ext (file-name-extension source))
         (prefix (if (string= \"svg\" ext) \"embed\" \"img\")))
    (org-html-close-tag
     prefix")
   ("info))" .
    "info)))"))
 :lexical 't
 :native 't)

(eab/patch-this-code
 'org-html-statistics-cookie
 '(("<code>%s</code>" .
    "<span class=\\\\\"stat\\\\\">%s</span>")
   ("(org-element-property :value statistics-cookie)" .
    "(substring (org-element-property :value statistics-cookie) 1 -1)"))
 :lexical 't
 :native 't)

;; (defun org-html-statistics-cookie (statistics-cookie _contents _info)
;;   "Transcode a STATISTICS-COOKIE object from Org to HTML.
;; CONTENTS is nil.  INFO is a plist holding contextual information."
;;   (let ((cookie-value (substring (org-element-property :value statistics-cookie) 1 -1)))
;;     (format "<span class=\"stat\">%s</span>" cookie-value)))

(eab/bind-path org-directory)
(eab/bind-path eab/org-publish-directory)
(eab/bind-path eab/org-publish-directory-file)
(eab/bind-path org-link-abbrev-alist)
(eab/bind-path org-id-locations-file)
(eab/bind-path org-clock-persist-file)
(eab/bind-path org-mobile-directory)
(eab/bind-path bibtex-files)
(eab/bind-path org-ditaa-jar-path)

(ox-extras-activate '(ignore-headlines))

;; (org-mobile-create-sumo-agenda) - Create a file that contains all custom agenda views.

;; TODO move this functionality to eab/bind-path
(unless (boundp 'eab/org-publish-directory-file)
  (setq eab/org-publish-directory-file "ERROR"))

(unless (boundp 'eab/org-publish-directory)
  (setq eab/org-publish-directory "ERROR"))

(add-hook 'bibtex-mode-hook (lambda () (bibtex-set-dialect 'BibTeX)))
(add-hook 'grep-mode-hook 'org-link-minor-mode)
(add-hook 'ag-mode-hook 'org-link-minor-mode)

(with-eval-after-load 'org-ctags (setq org-open-link-functions nil))
(setq org-adapt-indentation nil)

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
(setq org-tags-column -72)
;; (org-crypt-use-before-save-magic)
(setq org-crypt-key nil)

(setq
 org-capture-templates
 `(
   ("t" "Todo" entry (file ,(concat org-directory "archive/refile.org")) "* TODO %?\n  %u\n  %a\n  %i")
   ("n" "note" entry (file ,(concat org-directory "archive/refile.org")) "* %?              :NOTE:\n  %u\n  %a\n  %i")
   ("w" "org-protocol" entry (file ,(concat org-directory "archive/refile.org")) "* Review %c  :NOTE:\n  %U\n  %i" :immediate-finish 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-return-follows-link t)
(defun eab/org-return (&optional arg)
  (interactive "P")
  (if arg
      (let ((org-link-frame-setup (quote ((file . find-file)))))
        (org-return))
    (org-return)))

(add-hook 'org-mode-hook (lambda () (toggle-truncate-lines)))
(add-hook 'org-mode-hook (lambda () (if (and (fboundp 'org-fold-hide-drawer-all) (not (eab/ondaemon "kairosC"))) (org-fold-hide-drawer-all))))

(setq org-export-default-language "ru")
(setq org-export-with-broken-links 't)


(setq org-completion-use-ido t)

;; TODO обнаружился еще один глюк: в новой нынешней конфигурации, с
;; clock/ каталогом, уровни внутренних файлов начинаются не с первого
;; (т.е. с 3-го или др.), и org-refile просто не работает, глючит
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
(setq org-refile-use-cache 't)

;; Targets start with the file name - allows creating level 1 tasks
;; TODO появился баг, типа невозможности рефайлинга в корень org-directory/todo.org\
;; просит уточнить место, а требуется остановиться
;; (setq org-refile-use-outline-path (quote full-file-path))
(setq org-refile-use-outline-path (quote file))

;; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)

(org-clock-persistence-insinuate)
(setq org-clock-history-length 35)
(setq org-clock-in-resume t)
(setq org-clock-in-switch-to-state "STARTED")
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

(setq org-startup-folded 'content)


(defun wvxvw/export-rel-url (path desc format)
  (cl-case format
    (html (format "<a href=\"%s\">%s</a>" path (or desc path)))
    (latex (format "\\href{%s}{%s}" path (or desc path)))
    (otherwise path)))

(org-add-link-type "rel" 'browse-url 'wvxvw/export-rel-url)

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
)

(defun org-mark-paragraph (&optional arg allow-extend)
  (interactive "p\np")
  (unless arg (setq arg 1))
  (when (zerop arg)
    (error "Cannot mark zero paragraphs"))
  (cond ((and allow-extend
              (or (and (eq last-command this-command) (mark t))
                  (and transient-mark-mode mark-active)))
         (set-mark
          (save-excursion
            (goto-char (mark))
            (org-forward-paragraph arg)
            (point))))
        (t
         (org-forward-paragraph arg)
         (push-mark nil t t)
         (org-backward-paragraph arg))))

(defun eab/org-forward-element-parent ()
  (interactive)
  (let* ((el (plist-get (cadr (org-element-at-point)) :parent))
         (begin (plist-get (cadr el) :begin))
         (end (plist-get (cadr el) :end)))
    (when (and begin end)
      (goto-char end))))

(defun eab/org-forward-page ()
  (interactive)
  (let ((page-delimiter "⚓"))
    (forward-page)
    (while (or (org-in-src-block-p 't)
               (org-in-block-p '("quote")))
      (forward-page))))

(defun eab/org-backward-page ()
  (interactive)
  (let ((page-delimiter "⚓"))
    (backward-page)
    (while (or (org-in-src-block-p 't)
               (org-in-block-p '("quote")))
      (backward-page))))

(defun eab/org-forward-paragraph ()
  (interactive)
  (forward-page)
  (while (or (org-in-src-block-p 't)
             (org-in-block-p '("quote")))
    (forward-page)))

(defun eab/org-backward-paragraph ()
  (interactive)
  (backward-page)
  (while (or (org-in-src-block-p 't)
              (org-in-block-p '("quote")))
    (backward-page)))

(provide 'eab-org)
