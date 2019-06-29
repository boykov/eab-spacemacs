;;; keybindings.el ---

;; Copyright (C) 2010-2017 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eab-minimal)
(use-package eab-kbd-ext)

(mapc (lambda (x) (add-to-list 'extended-command-history x))
	'(
	 "tramp-cleanup-this-connection"
	 "eab/create-workgroups"
	 "eab/clear-extended-history"
	 "eab/load-personal"
	 ))

(mapc (lambda (x) (add-to-list 'read-expression-history x))
      '(
	"(setq input-method-function 'key-chord-input-method)"
	"(tramp-term--initialize \"jupiter\")"
	))

(defvar eab/layer0 (make-sparse-keymap)
  "Keymap for minimal configuration")
(general-define-key
 :keymaps 'eab/layer0
 "M-z"		'undo
 "C-b"		'switch-to-buffer
 "M-a"		'execute-extended-command
 "C-t"		'transpose-sexps
 "M-m"		'forward-sexp
 "M-n"		'backward-sexp
 "C-a"		'nil
 "C-a z"	'winner-undo
 "C-a C-z"	'winner-undo
 "C-a Z"	'winner-redo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	     ____ _    	  _    	      _
;;	    / ___| | ___ | |__ 	 __ _| |
;;	   | | 	_| |/ _	\| '_ \	/ _` | |
;;	   | |_| | | (_) | |_) | (_| | |
;;	    \____|_|\___/|_.__/	\__,_|_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global

(general-define-key
 "s-o"		'org-open-at-point
 "C-c a"	'org-agenda
 "C-c C-M-p"	'org-open-at-point-global
 "C-c C-l"	'org-insert-link
 "C-c l"	'org-store-link
 "C-c r"	'org-capture
 "C-x C-M-p"	'org-open-at-point-global
 "s-c"		'org-store-link
 "s-H"		'org-clock-in
 "C-s-h"	'org-clock-out
 "M-z"		'undo
 "C-b"		'switch-to-buffer
 "M-a"		'execute-extended-command
 "C-t"		'transpose-sexps
 "M-m"		'forward-sexp
 "M-n"		'backward-sexp
 "M-q"		'kill-buffer-and-window
 "C-i"		'indent-for-tab-command
 "C-m"		'newline
 "C-@"		'set-mark-command
 "C-M-:"	'isearch-backward-regexp
 "C-M-;"	'isearch-forward-regexp
 "C-S-a"	'eval-expression
 "C-S-b"	'select-frame-by-name
 "C-S-s"	'write-file
 "C-SPC"	'set-mark-command
 "S-SPC"	'nil
 "C-c M-f"	'find-file-at-point
 "C-h C-c"	'describe-command
 "C-h c"	'describe-key-briefly
 "C-k"		'toggle-input-method
 "C-o"		'find-file
 "C-s-i"	'imenu
 "C-s-k"	(lambda (ch) (interactive "c") (insert ch))
 "C-x C-d"	'dired-jump
 "C-v"		'vc-diff
 "C-x C-e"	'eval-defun
 "C-x C-k k"	'kill-region
 "C-x M-f"	'find-file-at-point
 "C-x c"	'customize-variable
 "C-x e"	'eval-last-sexp
 "C-x j"	'comment-region
 "C-x o"	'other-window
 "C-x Q"	'eab/kbd-macro-query
 "C-z"		'repeat
 "M-!"		'delete-window
 "s-0"		'delete-window
 "s-2"		'split-window-below
 "M-%"		'query-replace-regexp
 "M-&"		'count-matches
 "M-'"		'comment-dwim
 "M-<"		'kmacro-start-macro
 "M-,"		'kmacro-end-or-call-macro
 "M-/"		'dabbrev-expand
 "M-1"		'delete-other-windows
 "M-2"		'split-window-vertically
 "M-5"		'query-replace
 "M-:"		'isearch-backward
 "M-;"		'isearch-forward
 "M-@"		'split-window-horizontally
 "M-B"		'backward-kill-sexp
 "M-C"		'copy-all
 "M-H"		'move-end-of-line
 "M-I"		'scroll-down
 "M-J"		'beginning-of-buffer
 "M-K"		'scroll-up
 "M-L"		'end-of-buffer
 "M-M"		'end-of-defun
 "M-N"		'beginning-of-defun
 "M-O"		'forward-paragraph
 "C-S-SPC"	'mark-defun
 "M-S-SPC"	'mark-paragraph
 "M-SPC"	'set-mark-command
 "C-M-@"	'set-rectangular-region-anchor
 "M-U"		'backward-paragraph
 "M-X"		'delete-region
 "M-b"		'kill-sexp
 "M-c"		'kill-ring-save
 "M-e"		'backward-kill-word
 "M-f"		'delete-char
 "M-F"		'delete-backward-char
 "M-g"		'kill-line
 "M-h"		'move-beginning-of-line
 "M-i"		'previous-line
 "M-j"		'backward-char
 "C-M-j"	'delete-backward-char
 "M-k"		'next-line
 "M-l"		'forward-char
 "M-o"		'forward-word
 "M-p"		'move-end-of-line
 "M-r"		'kill-word
 "M-u"		'backward-word
 "M-v"		'yank
 "M-x"		'kill-region
 ;; "M-y"		'god-mode-all
 "s-,"		'kmacro-end-or-call-macro-repeat
 "s-."		nil
 "s-m"		'kmacro-keymap
 "<kp-insert>"	'sauron-pop-to-buffer
 "s-a"		'append-to-buffer)

(general-define-key
 "C-n"	'ergoemacs-new-empty-buffer
 "C-w"	'ergoemacs-compact-uncompact-block
 "M-G"	'ergoemacs-kill-line-backward
 "M-Q"	'ergoemacs-close-current-buffer
 "M-`"	'ergoemacs-switch-to-next-frame
 "M-S"	'ergoemacs-move-cursor-previous-pane
 "M-s"	'ergoemacs-move-cursor-next-pane
 "M-w"	'ergoemacs-shrink-whitespaces
 "M-~"	'ergoemacs-switch-to-previous-frame
 "C-/"	'ergoemacs-toggle-letter-case
 "M-*"	'ergoemacs-select-text-in-quote
 "M-8"	'ergoemacs-extend-selection)

(general-define-key
 "<f9>"         'eab/ansible-copy
 "<f10>"        'eab/flyspell-buffer
 "<f12>"	'eab/make-list-paths
 "<f6>"		'eab/revert-buffer
 "<f7>"		'eab/fix-windows-coding
 "<print>"	'eab/make-list-paths
 "<kp-end>"	(ilam (switch-to-buffer eab/agenda-H-command))
 "C-,"		'eab/eepitch-this-line
 "C-r"		'eab/eepitch-this-line
 "C-M-r"	'eab/eepitch-paragraph
 "M-DEL"	'eab/completion-at-point
 "C-j"		'eab/completion-at-point
 "C-M-g"	'eab/insert-greek
 "C-c RET"	'org-return
 "C-c c"	'eab/add-eab-abbrev
 "C-c d"	'eab/tracker-search
 "C-c g"	'eab/gnugol-search
 "C-c o"	'eab/open-heading-browser
 "C-c O"	'eab/open-corresponding-html
 "C-c s"	'eab/org-agenda-search
 "C-c u"	'eab/unbound-var
 "C-c U"	'eab/unbound-fun
 "C-c v"	'eab/twit-visit
 "C-c w"	'eab/twit-search
 "C-c e"	'eab/edit-list-at-point
 "C-h C-f"	'eab/find-function-at-point
 "C-h C-k"	'eab/describe-key-find
 "C-h C-v"	'eab/find-variable-at-point
 "C-s-j"	'eab/insert-greek
 "C-x b"	'switch-to-buffer
 "C-x C-b"	'ibuffer
 "C-x g"	'eab/grep
 "C-x C-g"	(kbd "C-u C-x g")
 "M-."		'eab/etags-find-or-pop
 "M-A"		'eab/call-shell-command
 "s-v"		'eab/org-insert-link-fast
 "s-h"		'eab/hron-todo)

;; shell and shell-utils
(general-define-key
 "C-c T"	'eab/google-translate
 "C-x T"	'eab/google-translate
 "M-C-b"	'eab/mcb
 "s-f"		'eab/see-file
 "C-S-f"	'eab/gr-status)

(general-define-key
 "s-z"		'org-archive-set-tag
 "s-y"		'yas-minor-mode
 "C-c i"	'yas-expand)

(general-define-key
 "<f8>"		'eepitch-this-line
 "<kp-enter>"	'winner-undo
 "<kp-add>"	(ilam (gnus-group-read-group t t "nnimap+Dovecot:inbox"))
 "<kp-begin>"	'twit
 ;; "<kp-home>" (ilam (switch-to-buffer "&bitlbee"))
 "<M-kp-equal>" (ilam (shell-command "suspend_until.sh 4:00 &"))
 "<kp-delete>"	(ilam (kill-buffer-and-window)))

;; former rcmd
(general-define-key
 "M-z"		'undo-tree-undo
 "C-b"		'eab/cxb
 "M-a"		'eab/smex-limited-commands
 "C-t"		'sp-transpose-sexp
 "M-m"		'sp-forward-sexp
 "M-n"		'sp-backward-sexp
 "M-?"		(ilam (auto-complete))
 "C-S-k"	(ilam (set-input-method nil))
 "s-k"		(ilam (if (equal current-input-method "TeX") (set-input-method "russian-computer") (set-input-method "TeX")))
 "C-s"		(ilam (save-some-buffers 't))
 "C-:"		'isearch-moccur
 "C-c t"	'dictionary-search
 "C-f"		'magit-status
 "C-p"		'er/expand-region
 "C-s-l"	'helm-locate
 "C-x C-k d"	'pm-define
 "C-x C-k e"	'pm-switch-buf
 "C-x G"	'eab/find-grep
 "C-x t"	'dictionary-search
 "M-V"		'helm-show-kill-ring
 "M-Z"		'undo-tree-redo
 "M-d"		'avy-goto-word-1
 "s-Y"		'auto-complete-mode
 "s-g"		'helm-google-suggest
 "s-/"		'ac-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	  _    	      _	_ _    	   _
;;	 | |__ 	_   _(_) | |_  	  (_)_ __
;;	 | '_ \| | | | | | __|____| | '_ \
;;	 | |_) | |_| | | | ||_____| | |	| |
;;	 |_.__/	\__,_|_|_|\__| 	  |_|_|	|_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; built-in

(general-define-key
 :keymaps 'isearch-mode-map
 "M-p"	'nil
 "M-n"	'nil
 "M-y"	'nil
 "M-c"	'nil
 "M-s"	'nil
 "C-y"	'nil
 "C-l"	'nil
 "M-r"	'isearch-edit-string
 "C-e"	'isearch-edit-string
 "M-;"	'isearch-repeat-forward
 "M-:"	'isearch-repeat-backward
 "M-v"	'isearch-yank-kill
 "M-k"	'isearch-ring-advance
 "M-i"	'isearch-ring-retreat
 "C-k"	'isearch-toggle-input-method
 "M-5"	'isearch-query-replace)

(general-define-key
 :keymaps 'minibuffer-local-completion-map
 "C-r"	'nil
 "M-n"	'nil
 "M-p"	'nil
 "M-v"	'nil
 "M-s"	'nil)

;; TODO надо C-y, теперь уже C-l, везде сделать переменной
(general-define-key
 :keymaps 'minibuffer-local-map
 "C-q"		'quoted-insert
 "M-;"		'isearch-backward
 "C-l M-i"	'previous-line
 "C-l M-k"	'next-line
 "M-i"		'previous-history-element
 "M-r"		'nil
 "M-p"		'nil
 "M-n"		'nil
 "M-x"		'nil
 "M-I"		'previous-matching-history-element
 "M-K"		'next-matching-history-element
 "M-v"		'nil)

(general-define-key
 :keymaps 'kmacro-keymap
 "m"	'kmacro-start-macro
 ","	'kmacro-end-or-call-macro-repeat
 "i"	'kmacro-insert-counter
 "s"	'kmacro-set-counter
 "v"	'insert-kbd-macro)

(general-define-key
 :keymaps 'isearch-mode-map
 "M-d" 'eab/isearch-ace-jump)

(general-define-key
 :keymaps 'minibuffer-local-map
 "M-:"		'helm-minibuffer-history
 "M-k"		'next-history-element
 "C-d"		'eab/ace-ibuffer
 "C-|"		'eab/minibuffer-see-file
 "s-SPC"	'eab/ido-see-file
 "M-a"		'eab/smex-extended
 "C-w"		'eab/smex-repeat
 "M-E"		(ilam (delete-minibuffer-contents)))

(general-define-key
 :keymaps 'minibuffer-inactive-mode-map
 "o"	'eab/screen-off
 "e"	'eab/ido-emacs
 "s"	'eab/ido-wmctrl
 "t"	(ilam (eab/gnome-terminal) (suspend-frame))
 "q"	'suspend-frame)

(general-define-key
 :keymaps 'query-replace-map
 "C-e"	'edit
 "C-r"	'delete-and-edit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	 _  __
;;	| |/ /___ _   _	_ __ ___   __ _	_ __  ___
;;	| ' // _ \ | | | '_ ` _	\ / _` | '_ \/ __|
;;	| . \  __/ |_| | | | | | | (_| | |_) \__ \
;;	|_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
;;	       	  |___/	       	       |_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keymaps

(defvar eab/temacs-map (make-sparse-keymap)
  "Keymap for console temacs.")
(global-set-key (kbd "C-l") nil)
(general-define-key
 :prefix "C-l"
 "H"		'org-clock-in
 "C-h"		'org-clock-out
 "c"		'org-store-link
 "M-c"		'org-copy-special
 "M-x"		'org-cut-special
 "M-v"		'org-paste-special
 "p"		'org-priority-up
 "i"		'org-metaup
 "k"		'org-metadown
 "j"		'org-metaleft
 "l"		'org-metaright
 "<backtab>"	'org-content
 "M-k"		'org-shiftdown
 "M-i"		'org-shiftup
 "M-j"		'org-shiftleft
 "M-l"		'org-shiftright
 "K"		'org-shiftmetadown
 "I"		'org-shiftmetaup
 "J"		'org-shiftmetaleft
 "L"		'org-shiftmetaright
 "RET"		'org-meta-return
 "C-<return>"	'org-insert-heading-respect-content
 "C-j"		'org-insert-heading-respect-content
 "C-M-j"	'org-insert-heading-respect-content
 "o"		'org-open-at-point
 "'"		'org-edit-special
 "C-h"		'nil
 "C-s"		'nil
 "b"		'nil
 "w"		'whitespace-mode
 "W"		'subword-mode
 "C-l"		'recenter-top-bottom
 "a"		'append-to-buffer
 "m"		'kmacro-keymap
 ","		'kmacro-end-or-call-macro-repeat
 "x"		'kmacro-keymap
 "M-a"		'eval-expression
 "u"		'rename-uniquely
 "S"		'toggle-truncate-lines
 "d"		'toggle-debug-on-error
 "M-f"		'ispell-change-dictionary
 "F"		'flyspell-mode
 "q"		'ergoemacs-open-last-closed
 "/"		'ergoemacs-toggle-letter-case
 "C-f"		'eab/gr-status
 "h"		'eab/hron-todo
 "M-h"		'eab/send-csum-all-remote
 "v"		'eab/org-insert-link-fast
 "."		(kbd "C-c . RET")
 "M-."		`(,(ilam (execute-kbd-macro (read-kbd-macro "C-c . RET C-l RET C-l l"))) :which-key "")
 "O"		'esc-toggle-window-selectability
 "D"		'toggle-window-dedicated
 "<tab>"	(ilam (progn (show-all) (run-hook-with-args 'org-cycle-hook 'all)))
 "z"		'org-archive-set-tag
 "b"		'bookmark-set
 "n SPC"	'dash-to-space3
 "nf"		'eab/pm-write-last-kbd-macro
 "nd"		'delete-end-clock
 "nn"		'star-to-space2
 "ns"		'split-clock
 "nc"		'insert-clock
 "Y"		'auto-complete-mode
 "g"		'helm-google-suggest
 "y"		'yas-minor-mode
 "P"		'smartparens-global-mode
 ";"		'isearch-moccur
 "r"		'region-bindings-mode
 ;; shell and shell-utils
 "f"		'eab/see-file
 "SPC"		'eab/gr-tag-default-directory
 "M-d"		(ilam (eab/sh-over-bash "~/git/auto/test-dotemacs.sh" "" 't))
 "M-p"		(ilam (let ((shell-command-switch "-ic")) (eab/shell-command "dpemacs")))
 "M-P"		(ilam (eab/shell-command "bash -i -c dpemacs_new"))
 "M-m"		(ilam (eab/sh-over-bash "~/git/auto/firefoxmacro.sh" ""	't)))
(setq eab/temacs-map (lookup-key global-map (kbd "C-l")))

(defvar eab/compile-map (make-sparse-keymap)
  "Compile keymap.")
(global-set-key (kbd "C-d") nil)
(general-define-key
 :prefix "C-d"
 "q"	'eab/nocommand
 "a"	'eab/compile-helm
 "d"	'eab/projectile-compile-project
 "s"	(ilam (smart-compile 4))
 "S"	`(,(ilam (eab/projectile-compile-project-custom "make push_unstaged")) :which-key "")
 "l"	`(,(ilam (TeX-command "LaTeX"	'TeX-master-file)) :which-key "")
 "b"	`(,(ilam (TeX-command "BibTeX"	'TeX-master-file)) :which-key "")
 "L"	`(,(ilam (TeX-command "LaTeX"	'TeX-master-file)) :which-key "")
 "v"	`(,(ilam (eab/switch-wmctrl-window "main.pdf")) :which-key "")
 ;; "b" `(,(ilam (eab/switch-wmctrl-window "BoykovEA_5.pdf")) :which-key "")
 "p"	`(,(ilam (eab/projectile-compile-project-custom "make push_all")) :which-key "")
 "c"	`(,(ilam (eab/projectile-compile-project-custom "make clear")) :which-key "")
 "t"	`(,(ilam (eab/projectile-compile-project-custom "make test")) :which-key "")
 "2"	`(,(ilam (eab/projectile-compile-project-custom "make test2")) :which-key ""))
(setq eab/compile-map (lookup-key global-map (kbd "C-d")))

(defvar eab/one-key-map (make-sparse-keymap)
  "One-key keymap.")
(global-set-key (kbd "C-e") nil)
(general-define-key
 :prefix "C-e"
 "b"	'maplev-cmaple-send-buffer
 "t"	'eab/switch-eepitch-target
 "a"	`(,(ilam (eepitch-ansi-term "1")) :which-key "")
 "1"	`(,(ilam (eepitch-ansi-term "1")) :which-key "")
 "2"	`(,(ilam (eepitch-ansi-term "2")) :which-key "")
 "3"	`(,(ilam (eepitch-ansi-term "3")) :which-key "")
 "4"	`(,(ilam (eepitch-ansi-term "4")) :which-key "")
 "5"	`(,(ilam (eepitch-ansi-term "5")) :which-key "")
 "6"	`(,(ilam (eepitch-ansi-term "6")) :which-key "")
 "7"	`(,(ilam (eepitch-ansi-term "7")) :which-key "")
 "8"	`(,(ilam (eepitch-ansi-term "8")) :which-key "")
 "9"	`(,(ilam (eepitch-ansi-term "9")) :which-key "")
 "c"	'eab/switch-compile
 "x"	'nil
 "h"	'eab/switch-help
 "z"	'undo-tree-visualize
 "s"	'eab/switch-async
 "S"	'eab/switch-shell
 "m"	'eab/switch-message
 "k"	`(,(ilam (eepitch-kill)) :which-key "")
 "o"	'proced
 "g"	'eab/switch-grep
 "G"	'eab/kill-last-grep
 "l"	'helm-locate
 "C"	'docker-containers
 "I"	'docker-images)
(setq eab/one-key-map (lookup-key global-map (kbd "C-e")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO таки приходим постепенно к модальным режимам, как в vim
;; альтернативой может служить специальный minor-mode, в котором
;; нужная функциональность, например навигация org-mode работает
;; вместо обычной на j i k l, а обычная навигация M-i, M-k... временно
;; доступна через более сложные сочетания. Еще вариант - аналогично
;; region-bindings-mode, когда включается minor-mode, в котором
;; сочетания имеют другое значение. Можно использовать прямые хоткеи
;; и, например, J I K L для org-shift.. За основу можно взять
;; https://github.com/edwtjo/evil-org-mode/blob/master/evil-org.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar eab/wg-map (make-sparse-keymap)
  "Keymap for workgroups operations.")
(global-set-key (kbd "C-a") nil)
(general-define-key
 :prefix "C-a"
 "a"		`(,(ilam (eab/wg-switch-to-workgroup ":clock:")) :which-key "apple :clock:")
 "f"		`(,(ilam (eab/wg-switch-to-workgroup ":sync-redmine:")) :which-key "fish :sync-redmine:")
 "t"		`(,(ilam (eab/wg-switch-to-workgroup ":jup:")) :which-key "tree :jup:")
 "e"		`(,(ilam (eab/wg-switch-to-workgroup ":eab-spacemacs:")) :which-key "eagle :eab-spacemacs:")
 "l"		`(,(ilam (eab/wg-switch-to-workgroup ":cc:")) :which-key "lamp :cc:")
 "4"		`(,(ilam (eab/wg-switch-to-workgroup ":mail:")) :which-key "4 :mail:")
 "g"		`(,(ilam (eab/wg-switch-to-workgroup ":gsie:")) :which-key ":gsie:")
 "b"		`(,(ilam (eab/wg-switch-to-workgroup ":fz:")) :which-key ":fz:")
 "j"		`(,(ilam (eab/wg-switch-to-workgroup ":jac:")) :which-key ":jac:")
 "m"		`(,(ilam (eab/wg-switch-to-workgroup ":dbsym:")) :which-key ":dbsym:")
 "C-e"		`(,(ilam (eab/wg-switch-to-workgroup ":dotspace:")) :which-key ":dotspace:")
 "d"		`(,(ilam (eab/wg-switch-to-workgroup ":spacemacs:")) :which-key ":spacemacs:")
 "5"		`(,(ilam (eab/wg-switch-to-workgroup ":ahmed-examples:")) :which-key ":ahmed-examples:")
 "i"		`(,(ilam (eab/wg-switch-to-workgroup ":lit:")) :which-key ":lit:")
 "p"		'eab/wg-switch-to-previous-workgroup
 "o"		'eab/wg-rotate-base
 "O"		'eab/wg-rotate-twice
 "P"		'eab/wg-switch-to-previous-workgroup-1
 "s"		'eab/wg-switch-to-workgroup-history ;; +
 "S"		'wg-switch-to-workgroup ;; +
 "x"		'wg-kill-ring-save-working-config ;; wg-kill-ring-save-working-wconfig
 "v"		'wg-yank-config ;; wg-yank-wconfig
 "r"		'eab/wg-revert-workgroup
 "R"		'wg-revert-workgroup ;; +
 "u"		`(,(ilam (eab/wg-update-workgroup "dflt")) :which-key "") ;; eab/wg-update-workgroup
 "U"		'wg-save-session ;; wg-update-workgroup
 ;;  "S"	'eab/eab-wg-save
 ;;  "L"	'eab/eab-wg-load
 ;; TODO wg-make-workgroups-mode-map
 "z"		'wg-undo-wconfig-change
 "C-z"		'wg-undo-wconfig-change
 "Z"		'wg-redo-wconfig-change
 "n"		'eab/wg-create-workgroup-xxx ;; +
 "N"		'wg-create-workgroup ;; +
 "k"		'wg-kill-workgroup ;; +
 "c"		`(,(ilam (eab/wg-kill-tmp) (wg-clone-workgroup (wg-current-workgroup) ":tmp:")) :which-key "") ;; +
 "SPC"		'eab/wg-revert-and-update
 "w"		'twit
 ;;  "s"	'bmkp-cycle ;; TODO сделать обертку, выбирающую navlist в соответствии с группой
 ;;  "t"	`(,(ilam (bmkp-choose-navlist-of-type "any")) :which-key "")
 ;; DONE по имени буфера: нарушение SPOT!
 "h"		`(,(ilam (switch-to-buffer eab/agenda-H-command)) :which-key "")
 "1"		`(,(ilam (switch-to-buffer eab/agenda-a-command)) :which-key "")
 "W"		`(,(ilam (switch-to-buffer eab/agenda-W-command)) :which-key "")
 "M"		`(,(ilam (switch-to-buffer eab/agenda-M-command)) :which-key "")
 "C-s"		`(,(ilam (switch-to-buffer "*Sauron*")) :which-key ""))
(setq eab/wg-map (lookup-key global-map (kbd "C-a")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	       	   _   	 _     	 _     	       	   _
;;	  __ _ 	__| | __| |    	| |__  	___   ___ | | __
;;	 / _` |/ _` |/ _` |_____| '_ \ / _ \ / _ \| |/ /
;;	| (_| |	(_| | (_| |_____| | | |	(_) | (_) |   <
;;	 \__,_|\__,_|\__,_|    	|_| |_|\___/ \___/|_|\_\
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add-hook

(eab/add-hook textile-mode-hook eab/textile-hook
  (general-define-key
   :keymaps 'textile-mode-map
   "C-i"	'eab/outline-toggle-children
   "<backtab>"	'eab/outline-toggle-all))

(eab/add-hook ssh-config-mode-hook eab/ssh-config-hook
  (general-define-key
   :keymaps 'ssh-config-mode-map
   "C-i"	'eab/outline-toggle-children
   "<backtab>"	'eab/outline-toggle-all))

(eab/add-hook groovy-mode-hook eab/groovy-hook
  (general-define-key
   :keymaps 'groovy-mode-map
   "C-i"	'eab/outline-toggle-children
   "<backtab>"	'eab/outline-toggle-all))

(eab/add-hook git-rebase-mode-hook eab/git-rebase-hook
  (general-define-key
   :keymaps 'git-rebase-mode-map
   "d"  	'git-rebase-kill-line
   "p"  	'git-rebase-pick
   "M-n"	'git-rebase-move-line-down
   "M-p"	'git-rebase-move-line-up))

(eab/add-hook docker-containers-mode-hook eab/docker-containers-hook
  (general-define-key
   :keymaps 'docker-containers-mode-map
   "c"	'eab/tramp-docker-cleanup))

(eab/add-hook rec-mode-hook eab/rec-hook
  )

(eab/add-hook etags-select-mode-hook eab/etags-select-hook
  )

;; DONE это ведь то же самое, что просто вызов (eab/free-map git-commit-mode-map)
(eab/add-hook git-commit-mode-hook eab/git-commit-hook
  (eab/free-map git-commit-mode-map))

(eab/add-hook proced-mode-hook eab/proced-hook
  (general-define-key
   :keymaps 'proced-mode-map
   "O"	'top))

(defadvice top-mode (after eab-javascript-mode-after activate)
  (general-define-key
   :keymaps 'top-mode-map
   "O"	(ilam (switch-to-buffer "*Proced*"))))

(eab/add-hook bibtex-mode-hook eab/bibtex-hook
  (general-define-key
   :keymaps 'bibtex-mode-map
   "C-M-\\"	'bibtex-fill-entry))

(eab/add-hook ediff-after-setup-control-frame-hook eab/ediff-hook
  (general-define-key
   :keymaps 'ediff-mode-map
   "d"	'nil))

(eab/add-hook fortran-mode-hook eab/fortran-hook
  (general-define-key
   :keymaps 'fortran-mode-map
   "C-d"	eab/compile-map))

(eab/add-hook ag-mode-hook eab/ag-hook
  (general-define-key
   :keymaps 'ag-mode-map
   "C-w"	'eab/wgrep-change-to-wgrep-mode))

(eab/add-hook wdired-mode-hook eab/wdired-hook
  (general-define-key
   :keymaps 'wdired-mode-map
   "s-w"	'wdired-finish-edit))

(eab/add-hook flyspell-mode-hook eab/flyspell-hook
  (general-define-key
   :keymaps 'flyspell-mode-map
   "C-k"	'toggle-input-method))

(eab/add-hook text-mode-hook eab/text-hook
  (general-define-key
   :keymaps 'text-mode-map
   "C-c C-c"	'server-edit))

;; DONE does it really work? Only back
(eab/add-hook dictionary-mode-hook eab/dictionary-hook
  (general-define-key
   :keymaps 'dictionary-mode-map
   "B"	'eab/help-mode-back))

(defadvice artist-mode (before eab-artist-mode activate)
  (general-define-key
   :keymaps 'artist-mode-map
   "C-b"	'nil))

(eab/add-hook markdown-mode-hook eab/markdown-hook
  (general-define-key
   :keymaps 'markdown-mode-map
   "C-M-b"	'nil
   "C-M-f"	'nil
   "M-l"	'nil
   "M-i"	'nil
   "M-n"	'nil
   "M-p"	'nil
   "<tab>"	'nil))

(eab/add-hook ibuffer-mode-hook eab/ibuffer-hook
  (general-define-key
   :keymaps 'ibuffer-mode-map
   "C-d"	'nil
   "C-k"	'nil
   "C-o"	'nil
   "C-y"	'nil
   "M-g"	'nil
   "M-j"	'nil
   "M-n"	'nil
   "M-o"	'nil
   "M-p"	'nil
   "M-s"	'nil))

(eab/add-hook magit-mode-hook eab/magit-hook
  (general-define-key
   :keymaps 'magit-log-mode-map
   "C-l M-n"	'log-edit-next-comment
   "C-l M-p"	'log-edit-previous-comment
   "M-n"	'nil
   "M-p"	'nil
   "C-d"	'nil)
  (general-define-key
   :keymaps 'magit-revision-mode-map
   "C-d"	'nil)
  (general-define-key
   :keymaps 'magit-status-mode-map
   "C-d"	'nil)
  ;;  "C-f"	'magit-show-only-files
  ;;  "C-F"	'magit-show-only-files-all
  (general-define-key
   :keymaps 'magit-mode-map
   "J"		'magit-commit-amend
   "R"		(kbd "r - A e o r i g i n / m a s t e r RET")
   "N"		(kbd "P o m a s t e r 2*RET")
   "Q"		(ilam (shell-command "git add GA-* GRP-* CRKO-* SUP* CS-* QB* CHR3-* PRSL-* PLTF-* LIME-* AVD-* CHRR-* PEAR-*"))
   "{"		(ilam (execute-kbd-macro (read-kbd-macro "S ESC A g i t SPC c o 2*m i t SPC - m SPC u p d a t e RET g")))
   "M-n"	'nil
   "M-p"	'nil
   "M-s"	'nil
   "M-S"	'nil
   "M-h"	'nil
   "M-H"	'nil
   "M-1"	'nil
   "M-2"	'nil
   "M-g"	'magit-fetch-all
   "C-d"	'nil
   "C-D"	'magit-section-show-level-4-all
   "s-1"	'magit-section-show-level-1-all
   "s-2"	'magit-section-show-level-2-all
   "<backtab>"	'magit-section-show-level-2-all
   "s-3"	'magit-section-show-level-3-all
   "s-4"	'magit-section-show-level-4-all))

(eab/add-hook nroff-mode-hook eab/nroff-hook
  (general-define-key
   :keymaps 'nroff-mode-map
   "M-s"	'nil
   "M-n"	'nil
   "M-p"	'nil))

(eab/add-hook twittering-edit-mode-hook eab/twittering-edit-hook
  (general-define-key
   :keymaps 'twittering-edit-mode-map
   "C-l M-p"	'twittering-edit-previous-history
   "C-l M-n"	'twittering-edit-next-history
   "M-p"	'nil
   "M-n"	'nil))

(eab/add-hook eshell-mode-hook eab/eshell-hook
  (general-define-key
   :keymaps 'eshell-mode-map
   "M-s"	'nil
   "M-s"	'nil))

(eab/add-hook shell-mode-hook eab/shell-hook
  (general-define-key
   :keymaps 'shell-mode-map
   "M-p"	'nil
   "M-n"	'nil))

;; TODO плохая зависимость от eab/free-map, которая может еще не
;; существовать на момент вызова (log-edit-mode) в ergoemacs-mode
;; это даже при запуске (el-get 'sync eab/el-get-sources)
;; (eab/add-hook log-edit-mode-hook eab/log-edit-hook
;;   (eab/free-map log-edit-mode-map))

;; (eab/add-hook erc-mode-hook eab/erc-hook
;;   (general-define-key
;;    :keymaps 'erc-mode-map
;;    "C-l M-n" 'erc-next-command
;;    "C-l M-p" 'erc-previous-command
;;    "C-a"	'nil
;;    "M-n"	'nil
;;    "M-p"	'nil))

;; (general-define-key
;;  :keymaps 'popup-isearch-keymap
;;  "C-k"	(ilam (insert "л")))

(eab/add-hook auto-complete-mode-hook eab/ac-complete-mode-hook
  (general-define-key
   :keymaps 'ac-completing-map
   "\C-s"	'ac-isearch)
  (general-define-key
   :keymaps 'ac-complete-mode-map
   "M-c"	'ac-expand-common
   "M-k"	'ac-next
   "M-i"	'ac-previous))

(eab/add-hook bookmark-bmenu-mode-hook eab/bookmark-bmenu-mode-hook
  (general-define-key
   :keymaps 'bookmark-bmenu-mode-map
   "M-s"	'nil
   "M-l"	'nil
   "M-m"	'nil
   "M-a"	'nil
   "M-d"	'nil
   "M-u"	'nil
   "M-I"	'nil
   "C-d"	'nil
   "C-o"	'nil
   "M-~"	'nil
   "M-a"	'nil
   "M-c"	'nil
   "M-L"	'nil
   "M-m"	'nil
   "M-o"	'nil
   "M-q"	'nil
   "M-r"	'nil
   "M-t"	'nil
   "SPC"	'bmkp-describe-bookmark
   "M-X"	'nil))

(eab/add-hook moccur-mode eab/moccur-hook
  (general-define-key
   :keymaps 'moccur-mode-map
   "M-n"	'nil
   "M-p"	'nil
   "M-m"	'nil
   "M-d"	'nil))

(eab/add-hook orgtbl-mode-hook eab/orgtbl-mode-hook
  (general-define-key
   :keymaps 'orgtbl-mode-map
   "M-a"	'nil))

(eab/add-hook org-mode-hook eab/org-hook
  (general-define-key
   :keymaps 'org-mode-map
   "M-D"		'ace-link-org
   "C-d"		eab/compile-map
   "<f6>"		'eab/revert-buffer
   "s-'"		'org-edit-src-code
   "s-k"		'org-metadown
   "s-i"		'org-metaup
   "s-p"		'org-priority-up
   "s-j"		'org-metaleft
   "s-l"		'org-metaright
   "s-K"		'org-shiftmetadown
   "s-I"		'org-shiftmetaup
   "s-J"		'org-shiftmetaleft
   "s-L"		'org-shiftmetaright
   "s-<return>"		'org-insert-heading
   "s-S-<return>"	'org-insert-todo-heading
   "M-s-k"		'org-shiftdown
   "M-s-i"		'org-shiftup
   "M-s-j"		'org-shiftleft
   "M-s-l"		'org-shiftright
   "C-y"		'nil
   "C-e"		'nil
   "C-,"		'nil
   "C-SPC"		'nil
   "M-a"		'nil
   "M-e"		'nil
   "C-a"		'nil
   "C-k"		'nil
   "M-h"		'org-beginning-of-line
   "M-p"		'org-end-of-line
   "M-g"		'org-kill-line
   "M-v"		'org-yank
   "M-RET"		(ilam (org-insert-heading nil))
   "M-N"		'org-backward-sentence
   "M-M"		'org-forward-sentence
   "C-M-u"		'outline-previous-visible-heading
   "C-M-o"		'outline-next-visible-heading
   "s-u"		'org-preview-latex-fragment
   "C-c C-x M-c"	'org-copy-special
   "C-c C-x M-x"	'org-cut-special
   "C-c C-x M-v"	'org-paste-special
   "s-x M-c"		'org-copy-special
   "s-x M-x"		'org-cut-special
   "s-x M-v"		'org-paste-special
   "s-."		(kbd "C-c . RET"))

  (key-chord-define org-mode-map "jj" 'org-edit-src-code)
  (key-chord-define org-src-mode-map "jj" 'org-edit-src-exit)

  (general-define-key
   :keymaps 'org-src-mode-map
   "s-'"	'org-edit-src-exit
   "C-l '"	'org-edit-src-exit)

  (general-define-key
   :keymaps 'org-agenda-mode-map
   "M-j"	'nil
   "M-l"	'nil
   "C-p"	'nil
   "C-n"	'nil
   "C-k"	'nil
   "s"		'flx-isearch-forward
   "M-g"	'org-agenda-kill
   "M-k"	'org-agenda-next-line
   "M-i"	'org-agenda-previous-line))

(eab/add-hook comint-mode-hook eab/coming-hook
  (general-define-key
   :keymaps 'comint-mode-map
   "M-p"	'comint-previous-matching-input-from-input
   "M-n"	'comint-next-matching-input-from-input
   "C-M-n"	'comint-next-input
   "C-M-p"	'comint-previous-input))

(eab/add-hook diff-mode-hook eab/diff-hook
  (general-define-key
   :keymaps 'diff-mode-map
   "M-SPC"	'nil
   "M-1"	'nil
   "M-2"	'nil
   "M-5"	'nil
   "M-k"	'nil
   "M-<"	'nil
   "M->"	'nil
   "M-K"	'nil
   "M-h"	'nil
   "M-n"	'nil
   "M-N"	'nil
   "M-o"	'nil
   "M-p"	'nil))

(eab/add-hook f90-mode-hook eab/f90-hook
  (general-define-key
   :keymaps 'f90-mode-map
   "C-j"	'nil
   "C-d"	eab/compile-map))

(eab/add-hook twittering-mode-hook eab/twittering-hook
  (general-define-key
   :keymaps 'twittering-mode-map
   "u"		'eab/twittering-update-status-interactive
   "d"		'ace-link-info
   "M-v"	'nil
   "C-v"	'nil
   "@"		'eab/twit-filter
   "f"		'twittering-follow
   "r"		'twittering-retweet
   "R"		'twittering-toggle-or-retrieve-replied-statuses
   "F"		'twittering-favorite
   "s-f"	'twittering-friends-timeline
   "s-r"	'twittering-replies-timeline
   "s-u"	'twittering-user-timeline
   "s-d"	'twittering-direct-messages-timeline
   "s-s"	'twittering-update-status-interactive
   "s-e"	'twittering-erase-old-statuses
   "s-m"	'twittering-retweet
   "s-t"	'twittering-set-current-hashtag
   "C-m"	'twittering-enter
   "s-l"	'twittering-update-lambda))

(eab/add-hook slime-repl-mode-hook eab/slime-repl-hook
  (general-define-key
   :keymaps 'slime-repl-mode-map
   "M-n"	'nil
   "M-p"	'nil
   "M-r"	'nil
   "M-s"	'nil
   "C-a"	'nil
   "C-A"	'nil
   "C-l M-p"	'slime-repl-previous-input
   "C-l M-n"	'slime-repl-next-input))

(eab/add-hook maxima-mode-hook eab/maxima-hook
  (general-define-key
   :keymaps 'maxima-mode-map
   "C-M-a"	'nil
   "C-M-b"	'nil
   "C-M-e"	'nil
   "C-M-f"	'nil
   "M-;"	'nil
   "C-d"	eab/compile-map
   "M-h"	'nil))

(eab/add-hook slime-mode-hook eab/slime-hook
  (general-define-key
   :keymaps 'slime-mode-map
   "M-p"	'nil
   "M-n"	'nil))

(eab/add-hook message-mode-hook eab/message-hook
  (general-define-key
   :keymaps 'message-mode-map
   "C-c C-c"	'eab/message-send
   "M-;"	'nil
   "M-n"	'nil))

(eab/add-hook makefile-gmake-mode-hook eab/makefile-gmake-mode
  (general-define-key
   :keymaps 'makefile-gmake-mode-map
   "\C-d"	eab/compile-map
   "M-n"	'nil
   "M-p"	'nil))

(eab/add-hook nxml-mode-hook eab/nxml-mode
  (general-define-key
   :keymaps 'nxml-mode-map
   "M-h"	'nil))

(eab/add-hook term-mode-hook eab/term-hook
  (general-define-key
   :keymaps 'term-mode-map
   "M-q"	'nil
   "M-s"	'nil
   "M-n"	'nil
   "M-p"	'nil
   "C-r"	(ilam (term-send-raw-string "\C-r"))
   "<tab>"	'eab/wrap-tab
   "C-p"	'term-previous-input
   "C-n"	'term-next-input)

  (key-chord-define term-mode-map "jj" 'term-char-mode)
  (key-chord-define term-raw-map "jj" 'term-line-mode)

  (general-define-key
   :keymaps 'term-raw-map
   "M-a"	'nil
   "M-A"	'nil
   "M-q"	'nil
   "M-Q"	'nil
   "M-v"	'nil
   "M-g"	'nil
   "M-V"	'nil
   "M-z"	'nil
   "M-s"	'nil
   "C-b"	'nil
   "C-a"	'nil
   "C-e"	'nil
   "C-o"	'nil
   "C-h"	'nil
   "M-1"	'nil
   "C-r"	'term-send-raw
   "C-l"	eab/temacs-map
   "M-h"	'term-send-home
   "M-p"	'term-send-end
   "M-j"	'term-send-left
   "M-l"	'term-send-right
   "M-k"	'term-send-up
   "M-i"	'term-send-down
   "C-p"	'term-send-up
   "C-n"	'term-send-down))

(eab/add-hook comint-mode-hook eab/comint-hook
  (general-define-key
   :keymaps 'comint-mode-map
   "M-s"	'nil
   "M-p"	'nil
   "M-n"	'nil
   "M-r"	'nil
   "C-p"	'comint-previous-input
   "C-n"	'comint-next-input))

(eab/add-hook compilation-mode-hook eab/compilation-hook
  (general-define-key
   :keymaps 'compilation-button-map
   "M-RET"	'eab/compile-goto-error-same-window
   "RET"	'eab/compile-goto-error)
  (general-define-key
   :keymaps 'compilation-mode-map
   "g"		'eab/recompile
   "B"		'compilation-a-lot-goto-prev
   "F"		'compilation-a-lot-goto-next
   "\C-d"	eab/compile-map
   "\C-o"	'nil
   "M-k"	'nil
   "M-p"	'nil
   "M-i"	'nil
   "M-n"	'nil))

(eab/add-hook grep-mode-hook eab/grep-hook
  (general-define-key
   :keymaps 'grep-mode-map
   "B"		'eab/switch-grep-prev
   "F"		'eab/switch-grep-next
   "C-o"	'nil
   "M-p"	'nil
   "M-RET"	'eab/compile-goto-error-same-window
   "C-M-j"	'eab/compile-goto-error-same-window
   "RET"	'eab/compile-goto-error
   "g"		'eab/recompile
   "u"		'eab/grep-utf
   "M-n"	'nil
   "C-w"	'eab/wgrep-change-to-wgrep-mode))

(eab/add-hook gnus-started-hook eab/gnus-article-hook
  (general-define-key
   :keymaps 'gnus-article-mode-map
   "M-g"	'nil
   "M-u"	'nil
   "M-*"	'nil
   "M-n"	'nil
   "C-c C-v"	'gnus-article-browse-html-article))

(eab/add-hook gnus-started-hook eab/gnus-summary-hook
  (general-define-key
   :keymaps 'gnus-summary-mode-map
   "g"		'eab/gnus-inbox
   "RET"	'gnus-summary-show-article
   "A o"	'gnus-summary-insert-old-articles
   "M-I"	'nil
   "M-i"	'nil
   "M-k"	'nil
   "M-K"	'nil
   "M-s"	'nil
   "M-p"	'nil
   "M-n"	'nil
   "\C-c\C-w"	'gnus-summary-move-article
   "m"		'gnus-summary-mark-as-processable
   "x"		'gnus-summary-delete-article
   "u"		'gnus-summary-unmark-as-processable))

(eab/add-hook gnus-started-hook eab/gnus-group-hook
  (general-define-key
   :keymaps 'gnus-group-mode-map
   "RET"	'eab/gnus-group-select
   "M-d"	'nil
   "M-k"	'nil
   "M-n"	'nil))

(eab/add-hook dired-mode-hook eab/dired-hook
  (general-define-key
   :keymaps 'dired-mode-map
   "C-M-b"	'nil
   "M-a"	'nil
   "M-i"	'nil
   "M-j"	'nil
   "C-n"	'nil
   "M-c"	'nil
   "M-g"	'nil
   "M-G"	'nil
   "M-v"	'nil
   "M-!"	'nil
   "M-l"	'nil
   "M-p"	'nil
   "M-o"	'nil
   "M-s"	'nil
   "M-u"	'nil
   "M-m"	'nil
   "C-o"	'nil
   "C-p"	'nil
   "C-k"	'nil
   "C-S-a"	'nil
   "C-c C-w"	'dired-do-rename
   "C-w"	'wdired-change-to-wdired-mode
   "b"		'browse-url-of-dired-file
   "o"		'dired-find-file-other-window
   "C-|"	'eab/dired-see-file
   "s-SPC"	'eab/dired-see-file
   "E"		'ediff-files
   "SPC"	'open-in-external-app))

(eab/add-hook java-mode-hook eab/java-hook
  (general-define-key
   :keymaps 'java-mode-map
   "M-M"	'c-end-of-defun
   "M-N"	'c-beginning-of-defun
   "M-j"	'nil
   "M-e"	'nil))

(eab/add-hook c-mode-hook eab/c-hook
  (general-define-key
   :keymaps 'c-mode-map
   "C-d"	eab/compile-map
   "C-M-a"	'nil
   "C-M-e"	'nil
   "M-a"	'nil
   "M-M"	'nil
   "M-N"	'nil
   "M-j"	'nil
   "M-q"	'nil
   "M-M"	'c-end-of-defun
   "M-N"	'c-beginning-of-defun
   "M-e"	'nil))

(eab/add-hook c++-mode-hook eab/c++-hook
  (general-define-key
   :keymaps 'c++-mode-map
   "C-d"	eab/compile-map
   "C-M-a"	'nil
   "C-M-e"	'nil
   "M-a"	'nil
   "M-M"	'nil
   "M-N"	'nil
   "M-j"	'nil
   "M-q"	'nil
   "M-M"	'c-end-of-defun
   "M-N"	'c-beginning-of-defun
   "M-e"	'nil))

(eab/add-hook w3m-mode-hook eab/w3m-hook
  (general-define-key
   :keymaps 'w3m-mode-map
   "M-d"	'nil
   "M-k"	'nil
   "M-l"	'nil
   "M-i"	'nil
   "M-a"	'nil
   "M-s"	'nil
   "M-g"	'nil))

(eab/add-hook helm-before-initialize-hook eab/helm-hook
  (general-define-key
   :keymaps 'helm-map
   "C-k"	'toggle-input-method
   "M-H"	'helm-select-2nd-action-or-end-of-line
   "M-g"	'helm-delete-minibuffer-contents
   "s-SPC"	'eab/helm-select-action
   "C-|"	'eab/helm-select-action
   "M-j"	'nil
   "M-v"	'nil
   "M-l"	'nil
   "M-k"	'helm-next-line
   "M-i"	'helm-previous-line
   "C-n"	'next-history-element
   "C-p"	'previous-history-element
   "C-SPC"	'helm-toggle-visible-mark
   "M-K"	'helm-next-page
   "M-J"	'helm-beginning-of-buffer
   "M-L"	'helm-end-of-buffer
   "M-I"	'helm-previous-page)
  (general-define-key
   :keymaps 'helm-generic-files-map
   "M-i"	'helm-previous-line))

(eab/add-hook ido-minibuffer-setup-hook eab/ido-minibuffer-hook
  (general-define-key
   :keymaps 'ido-file-dir-completion-map
   "M-v"	'yank)
  (general-define-key
   :keymaps 'ido-file-completion-map
   "C-n"	(eab/do-action (ilam (execute-kbd-macro (read-kbd-macro "C-x C-f / 2*s h : k a i r o s - h o s t | s u d o : k a i r o s - h o s t : / C-x Q"))))
   "C-d"	'eab/ace-ibuffer
   "C-|"	'eab/ido-see-file
   "s-SPC"	'eab/ido-see-file)
  (general-define-key
   :keymaps 'ido-common-completion-map
   "C-v"	'eab/toggle-cxb-ido-item
   "C-d"	'eab/ace-ibuffer
   "C-b"	'eab/ido-wmctrl)
  (general-define-key
   :keymaps 'ido-buffer-completion-map
   "C-k"	'nil
   "C-d"	'eab/ace-ibuffer
   "C-d"	'ido-buffer-helm
   "M-RET"	'eab/ido-main
   "C-M-j"	'eab/ido-main
   "C-b"	'eab/ido-wmctrl))

(eab/add-hook emacs-lisp-mode-hook eab/emacs-lisp-hook
  (general-define-key
   :keymaps 'emacs-lisp-mode-map
   "s-r"	'paredit-raise-sexp
   "s-L"	'paredit-forward-barf-sexp
   "s-J"	'paredit-backward-barf-sexp
   "s-l"	'paredit-forward-slurp-sexp
   "s-j"	'paredit-backward-slurp-sexp
   "s-I"	'paredit-splice-sexp
   "s-K"	'paredit-splice-sexp
   "s-i"	'paredit-splice-sexp-killing-backward
   "s-k"	'paredit-splice-sexp-killing-forward
   "M-("	'paredit-wrap-round
   "M-r"	'paredit-forward-kill-word
   "M-e"	'paredit-backward-kill-word
   "M-g"	'paredit-kill
   "M-'"	'paredit-comment-dwim
   "RET"	'paredit-newline))

(eab/add-hook smartparens-enabled-hook eab/smartparens-hook
  (general-define-key
   :keymaps 'sp-keymap
   "/"	'nil
   "b"	'sp--self-insert-command ;; for latex sp-local-tag
   "B"	'nil
   "f"	'nil
   "g"	'nil
   "h"	'nil
   "l"	'nil
   "t"	'nil
   "i"	'nil
   "e"	'nil
   "r"	'nil
   "к"	'nil))

(eab/add-hook multiple-cursors-mode-enabled-hook eab/multiple-cursors-hook
  (general-define-key
   :keymaps 'mc/keymap
   "M-K"	'mc/cycle-forward
   "M-I"	'mc/cycle-backward
   "M-v"	'nil
   "C-v"	'nil))

(eab/add-hook LaTeX-mode-hook eab/LaTeX-hook
  (general-define-key
   :keymaps 'LaTeX-mode-map
   "M-m"	'forward-sexp
   "C-d"	'nil
   "C-S-d"	eab/compile-map))

(eab/add-hook graphviz-dot-mode-hook eab/graphviz-hook
  (general-define-key
   :keymaps 'graphviz-dot-mode-map
   "C-d"	eab/compile-map)
  (set (make-local-variable 'compile-command) nil))

(eab/add-hook ruby-mode-hook eab/ruby-hook
  (general-define-key
   :keymaps 'ruby-mode-map
   "C-d"	eab/compile-map
   "C-M-b"	'nil))

(eab/add-hook python-mode-hook eab/python-hook
  (general-define-key
   :keymaps 'python-mode-map
   "C-d"	eab/compile-map
   "C-j"	'nil
   "M-RET"	'newline
   "RET"	'newline
   "C-h C-f"	'jedi:goto-definition))

(eab/add-hook maplev-mode-hook eab/maplev-hook
  (general-define-key
   :keymaps 'maplev-mode-map
   "C-c d"	'maplev-help-at-point
   "C-k"	'toggle-input-method))

(eab/add-hook help-mode-hook eab/help-hook
  (general-define-key
   :keymaps 'help-mode-map
   "o"	'ace-link-help
   "B"	'help-go-back
   "F"	'help-go-forward
   "F"	'nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	       	       _       	       	 _
;;	 _ __  	___   |	|__   ___   ___	| | __
;;	| '_ \ / _ \  |	'_ \ / _ \ / _ \| |/ /
;;	| | | |	(_) | |	| | | (_) | (_)	|   <
;;	|_| |_|\___/  |_| |_|\___/ \___/|_|\_\
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; no hook

(defadvice region-bindings-mode-on (before eab-region-bindings-mode-on activate)
  (progn
    (setq region-bindings-mode-disabled-modes '(magit-status-mode magit-diff-mode))
    (general-define-key
     :keymaps 'region-bindings-mode-map
     "u"	'untabify
     "г"	'untabify
     "0"	(ilam (eab/or-self-insert-body (er/expand-region 0)))
     "p"	(ilam (eab/or-self-insert-body (er/expand-region 1)))
     "-"	(ilam (eab/or-self-insert-body (er/expand-region -1)))
     "P"	(ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-paragraph))))
     "З"	(ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-paragraph))))
     "I"	(ilam (eab/or-self-insert 'indent-region))
     "Ш"	(ilam (eab/or-self-insert 'indent-region))
     "d"	(ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-defun))))
     "/"	(ilam (let ((this-command 'ergoemacs-toggle-letter-case)) (eab/or-self-insert 'ergoemacs-toggle-letter-case)))
     "r"	(ilam (eab/or-self-insert 'string-rectangle))
     "к"	(ilam (eab/or-self-insert 'string-rectangle))
     "t"	(ilam (eab/or-self-insert 'anchored-transpose))
     ;; TODO C-g неправильно работает с region-bindings-mode
     ;; "C-g"	(ilam (eab/or-self-insert 'mc/keyboard-quit))
     "g"	(ilam (eab/or-self-insert 'mc/keyboard-quit))
     "п"	(ilam (eab/or-self-insert 'mc/keyboard-quit))
     "G"	(ilam (eab/or-self-insert 'google))
     "П"	(ilam (eab/or-self-insert 'google))
     "l"	(ilam (eab/or-self-insert 'eab/replace-selection))
     "д"	(ilam (eab/or-self-insert 'eab/replace-selection))
     "s"	(ilam (eab/or-self-insert 'gnugol-search-selection))
     "ы"	(ilam (eab/or-self-insert 'gnugol-search-selection))
     "e"	'mc/edit-lines
     "у"	'mc/edit-lines
     "x"	(ilam (eab/or-self-insert 'kill-rectangle))
     "ч"	(ilam (eab/or-self-insert 'kill-rectangle)) ;; TODO возможные проблемы с раскладками
     "A"	(ilam
		 (eab/or-self-insert-body
		  (save-restriction
		    (narrow-to-region (window-start) (window-end))
		    (ignore-errors (mc/mark-all-like-this)))))
     "a"	'mc/mark-all-like-this
     "i"	'mc/mark-previous-like-this
     "ш"	'mc/mark-previous-like-this
     "k"	'mc/mark-next-like-this
     "л"	'mc/mark-next-like-this
     "m"	'mc/mark-more-like-this-extended)))
