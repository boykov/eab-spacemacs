(use-package eab-kbd)

(defvar eab/layer0 (make-sparse-keymap)
  "Keymap for minimal configuration")
(general-define-key
 :keymaps 'eab/layer0
 "M-z" 'undo
 "C-b" 'switch-to-buffer
 "M-a" 'execute-extended-command
 "C-t" 'transpose-sexps
 "M-m" 'forward-sexp
 "M-n" 'backward-sexp
 "C-a" nil
 "C-a z" 'winner-undo
 "C-a C-z" 'winner-undo
 "C-a Z" 'winner-redo)

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
 "s-o" 'org-open-at-point
 "C-c a" 'org-agenda
 "C-c C-M-p" 'org-open-at-point-global
 "C-c C-l" 'org-insert-link
 "C-c l" 'org-store-link
 "C-c r" 'org-capture
 "C-x C-M-p" 'org-open-at-point-global
 "s-c" 'org-store-link
 "s-H" 'org-clock-in
 "C-s-h" 'org-clock-out
 "M-z" 'undo
 "C-b" 'switch-to-buffer
 "M-a" 'execute-extended-command
 "C-t" 'transpose-sexps
 "M-m" 'forward-sexp
 "M-n" 'backward-sexp
 "M-q" 'kill-buffer-and-window
 "C-i" 'indent-for-tab-command
 "C-m" 'newline
 "C-@" 'set-mark-command
 "C-M-:" 'isearch-backward-regexp
 "C-M-;" 'isearch-forward-regexp
 "C-S-a" 'eval-expression
 "C-S-b" 'select-frame-by-name
 "C-S-s" 'write-file
 "C-SPC" 'set-mark-command
 "S-SPC" 'nil
 "C-c M-f" 'find-file-at-point
 "C-h C-c" 'describe-command
 "C-h c" 'describe-key-briefly
 "C-k" 'toggle-input-method
 "C-o" 'find-file
 "C-s-i" 'imenu
 "C-s-k" (lambda (ch) (interactive "c") (insert ch))
 "C-x C-d" 'dired-jump
 "C-v" 'vc-diff
 "C-x C-e" 'eval-defun
 "C-x C-k k" 'kill-region
 "C-x M-f" 'find-file-at-point
 "C-x c" 'customize-variable
 "C-x e" 'eval-last-sexp
 "C-x j" 'comment-region
 "C-x o" 'other-window
 "C-z" 'repeat
 "M-!" 'delete-window
 "s-0" 'delete-window
 "s-2" 'split-window-below
 "M-%" 'query-replace-regexp
 "M-&" 'count-matches
 "M-'" 'comment-dwim
 "M-<" 'kmacro-start-macro
 "M-," 'kmacro-end-or-call-macro
 "M-/" 'dabbrev-expand
 "M-1" 'delete-other-windows
 "M-2" 'split-window-vertically
 "M-5" 'query-replace
 "M-:" 'isearch-backward
 "M-;" 'isearch-forward
 "M-@" 'split-window-horizontally
 "M-B" 'backward-kill-sexp
 "M-C" 'copy-all
 "M-H" 'move-end-of-line
 "M-I" 'scroll-down
 "M-J" 'beginning-of-buffer
 "M-K" 'scroll-up
 "M-L" 'end-of-buffer
 "M-M" 'end-of-defun
 "M-N" 'beginning-of-defun
 "M-O" 'forward-paragraph
 "C-S-SPC" 'mark-defun
 "M-S-SPC" 'mark-paragraph
 "M-SPC" 'set-mark-command
 "M-U" 'backward-paragraph
 "M-X" 'delete-region
 "M-b" 'kill-sexp
 "M-c" 'kill-ring-save
 "M-e" 'backward-kill-word
 "M-f" 'delete-char
 "M-F" 'delete-backward-char
 "M-g" 'kill-line
 "M-h" 'move-beginning-of-line
 "M-i" 'previous-line
 "M-j" 'backward-char
 "C-M-j" 'delete-backward-char
 "M-k" 'next-line
 "M-l" 'forward-char
 "M-o" 'forward-word
 "M-p" 'move-end-of-line
 "M-r" 'kill-word
 "M-u" 'backward-word
 "M-v" 'yank
 "M-x" 'kill-region
 "M-y" 'god-mode-all
 "s-," 'kmacro-end-or-call-macro-repeat
 "s-." nil
 "s-m" 'kmacro-keymap
 "<kp-insert>" 'sauron-pop-to-buffer
 "s-a" 'append-to-buffer)

(general-define-key
 "C-n" 'ergoemacs-new-empty-buffer
 "C-w" 'ergoemacs-compact-uncompact-block
 "M-G" 'ergoemacs-kill-line-backward
 "M-Q" 'ergoemacs-close-current-buffer
 "M-`" 'ergoemacs-switch-to-next-frame
 "M-S" 'ergoemacs-move-cursor-previous-pane
 "M-s" 'ergoemacs-move-cursor-next-pane
 "M-w" 'ergoemacs-shrink-whitespaces
 "M-~" 'ergoemacs-switch-to-previous-frame
 "C-/" 'ergoemacs-toggle-letter-case
 "M-*" 'ergoemacs-select-text-in-quote
 "M-8" 'ergoemacs-extend-selection)

(general-define-key
 "<f12>" 'eab/make-list-paths
 "<f6>" 'eab/revert-buffer
 "<print>" 'eab/make-list-paths
 "<kp-end>" (ilam (switch-to-buffer eab/agenda-H-command))
 "C-," 'eab/eepitch-this-line
 "C-r" 'eab/eepitch-this-line
 "M-DEL" 'eab/completion-at-point
 "C-j" 'eab/completion-at-point
 "C-M-g" 'eab/insert-greek
 "C-c c" 'eab/add-eab-abbrev
 "C-c d" 'eab/tracker-search
 "C-c g" 'eab/gnugol-search
 "C-c o" 'eab/open-heading-browser
 "C-c O" 'eab/open-corresponding-html
 "C-c s" 'eab/org-agenda-search
 "C-c u" 'eab/unbound-var
 "C-c U" 'eab/unbound-fun
 "C-c v" 'eab/twit-visit
 "C-c w" 'eab/twit-search
 "C-c e" 'eab/edit-list-at-point
 "C-h C-f" 'eab/find-function-at-point
 "C-h C-k" 'eab/describe-key-find
 "C-h C-v" 'eab/find-variable-at-point
 "C-s-j" 'eab/insert-greek
 "C-x b" 'switch-to-buffer
 "C-x g" 'eab/grep
 "C-x C-g" (kbd "C-u C-x g")
 "M-." 'eab/etags-find-or-pop
 "M-A" 'eab/call-shell-command
 "s-v" 'eab/org-insert-link-fast
 "s-h" 'eab/hron-todo)

;; shell and shell-utils
(general-define-key
 "C-c T" 'eab/google-translate
 "C-x T" 'eab/google-translate
 "M-C-b" 'eab/mcb
 "s-f" 'eab/see-file
 "C-S-f" 'eab/gr-status)

(general-define-key
 "s-z" 'org-archive-set-tag
 "s-y" 'yas-minor-mode
 "C-c i" 'yas-expand)

(general-define-key
 "<f8>" 'eepitch-this-line
 "<kp-enter>" 'winner-undo
 "<kp-add>" (ilam (gnus-group-read-group t t "nnimap+Dovecot:inbox"))
 "<kp-begin>" 'twit
 ;; "<kp-home>" (ilam (switch-to-buffer "&bitlbee"))
 "<M-kp-equal>" (ilam (shell-command "suspend_until.sh 4:00 &"))
 "<kp-delete>" (ilam (kill-buffer-and-window)))

;; former rcmd
(general-define-key
 "M-z" 'undo-tree-undo
 "C-b" 'eab/cxb
 "M-a" 'eab/smex-limited-commands
 "C-t" 'sp-transpose-sexp
 "M-m" 'sp-forward-sexp
 "M-n" 'sp-backward-sexp
 "M-?" (ilam (auto-complete))
 "C-S-k" (ilam (set-input-method nil))
 "s-k" (ilam (if (equal current-input-method "TeX") (set-input-method "russian-computer") (set-input-method "TeX")))
 "C-s" (ilam (save-some-buffers 't))
 "C-:" 'isearch-moccur
 "C-c t" 'dictionary-search
 "C-f" 'magit-status
 "C-p" 'er/expand-region
 "C-s-l" 'helm-locate
 "C-x C-k d" 'pm-define
 "C-x C-k e" 'pm-switch-buf
 "C-x G" 'moccur-grep
 "C-x t" 'dictionary-search
 "M-V" 'helm-show-kill-ring
 "M-Z" 'undo-tree-redo
 "M-d" 'avy-goto-word-1
 "s-Y" 'auto-complete-mode
 "s-g" 'helm-google-suggest
 "s-/" 'ac-start)

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
 "M-p" 'nil
 "M-n" 'nil
 "M-y" 'nil
 "M-c" 'nil
 "M-s" 'nil
 "C-y" 'nil
 "C-l" 'nil
 "M-r" 'isearch-edit-string
 "C-e" 'isearch-edit-string
 "M-;" 'isearch-repeat-forward
 "M-:" 'isearch-repeat-backward
 "M-v" 'isearch-yank-kill
 "M-k" 'isearch-ring-advance
 "M-i" 'isearch-ring-retreat
 "C-k" 'isearch-toggle-input-method
 "M-5" 'isearch-query-replace)

(general-define-key
 :keymaps 'minibuffer-local-completion-map
 "C-r" 'nil
 "M-n" 'nil
 "M-p" 'nil
 "M-v" 'nil
 "M-s" 'nil)

;; TODO надо C-y, теперь уже C-l, везде сделать переменной
(general-define-key
 :keymaps 'minibuffer-local-map
 "C-q" 'quoted-insert
 "M-;" 'isearch-backward
 "C-l M-i" 'previous-line
 "C-l M-k" 'next-line
 "M-i" 'previous-history-element
 "M-r" 'nil
 "M-p" 'nil
 "M-n" 'nil
 "M-x" 'nil
 "M-I" 'previous-matching-history-element
 "M-K" 'next-matching-history-element
 "M-v" 'nil)

(general-define-key
 :keymaps 'kmacro-keymap
 "m" 'kmacro-start-macro
 "," 'kmacro-end-or-call-macro-repeat
 "i" 'kmacro-insert-counter
 "s" 'kmacro-set-counter
 "v" 'insert-kbd-macro)

(general-define-key
 :keymaps 'isearch-mode-map
 "M-d" 'eab/isearch-ace-jump)

(general-define-key
 :keymaps 'minibuffer-local-map
 "M-:" 'helm-minibuffer-history
 "M-k" 'next-history-element
 "C-d" 'eab/ace-ibuffer
 "C-|" 'eab/minibuffer-see-file
 "s-SPC" 'eab/ido-see-file
 "M-a" 'eab/smex-extended
 "C-w" 'eab/smex-repeat
 "M-E" (ilam (delete-minibuffer-contents)))

(general-define-key
 :keymaps 'minibuffer-inactive-mode-map
 "o" 'eab/screen-off
 "e" 'eab/ido-emacs
 "s" 'eab/ido-wmctrl
 "t" (ilam (eab/gnome-terminal) (suspend-frame))
 "q" 'suspend-frame)

(general-define-key
 :keymaps 'query-replace-map
 "C-e" 'edit
 "C-r" 'delete-and-edit)

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
 "H" 'org-clock-in
 "C-h" 'org-clock-out
 "c" 'org-store-link
 "M-c" 'org-copy-special
 "M-x" 'org-cut-special
 "M-v" 'org-paste-special
 "p" 'org-priority-up
 "i" 'org-metaup
 "k" 'org-metadown
 "j" 'org-metaleft
 "l" 'org-metaright
 "<backtab>" 'org-content
 "M-k" 'org-shiftdown
 "M-i" 'org-shiftup
 "M-j" 'org-shiftleft
 "M-l" 'org-shiftright
 "K" 'org-shiftmetadown
 "I" 'org-shiftmetaup
 "J" 'org-shiftmetaleft
 "L" 'org-shiftmetaright
 "RET" 'org-meta-return
 "C-<return>" 'org-insert-heading-respect-content
 "C-j" 'org-insert-heading-respect-content
 "C-M-j" 'org-insert-heading-respect-content
 "o" 'org-open-at-point
 "'" 'org-edit-special
 "C-h" 'nil
 "C-s" 'nil
 "b" 'nil
 "w" 'whitespace-mode
 "W" 'subword-mode
 "C-l" 'recenter-top-bottom
 "a" 'append-to-buffer
 "m" 'kmacro-keymap
 "," 'kmacro-end-or-call-macro-repeat
 "x" 'kmacro-keymap
 "M-a" 'eval-expression
 "u" 'rename-uniquely
 "S" 'toggle-truncate-lines
 "d" 'toggle-debug-on-error
 "M-f" 'ispell-change-dictionary
 "F" 'flyspell-mode
 "q" 'ergoemacs-open-last-closed
 "/" 'ergoemacs-toggle-letter-case
 "C-f" 'eab/gr-status
 "h" 'eab/hron-todo
 "M-h" 'eab/send-csum-all-remote
 "v" 'eab/org-insert-link-fast
 "." (kbd "C-c . RET")
 "M-." (kbd "C-c . RET C-l RET C-l l")
 "O" 'esc-toggle-window-selectability
 "D" 'toggle-window-dedicated
 "<tab>" (ilam (progn (show-all) (run-hook-with-args 'org-cycle-hook 'all)))
 "z" 'org-archive-set-tag
 "b" 'bookmark-set
 "n SPC" 'dash-to-space3
 "nf" 'eab/pm-write-last-kbd-macro
 "nd" 'delete-end-clock
 "nn" 'star-to-space2
 "ns" 'split-clock
 "nc" 'insert-clock
 "Y" 'auto-complete-mode
 "g" 'helm-google-suggest
 "y" 'yas-minor-mode
 "P" 'smartparens-global-mode
 ";" 'isearch-moccur
 "r" 'region-bindings-mode
 ;; shell and shell-utils
 "f" 'eab/see-file
 "SPC" 'eab/gr-tag-default-directory
 "M-d" (ilam (eab/sh-over-bash "~/git/auto/test-dotemacs.sh" "" 't))
 "M-p" (ilam (let ((shell-command-switch "-ic")) (eab/shell-command "dpemacs")))
 "M-P" (ilam (eab/shell-command "bash -i -c dpemacs_new"))
 "M-m" (ilam (eab/sh-over-bash "~/git/auto/firefoxmacro.sh" "" 't)))
(setq eab/temacs-map (lookup-key global-map (kbd "C-l")))

(defvar eab/compile-map (make-sparse-keymap)
  "Compile keymap.")
(global-set-key (kbd "C-d") nil)
(general-define-key
 :prefix "C-d"
 "q" 'eab/nocommand
 "a" 'eab/compile-helm
 "d" 'projectile-compile-project
 "s" 'smart-compile
 "l" `(,(ilam (TeX-command "LaTeX" 'TeX-master-file)) :which-key "")
 "b" `(,(ilam (TeX-command "BibTeX" 'TeX-master-file)) :which-key "")
 "L" `(,(ilam (TeX-command "LaTeX" 'TeX-master-file)) :which-key "")
 "v" `(,(ilam (eab/switch-wmctrl-window "main.pdf")) :which-key "")
 ;; "b" `(,(ilam (eab/switch-wmctrl-window "BoykovEA_5.pdf")) :which-key "")
 "p" 'eab/ido-wmctrl-pdf
 "c" `(,(ilam (execute-kbd-macro (read-kbd-macro "C-d d ESC SPC ESC h ESC X make SPC clear RET"))) :which-key "")
 "t" `(,(ilam (execute-kbd-macro (read-kbd-macro "C-d d ESC SPC ESC h ESC X make SPC test RET"))) :which-key "")
 "2" `(,(ilam (execute-kbd-macro (read-kbd-macro "C-d d ESC SPC ESC h ESC X make SPC test2 RET"))) :which-key ""))
(setq eab/compile-map (lookup-key global-map (kbd "C-d")))

(defvar eab/one-key-map (make-sparse-keymap)
  "One-key keymap.")
(global-set-key (kbd "C-e") nil)
(general-define-key
 :prefix "C-e"
 "b" 'maplev-cmaple-send-buffer
 "t" 'eab/switch-eepitch-target
 "a" `(,(ilam (eepitch-ansi-term "1")) :which-key "")
 "1" `(,(ilam (eepitch-ansi-term "1")) :which-key "")
 "2" `(,(ilam (eepitch-ansi-term "2")) :which-key "")
 "3" `(,(ilam (eepitch-ansi-term "3")) :which-key "")
 "4" `(,(ilam (eepitch-ansi-term "4")) :which-key "")
 "5" `(,(ilam (eepitch-ansi-term "5")) :which-key "")
 "6" `(,(ilam (eepitch-ansi-term "6")) :which-key "")
 "7" `(,(ilam (eepitch-ansi-term "7")) :which-key "")
 "8" `(,(ilam (eepitch-ansi-term "8")) :which-key "")
 "9" `(,(ilam (eepitch-ansi-term "9")) :which-key "")
 "c" 'eab/switch-compile
 "x" 'nil
 "h" 'eab/switch-help
 "z" 'undo-tree-visualize
 "s" 'eab/switch-async
 "p" 'eepitch-python
 "P" 'eepitch-php
 "i" 'eepitch-ipython
 "m" 'eab/switch-message
 "k" `(,(ilam (eepitch-kill)) :which-key "")
 "M" 'eepitch-maxima
 "@" 'eepitch-maple
 "f" 'eepitch-shell-cluster
 "o" 'proced
 "-" 'eepitch-sage-python
 "g" 'eab/switch-grep
 "G" 'eab/kill-last-grep
 "l" 'helm-locate
 "C" 'docker-containers
 "I" 'docker-images)
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
 ;;  "b" `(,(ilam (switch-to-buffer "&bitlbee")) :which-key "")
 "g" `(,(ilam (eab/wg-switch-to-workgroup ":gsie:")) :which-key "")
 "f" `(,(ilam (eab/wg-switch-to-workgroup ":ccfebras:")) :which-key "")
 "b" `(,(ilam (eab/wg-switch-to-workgroup ":abiem:")) :which-key "")
 "j" `(,(ilam (eab/wg-switch-to-workgroup ":jac:")) :which-key "")
 "t" `(,(ilam (eab/wg-switch-to-workgroup ":testbed:")) :which-key "")
 "m" `(,(ilam (eab/wg-switch-to-workgroup ":dbsym:")) :which-key "")
 "C-e" `(,(ilam (eab/wg-switch-to-workgroup ":dotspace:")) :which-key "")
 "e" `(,(ilam (eab/wg-switch-to-workgroup ":eab-spacemacs:")) :which-key "")
 "d" `(,(ilam (eab/wg-switch-to-workgroup ":spacemacs:")) :which-key "")
 "l" `(,(ilam (eab/wg-switch-to-workgroup ":cc:")) :which-key "")
 "a" `(,(ilam (eab/wg-switch-to-workgroup ":clock:")) :which-key ":clock:")
 "4" `(,(ilam (eab/wg-switch-to-workgroup ":mail:")) :which-key "")
 "5" `(,(ilam (eab/wg-switch-to-workgroup ":ahmed-examples:")) :which-key "")
 "i" `(,(ilam (eab/wg-switch-to-workgroup ":lit:")) :which-key "")
 "p" 'eab/wg-switch-to-previous-workgroup
 "o" 'eab/wg-rotate-base
 "P" 'eab/wg-switch-to-previous-workgroup-1
 "s" 'eab/wg-switch-to-workgroup-history ;; +
 "S" 'wg-switch-to-workgroup ;; +
 "x" 'wg-kill-ring-save-working-config ;; wg-kill-ring-save-working-wconfig
 "v" 'wg-yank-config ;; wg-yank-wconfig
 "r" 'eab/wg-revert-workgroup
 "R" 'wg-revert-workgroup ;; +
 "u" 'eab/wg-update-workgroup ;; eab/wg-update-workgroup
 "U" 'wg-save-session ;; wg-update-workgroup
 ;;  "S" 'eab/eab-wg-save
 ;;  "L" 'eab/eab-wg-load
 ;; TODO wg-make-workgroups-mode-map
 "z" 'wg-undo-wconfig-change
 "C-z" 'wg-undo-wconfig-change
 "Z" 'wg-redo-wconfig-change
 "n" 'eab/wg-create-workgroup-xxx ;; +
 "N" 'wg-create-workgroup ;; +
 "k" 'wg-kill-workgroup ;; +
 "c" `(,(ilam (eab/wg-kill-tmp) (wg-clone-workgroup (wg-current-workgroup) ":tmp:")) :which-key "") ;; +
 "SPC" 'eab/wg-revert-and-update
 "w" 'twit
 ;;  "e" `(,(ilam (eab/twit-search "emacs")) :which-key "")
 "[" `(,(ilam (eab/twit-search "хазин")) :which-key "")
 "]" `(,(ilam (eab/twit-search "фурсов")) :which-key "")
 ;;  "s" 'bmkp-cycle ;; TODO сделать обертку, выбирающую navlist в соответствии с группой
 ;;  "t" `(,(ilam (bmkp-choose-navlist-of-type "any")) :which-key "")
 ;; DONE по имени буфера: нарушение SPOT!
 "h" `(,(ilam (switch-to-buffer eab/agenda-H-command)) :which-key "")
 "1" `(,(ilam (switch-to-buffer eab/agenda-a-command)) :which-key "")
 "W" `(,(ilam (switch-to-buffer eab/agenda-W-command)) :which-key "")
 "M" `(,(ilam (switch-to-buffer eab/agenda-M-command)) :which-key "")
 "C-s" `(,(ilam (switch-to-buffer "*Sauron*")) :which-key ""))
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

(eab/add-hook docker-containers-mode-hook eab/docker-containers-hook
  (general-define-key
   :keymaps 'docker-containers-mode-map
   "c" 'eab/tramp-docker-cleanup))
