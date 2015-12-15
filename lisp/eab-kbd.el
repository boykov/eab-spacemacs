;;; eab-kbd.el --- 

;; Copyright (C) 2010-2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'eab-minimal)
(require 'eab-kbd-ext)

(defvar eab/temacs-map (make-sparse-keymap)
  "Keymap for console temacs.")

(define-key eab/temacs-map (kbd "H") 'org-clock-in)
(define-key eab/temacs-map (kbd "C-h") 'org-clock-out)
(define-key eab/temacs-map (kbd "c") 'org-store-link)
(define-key eab/temacs-map (kbd "M-c") 'org-copy-special)
(define-key eab/temacs-map (kbd "M-x") 'org-cut-special)
(define-key eab/temacs-map (kbd "M-v") 'org-paste-special)
(define-key eab/temacs-map (kbd "p") 'org-priority-up)
(define-key eab/temacs-map (kbd "i") 'org-metaup)
(define-key eab/temacs-map (kbd "k") 'org-metadown)
(define-key eab/temacs-map (kbd "j") 'org-metaleft)
(define-key eab/temacs-map (kbd "l") 'org-metaright)
(define-key eab/temacs-map (kbd "<backtab>") 'org-content)
(define-key eab/temacs-map (kbd "M-k") 'org-shiftdown)
(define-key eab/temacs-map (kbd "M-i") 'org-shiftup)
(define-key eab/temacs-map (kbd "M-j") 'org-shiftleft)
(define-key eab/temacs-map (kbd "M-l") 'org-shiftright)
(define-key eab/temacs-map (kbd "K") 'org-shiftmetadown) ;; temacs
(define-key eab/temacs-map (kbd "I") 'org-shiftmetaup)
(define-key eab/temacs-map (kbd "J") 'org-shiftmetaleft)
(define-key eab/temacs-map (kbd "L") 'org-shiftmetaright)
(define-key eab/temacs-map (kbd "RET") 'org-meta-return)
(define-key eab/temacs-map (kbd "C-<return>") 'org-insert-heading-respect-content)
(define-key eab/temacs-map (kbd "C-j") 'org-insert-heading-respect-content)
(define-key eab/temacs-map (kbd "C-M-j") 'org-insert-heading-respect-content)
(define-key eab/temacs-map (kbd "o") 'org-open-at-point)
(define-key eab/temacs-map (kbd "'") 'org-edit-special) ;; temacs

(define-key eab/temacs-map (kbd "C-h") 'nil)
(define-key eab/temacs-map (kbd "C-s") 'nil)
(define-key eab/temacs-map (kbd "b") 'nil)
(define-key eab/temacs-map (kbd "w") 'whitespace-mode)
(define-key eab/temacs-map (kbd "W") 'subword-mode)
(define-key eab/temacs-map (kbd "C-l") 'recenter-top-bottom)
(define-key eab/temacs-map (kbd "a") 'append-to-buffer)
(define-key eab/temacs-map (kbd "m") 'kmacro-keymap)
(define-key eab/temacs-map (kbd ",") 'kmacro-end-or-call-macro-repeat) ;; temacs
(define-key eab/temacs-map (kbd "x") 'kmacro-keymap)
(define-key eab/temacs-map (kbd "M-a") 'eval-expression)  ;; temacs
(define-key eab/temacs-map (kbd "u") 'rename-uniquely)
(define-key eab/temacs-map (kbd "S") 'toggle-truncate-lines) ;; temacs
(define-key eab/temacs-map (kbd "d") 'toggle-debug-on-error)
(define-key eab/temacs-map (kbd "M-f") 'ispell-change-dictionary)
(define-key eab/temacs-map (kbd "F") 'flyspell-mode)

;; (global-set-key (kbd "C-y") 'helm-complex-command-history)
;; (global-set-key (kbd "C-y") eab/temacs-map)
(global-set-key (kbd "C-l") eab/temacs-map)

(global-set-key (kbd "s-o") 'org-open-at-point)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c C-M-p") 'org-open-at-point-global)
(global-set-key (kbd "C-c C-l") 'org-insert-link)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c r") 'org-capture)
(global-set-key (kbd "C-x C-M-p") 'org-open-at-point-global)
(global-set-key (kbd "s-c") 'org-store-link)
(global-set-key (kbd "s-H") 'org-clock-in)
(global-set-key (kbd "C-s-h") 'org-clock-out)
(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "C-b") 'switch-to-buffer)
(global-set-key (kbd "M-a") 'execute-extended-command)
(global-set-key (kbd "C-t") 'transpose-sexps)
(global-set-key (kbd "M-m") 'forward-sexp)
(global-set-key (kbd "M-n") 'backward-sexp)
(global-set-key (kbd "M-q") 'kill-buffer-and-window)
(global-set-key (kbd "C-i") 'indent-for-tab-command) ;; for TAB
(global-set-key (kbd "C-m") 'newline) ;; for RET
(global-set-key (kbd "C-@") 'set-mark-command)
(global-set-key (kbd "C-M-:") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-;") 'isearch-forward-regexp)
(global-set-key (kbd "C-S-a") 'eval-expression) ;; temacs
(global-set-key (kbd "C-S-b") 'select-frame-by-name)
(global-set-key (kbd "C-S-s") 'write-file)  ;; temacs
(global-set-key (kbd "C-SPC") 'set-mark-command)
(global-set-key (kbd "S-SPC") 'nil)
(global-set-key (kbd "C-c M-f") 'find-file-at-point)
(global-set-key (kbd "C-h C-c") 'describe-command)
(global-set-key (kbd "C-h c") 'describe-key-briefly)
(global-set-key (kbd "C-k") 'toggle-input-method)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-s-i") 'imenu)  ;; temacs
(global-set-key (kbd "C-s-k") (lambda (ch) (interactive "c") (insert ch)))
(global-set-key (kbd "C-x C-d") 'dired-jump)
(global-set-key (kbd "C-v") 'vc-diff)
(global-set-key (kbd "C-x C-e") 'eval-defun)
(global-set-key (kbd "C-x C-k k") 'kill-region)
(global-set-key (kbd "C-x M-f") 'find-file-at-point)
(global-set-key (kbd "C-x c") 'customize-variable)
(global-set-key (kbd "C-x e") 'eval-last-sexp)
(global-set-key (kbd "C-x j") 'comment-region)
(global-set-key (kbd "C-x o") 'other-window)
(global-set-key (kbd "C-z") 'repeat)
(global-set-key (kbd "M-!") 'delete-window)
(global-set-key (kbd "s-0") 'delete-window)
(global-set-key (kbd "s-2") 'split-window-below)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "M-&") 'count-matches)
(global-set-key (kbd "M-'") 'comment-dwim)
(global-set-key (kbd "M-<") 'kmacro-start-macro)
(global-set-key (kbd "M-,") 'kmacro-end-or-call-macro)
(global-set-key (kbd "M-/") 'dabbrev-expand)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-5") 'query-replace)
(global-set-key (kbd "M-:") 'isearch-backward)
(global-set-key (kbd "M-;") 'isearch-forward)
(global-set-key (kbd "M-@") 'split-window-horizontally)
(global-set-key (kbd "M-B") 'backward-kill-sexp)
(global-set-key (kbd "M-C") 'copy-all)
(global-set-key (kbd "M-H") 'move-end-of-line)
(global-set-key (kbd "M-I") 'scroll-down)
(global-set-key (kbd "M-J") 'beginning-of-buffer)
(global-set-key (kbd "M-K") 'scroll-up)
(global-set-key (kbd "M-L") 'end-of-buffer)
(global-set-key (kbd "M-M") 'end-of-defun)
(global-set-key (kbd "M-N") 'beginning-of-defun)
(global-set-key (kbd "M-O") 'forward-paragraph)
(global-set-key (kbd "C-S-SPC") 'mark-defun)
(global-set-key (kbd "M-S-SPC") 'mark-paragraph)
(global-set-key (kbd "M-SPC") 'set-mark-command)
(global-set-key (kbd "M-U") 'backward-paragraph)
(global-set-key (kbd "M-X") 'delete-region)
(global-set-key (kbd "M-b") 'kill-sexp)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-e") 'backward-kill-word)
(global-set-key (kbd "M-f") 'delete-char)
(global-set-key (kbd "M-F") 'delete-backward-char)
(global-set-key (kbd "M-g") 'kill-line)
(global-set-key (kbd "M-h") 'move-beginning-of-line)
(global-set-key (kbd "M-i") 'previous-line)
(global-set-key (kbd "M-j") 'backward-char)
(global-set-key (kbd "C-M-j") 'delete-backward-char)
(global-set-key (kbd "M-k") 'next-line)
(global-set-key (kbd "M-l") 'forward-char)
(global-set-key (kbd "M-o") 'forward-word)
(global-set-key (kbd "M-p") 'move-end-of-line)
(global-set-key (kbd "M-r") 'kill-word)
(global-set-key (kbd "M-u") 'backward-word)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-x") 'kill-region)
(global-set-key (kbd "s-,") 'kmacro-end-or-call-macro-repeat)
(global-set-key (kbd "s-.") nil)
(global-set-key (kbd "s-m") 'kmacro-keymap)
(global-set-key (kbd "s-a") 'append-to-buffer)

(global-set-key (kbd "C-a") nil)
(global-set-key (kbd "C-a z") 'winner-undo)
(global-set-key (kbd "C-a C-z") 'winner-undo)
(global-set-key (kbd "C-a Z") 'winner-redo)

(define-key isearch-mode-map (kbd "M-p") 'nil)
(define-key isearch-mode-map (kbd "M-n") 'nil)
(define-key isearch-mode-map (kbd "M-y") 'nil)
(define-key isearch-mode-map (kbd "M-c") 'nil)
(define-key isearch-mode-map (kbd "M-s") 'nil)
(define-key isearch-mode-map (kbd "C-y") 'nil)
(define-key isearch-mode-map (kbd "C-l") 'nil)
(define-key isearch-mode-map (kbd "M-r") 'isearch-edit-string)
(define-key isearch-mode-map (kbd "C-e") 'isearch-edit-string)
(define-key isearch-mode-map (kbd "M-;") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "M-:") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "M-v") 'isearch-yank-kill)
(define-key isearch-mode-map (kbd "M-k") 'isearch-ring-advance)
(define-key isearch-mode-map (kbd "M-i") 'isearch-ring-retreat)
(define-key isearch-mode-map (kbd "C-k") 'isearch-toggle-input-method)
(define-key isearch-mode-map (kbd "M-5") 'isearch-query-replace)

(define-key minibuffer-local-completion-map (kbd "C-r") 'nil)
(define-key minibuffer-local-completion-map (kbd "M-n") 'nil)
(define-key minibuffer-local-completion-map (kbd "M-p") 'nil)
(define-key minibuffer-local-completion-map (kbd "M-v") 'nil)
(define-key minibuffer-local-completion-map (kbd "M-s") 'nil)

(define-key minibuffer-local-map (kbd "C-q") 'quoted-insert)
(define-key minibuffer-local-map (kbd "M-;") 'isearch-backward)
;; TODO надо C-y, теперь уже C-l, везде сделать переменной
(define-key minibuffer-local-map (kbd "C-l M-i") 'previous-line)
(define-key minibuffer-local-map (kbd "C-l M-k") 'next-line)
(define-key minibuffer-local-map (kbd "M-i") 'previous-history-element)
(define-key minibuffer-local-map (kbd "M-r") 'nil)
(define-key minibuffer-local-map (kbd "M-p") 'nil)
(define-key minibuffer-local-map (kbd "M-n") 'nil)
(define-key minibuffer-local-map (kbd "M-x") 'nil)
(define-key minibuffer-local-map (kbd "M-I") 'previous-matching-history-element)
(define-key minibuffer-local-map (kbd "M-K") 'next-matching-history-element)
(define-key minibuffer-local-map (kbd "M-v") 'nil)

(define-key kmacro-keymap "m" 'kmacro-start-macro)
(define-key kmacro-keymap "," 'kmacro-end-or-call-macro-repeat)
(define-key kmacro-keymap "i" 'kmacro-insert-counter)
(define-key kmacro-keymap "s" 'kmacro-set-counter)
(define-key kmacro-keymap "v" 'insert-kbd-macro)

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

(defvar eab/compile-map (make-sparse-keymap)
  "Compile keymap.")

(define-key eab/compile-map (kbd "q") 'eab/nocommand)
(define-key eab/compile-map (kbd "a") 'eab/compile-helm)
(define-key eab/compile-map (kbd "d") 'projectile-compile-project)
(define-key eab/compile-map (kbd "s") 'smart-compile)
(define-key eab/compile-map (kbd "l") (ilam (TeX-command "LaTeX" 'TeX-master-file)))
(define-key eab/compile-map (kbd "b") (ilam (TeX-command "BibTeX" 'TeX-master-file)))
(define-key eab/compile-map (kbd "L") (ilam (TeX-command "LaTeX" 'TeX-master-file)))
(define-key eab/compile-map (kbd "v") (ilam (eab/switch-wmctrl-window "main.pdf")))
;; (define-key eab/compile-map (kbd "b") (ilam (eab/switch-wmctrl-window "BoykovEA_5.pdf")))
(define-key eab/compile-map (kbd "p") 'eab/ido-wmctrl-pdf)
(define-key eab/compile-map (kbd "i") (ilam (eab/switch-wmctrl-window "Ying05ahigh-order.pdf")))
(define-key eab/compile-map (kbd "3") (ilam (eab/switch-wmctrl-window "boykov-2013-pnu.pdf")))
(define-key eab/compile-map (kbd "c") (ilam (eab/compile "make clear")))
(define-key eab/compile-map (kbd "t") (ilam (eab/compile "make test")))
(define-key eab/compile-map (kbd "2") (ilam (eab/compile "make test2")))


(defvar eab/one-key-map (make-sparse-keymap)
  "One-key keymap.")

(define-key eab/one-key-map (kbd "b") 'maplev-cmaple-send-buffer)
(define-key eab/one-key-map (kbd "t") 'eab/switch-eepitch-target)
(define-key eab/one-key-map (kbd "a") (ilam (eepitch-ansi-term "1")))
(define-key eab/one-key-map (kbd "1") (ilam (eepitch-ansi-term "1")))
(define-key eab/one-key-map (kbd "2") (ilam (eepitch-ansi-term "2")))
(define-key eab/one-key-map (kbd "3") (ilam (eepitch-ansi-term "3")))
(define-key eab/one-key-map (kbd "4") (ilam (eepitch-ansi-term "4")))
(define-key eab/one-key-map (kbd "5") (ilam (eepitch-ansi-term "5")))
(define-key eab/one-key-map (kbd "6") (ilam (eepitch-ansi-term "6")))
(define-key eab/one-key-map (kbd "7") (ilam (eepitch-ansi-term "7")))
(define-key eab/one-key-map (kbd "8") (ilam (eepitch-ansi-term "8")))
(define-key eab/one-key-map (kbd "9") (ilam (eepitch-ansi-term "9")))
(define-key eab/one-key-map (kbd "c") 'eab/switch-compile)
(define-key eab/one-key-map (kbd "x") 'nil)
(define-key eab/one-key-map (kbd "h") 'eab/switch-help)
(define-key eab/one-key-map (kbd "z") 'undo-tree-visualize)
(define-key eab/one-key-map (kbd "s") 'eab/switch-async)
(define-key eab/one-key-map (kbd "p") 'eepitch-python)
(define-key eab/one-key-map (kbd "P") 'eepitch-php)
(define-key eab/one-key-map (kbd "i") 'eepitch-ipython)
(define-key eab/one-key-map (kbd "m") 'eab/switch-message)
(define-key eab/one-key-map (kbd "k") (ilam (eepitch-kill)))
(define-key eab/one-key-map (kbd "M") 'eepitch-maxima)
(define-key eab/one-key-map (kbd "@") 'eepitch-maple)
(define-key eab/one-key-map (kbd "f") 'eepitch-shell-cluster)
(define-key eab/one-key-map (kbd "o") 'proced)
(define-key eab/one-key-map (kbd "-") 'eepitch-sage-python)
(define-key eab/one-key-map (kbd "g") 'eab/switch-grep)
(define-key eab/one-key-map (kbd "l") 'helm-locate)

;; (global-set-key (kbd "C-.") eab/one-key-map)
(global-set-key (kbd "C-e") eab/one-key-map)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar eab/dired-map (make-sparse-keymap)
  "keymap for fast dired")

(define-key eab/dired-map (kbd "d") 'ido-dired)
(define-key eab/dired-map (kbd "o") (ilam (dired eab/org-publish-directory)))
(define-key eab/dired-map (kbd "h") (ilam (dired "~/desktop")))
(define-key eab/dired-map (kbd "p") (ilam (dired eab/downloads-path)))
(define-key eab/dired-map (kbd "t") (ilam (dired "~/tmp")))

(global-set-key (kbd "C-x d") eab/dired-map)

(global-set-key (kbd "C-x r b")
		(lambda ()
		  (interactive)
		  (bookmark-jump
		   (ido-completing-read "Jump to bookmark: " (bookmark-all-names)))))

(define-key eab/temacs-map (kbd "q") 'ergoemacs-open-last-closed)
(define-key eab/temacs-map (kbd "/") 'ergoemacs-toggle-letter-case)


(define-key eab/temacs-map (kbd "C-f") 'eab/gr-status)
(define-key eab/temacs-map (kbd "h") 'eab/hron-todo)
(define-key eab/temacs-map (kbd "M-h") 'eab/send-csum-all-remote)
(define-key eab/temacs-map (kbd "v") 'eab/org-insert-link-fast)
;; (define-key eab/temacs-map (kbd "s") 'eab/sudo-save-toggle)
(define-key eab/temacs-map (kbd ".") (kbd "C-c . RET"))
(define-key eab/temacs-map (kbd "M-.") (kbd "C-c . RET C-l RET C-l l"))
(define-key eab/temacs-map (kbd "O") 'esc-toggle-window-selectability)
(define-key eab/temacs-map (kbd "D") 'toggle-window-dedicated)

(define-key eab/temacs-map (kbd "<tab>") (ilam (progn (show-all) (run-hook-with-args 'org-cycle-hook 'all))))
(define-key eab/temacs-map (kbd "z") 'org-archive-set-tag)

(define-key eab/temacs-map (kbd "b") 'bookmark-set)
(define-key eab/temacs-map (kbd "n SPC") 'dash-to-space3)
(define-key eab/temacs-map (kbd "nn") 'star-to-space2)
(define-key eab/temacs-map (kbd "ns") 'split-clock)
(define-key eab/temacs-map (kbd "nc") 'insert-clock)
(define-key eab/temacs-map (kbd "Y") 'auto-complete-mode) ;; temacs
(define-key eab/temacs-map (kbd "g") 'helm-google-suggest)
(define-key eab/temacs-map (kbd "y") 'yas-minor-mode)
(define-key eab/temacs-map (kbd "P") 'smartparens-global-mode)
(define-key eab/temacs-map (kbd ";") 'isearch-moccur)
(define-key eab/temacs-map (kbd "r") 'region-bindings-mode)

;; shell and shell-utils
(define-key eab/temacs-map (kbd "f") 'eab/see-file)
(define-key eab/temacs-map (kbd "SPC") 'eab/gr-tag-default-directory)
(define-key eab/temacs-map (kbd "M-d") (ilam (eab/sh-over-bash "~/git/auto/test-dotemacs.sh" "" 't)))
(define-key eab/temacs-map (kbd "M-p") (ilam (let ((shell-command-switch "-ic")) (eab/shell-command "dpemacs"))))
(define-key eab/temacs-map (kbd "M-P") (ilam (eab/shell-command "bash -i -c dpemacs_new")))
(define-key eab/temacs-map (kbd "M-m") (ilam (eab/sh-over-bash "~/git/auto/firefoxmacro.sh" "" 't)))

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

;; (define-key eab/wg-map (kbd "b") (ilam (switch-to-buffer "&bitlbee")))
(define-key eab/wg-map (kbd "g") (ilam (eab/wg-switch-to-workgroup ":gsie:")))
(define-key eab/wg-map (kbd "b") (ilam (eab/wg-switch-to-workgroup ":bie:")))
(define-key eab/wg-map (kbd "j") (ilam (eab/wg-switch-to-workgroup ":jac:")))
(define-key eab/wg-map (kbd "t") (ilam (eab/wg-switch-to-workgroup ":testbed:")))
(define-key eab/wg-map (kbd "m") (ilam (eab/wg-switch-to-workgroup ":dbsym:")))
(define-key eab/wg-map (kbd "e") (ilam (eab/wg-switch-to-workgroup ":doteab:")))
(define-key eab/wg-map (kbd "C-e") (ilam (eab/wg-switch-to-workgroup ":eabdot:")))
(define-key eab/wg-map (kbd "d") (ilam (eab/wg-switch-to-workgroup ":dot:")))
(define-key eab/wg-map (kbd "l") (ilam (eab/wg-switch-to-workgroup ":lat:")))
(define-key eab/wg-map (kbd "a") (ilam (eab/wg-switch-to-workgroup ":ag:")))
(define-key eab/wg-map (kbd "4") (ilam (eab/wg-switch-to-workgroup ":aaaa:")))
(define-key eab/wg-map (kbd "5") (ilam (eab/wg-switch-to-workgroup ":ahmed:")))
(define-key eab/wg-map (kbd "i") (ilam (eab/wg-switch-to-workgroup ":bib:")))
(define-key eab/wg-map (kbd "p") 'wg-switch-to-previous-workgroup)
(define-key eab/wg-map (kbd "s") 'wg-switch-to-workgroup) ;; +
(define-key eab/wg-map (kbd "x") 'wg-kill-ring-save-working-config) ;; wg-kill-ring-save-working-wconfig
(define-key eab/wg-map (kbd "v") 'wg-yank-config) ;; wg-yank-wconfig
(define-key eab/wg-map (kbd "r") 'eab/wg-revert-workgroup)
(define-key eab/wg-map (kbd "R") 'wg-revert-workgroup) ;; +
(define-key eab/wg-map (kbd "u") 'eab/wg-update-workgroup) ;; eab/wg-update-workgroup)
(define-key eab/wg-map (kbd "U") 'wg-save-session) ;; wg-update-workgroup)
(define-key eab/wg-map (kbd "S") 'eab/eab-wg-save)
(define-key eab/wg-map (kbd "L") 'eab/eab-wg-load)
;; TODO wg-make-workgroups-mode-map
(define-key eab/wg-map (kbd "z") 'wg-undo-wconfig-change)
(define-key eab/wg-map (kbd "C-z") 'wg-undo-wconfig-change)
(define-key eab/wg-map (kbd "Z") 'wg-redo-wconfig-change)
(define-key eab/wg-map (kbd "n") 'wg-create-workgroup) ;; +
(define-key eab/wg-map (kbd "c") (ilam (eab/wg-kill-tmp) (wg-clone-workgroup (wg-current-workgroup) ":tmp:"))) ;; +
(define-key eab/wg-map (kbd "SPC") 'eab/wg-revert-and-update)

(define-key eab/wg-map (kbd "w") 'twit)
;; (define-key eab/wg-map (kbd "e") (ilam (eab/twit-search "emacs")))
(define-key eab/wg-map (kbd "[") (ilam (eab/twit-search "хазин")))
(define-key eab/wg-map (kbd "]") (ilam (eab/twit-search "фурсов")))
;; (define-key eab/wg-map (kbd "s") 'bmkp-cycle) ;; TODO [#A] сделать обертку, выбирающую navlist в соответствии с группой
;; (define-key eab/wg-map (kbd "t") (ilam (bmkp-choose-navlist-of-type "any")))
;; DONE по имени буфера: нарушение SPOT!
(define-key eab/wg-map (kbd "h") (ilam (switch-to-buffer eab/agenda-H-command)))
(define-key eab/wg-map (kbd "1") (ilam (switch-to-buffer eab/agenda-a-command)))
(define-key eab/wg-map (kbd "W") (ilam (switch-to-buffer eab/agenda-W-command)))
(define-key eab/wg-map (kbd "M") (ilam (switch-to-buffer eab/agenda-M-command)))
(define-key eab/wg-map (kbd "C-s") (ilam (switch-to-buffer "*Sauron*")))

(global-set-key (kbd "C-a") eab/wg-map)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	     ____ _    	  _    	      _
;;	    / ___| | ___ | |__ 	 __ _| |
;;	   | | 	_| |/ _	\| '_ \	/ _` | |
;;	   | |_| | | (_) | |_) | (_| | |
;;	    \____|_|\___/|_.__/	\__,_|_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global

(global-set-key (kbd "<kp-insert>") 'sauron-pop-to-buffer)

;; (global-set-key (kbd "<f5>") 'twit) ;; conflicts with (require 'eab-minimal) and eab-depend.el
;; (global-set-key (kbd "<f7>") (ilam (switch-to-buffer "&bitlbee")))

(global-set-key (kbd "C-n") 'ergoemacs-new-empty-buffer)
(global-set-key (kbd "C-w") 'ergoemacs-compact-uncompact-block)
(global-set-key (kbd "M-G") 'ergoemacs-kill-line-backward)
(global-set-key (kbd "M-Q") 'ergoemacs-close-current-buffer)
(global-set-key (kbd "M-`") 'ergoemacs-switch-to-next-frame)
(global-set-key (kbd "M-S") 'ergoemacs-move-cursor-previous-pane)
(global-set-key (kbd "M-s") 'ergoemacs-move-cursor-next-pane)
(global-set-key (kbd "M-w") 'ergoemacs-shrink-whitespaces)
(global-set-key (kbd "M-~") 'ergoemacs-switch-to-previous-frame)
(global-set-key (kbd "C-/") 'ergoemacs-toggle-letter-case)
(global-set-key (kbd "M-*") 'ergoemacs-select-text-in-quote)
(global-set-key (kbd "M-8") 'ergoemacs-extend-selection)

(global-set-key (kbd "<f12>") 'eab/make-list-paths)
(global-set-key (kbd "<f6>") 'eab/revert-buffer)
(global-set-key (kbd "<print>") 'eab/make-list-paths)
(global-set-key (kbd "<kp-end>") (ilam (switch-to-buffer eab/agenda-H-command)))
(global-set-key (kbd "C-d") eab/compile-map)
(global-set-key (kbd "C-,") 'eab/eepitch-this-line)
(global-set-key (kbd "C-r") 'eab/eepitch-this-line)
(global-set-key (kbd "M-DEL") 'eab/completion-at-point)
(global-set-key (kbd "C-j") 'eab/completion-at-point)
(global-set-key (kbd "C-M-g") 'eab/insert-greek) ;; temacs
(global-set-key (kbd "C-c c") 'eab/add-eab-abbrev)
(global-set-key (kbd "C-c d") 'eab/tracker-search)
(global-set-key (kbd "C-c g") 'eab/gnugol-search)
(global-set-key (kbd "C-c o") 'eab/open-heading-browser)
(global-set-key (kbd "C-c O") 'eab/open-corresponding-html)
(global-set-key (kbd "C-c s") 'eab/org-agenda-search)
(global-set-key (kbd "C-c u") 'eab/unbound-var)
(global-set-key (kbd "C-c U") 'eab/unbound-fun)
(global-set-key (kbd "C-c v") 'eab/twit-visit)
(global-set-key (kbd "C-c w") 'eab/twit-search)
(global-set-key (kbd "C-c e") 'eab/edit-list-at-point)
(global-set-key (kbd "C-h C-f") 'eab/find-function-at-point)
(global-set-key (kbd "C-h C-k") 'eab/describe-key-find)
(global-set-key (kbd "C-h C-v") 'eab/find-variable-at-point)
(global-set-key (kbd "C-s-j") 'eab/insert-greek)  ;; temacs
(global-set-key (kbd "C-x b") 'eab/switch-to-buffer)
(global-set-key (kbd "C-x g") 'eab/grep)
(global-set-key (kbd "C-x C-g") (kbd "C-u C-x g"))
(global-set-key (kbd "M-.") 'eab/etags-find-or-pop) ;; вместе с тэгами используются eab/find-function-at-point или jedi
(global-set-key (kbd "M-A") 'eab/call-shell-command)
(global-set-key (kbd "s-v") 'eab/org-insert-link-fast)
(global-set-key (kbd "s-h") 'eab/hron-todo)

;; shell and shell-utils
(global-set-key (kbd "C-c T") 'eab/google-translate)
(global-set-key (kbd "C-x T") 'eab/google-translate)
(global-set-key (kbd "M-C-b") 'eab/mcb)
(global-set-key (kbd "s-f") 'eab/see-file)
(global-set-key (kbd "C-S-f") 'eab/gr-status)

(global-set-key (kbd "s-z") 'org-archive-set-tag)
(global-set-key (kbd "s-y") 'yas-minor-mode) 
(global-set-key (kbd "C-c i") 'yas-expand)

(global-set-key (kbd "<f8>") 'eepitch-this-line)
(global-set-key (kbd "<kp-enter>") 'winner-undo)
(global-set-key (kbd "<kp-add>") (ilam (gnus-group-read-group t t "nnimap+Dovecot:inbox")))
(global-set-key (kbd "<kp-begin>") 'twit)
;; (global-set-key (kbd "<kp-home>") (ilam (switch-to-buffer "&bitlbee")))
;; DONE по имени буфера: нарушение SPOT!
(global-set-key (kbd "<M-kp-equal>") (ilam (shell-command "suspend_until.sh 4:00 &")))
(global-set-key (kbd "<kp-delete>") (ilam (kill-buffer-and-window)))

;; former rcmd
(global-set-key (kbd "M-z") 'undo-tree-undo)
(global-set-key (kbd "C-b") 'eab/cxb)
(global-set-key (kbd "M-a") 'eab/smex-limited-commands)
(global-set-key (kbd "C-t") 'sp-transpose-sexp)
(global-set-key (kbd "M-m") 'sp-forward-sexp)
(global-set-key (kbd "M-n") 'sp-backward-sexp)
(global-set-key (kbd "M-?") (ilam (auto-complete)))
(global-set-key (kbd "C-S-k") (ilam (set-input-method nil)))
(global-set-key (kbd "s-k") (ilam (if (equal current-input-method "TeX") (set-input-method "russian-computer") (set-input-method "TeX"))))  ;; temacs
(global-set-key (kbd "C-s") (ilam (save-some-buffers 't)))
(global-set-key (kbd "C-:") 'isearch-moccur) ;; temacs
(global-set-key (kbd "C-c t") 'dictionary-search)
(global-set-key (kbd "C-f") 'magit-status)
(global-set-key (kbd "C-p") 'er/expand-region)
(global-set-key (kbd "C-s-l") 'helm-locate)
;; (global-set-key (kbd "C-x C-k C-s") 'pm-save) ;; use pm-define!
(global-set-key (kbd "C-x C-k d") 'pm-define)
(global-set-key (kbd "C-x C-k e") 'pm-switch-buf)
(global-set-key (kbd "C-x G") 'moccur-grep)
(global-set-key (kbd "C-x t") 'dictionary-search)
(global-set-key (kbd "M-V") 'helm-show-kill-ring)
(global-set-key (kbd "M-Z") 'undo-tree-redo)
(global-set-key (kbd "M-d") 'ace-jump-mode)
(global-set-key (kbd "s-Y") 'auto-complete-mode)
(global-set-key (kbd "s-g") 'helm-google-suggest)
(global-set-key (kbd "s-/") 'ac-start)  ;; temacs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	  _    	      _	_ _    	   _
;;	 | |__ 	_   _(_) | |_  	  (_)_ __
;;	 | '_ \| | | | | | __|____| | '_ \
;;	 | |_) | |_| | | | ||_____| | |	| |
;;	 |_.__/	\__,_|_|_|\__| 	  |_|_|	|_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; built-in

(define-key isearch-mode-map (kbd "M-d") 'eab/isearch-ace-jump)


(define-key minibuffer-local-map (kbd "M-:") 'helm-minibuffer-history)
(define-key minibuffer-local-map (kbd "M-k") 'next-history-element) ;; DONE not usable

(define-key minibuffer-local-map (kbd "C-d") 'eab/ace-ibuffer)
(define-key minibuffer-local-map (kbd "C-|") 'eab/minibuffer-see-file)  ;; temacs
(define-key minibuffer-local-map (kbd "s-SPC") 'eab/ido-see-file) ;; temacs
(define-key minibuffer-local-map (kbd "M-a") 'eab/smex-extended)
(define-key minibuffer-local-map (kbd "C-w") 'eab/smex-repeat)

(define-key minibuffer-local-map (kbd "M-E") (ilam (delete-minibuffer-contents)))


(define-key minibuffer-inactive-mode-map (kbd "o") 'eab/screen-off)
(define-key minibuffer-inactive-mode-map (kbd "e") 'eab/ido-emacs)
(define-key minibuffer-inactive-mode-map (kbd "s") 'eab/ido-wmctrl)
(define-key minibuffer-inactive-mode-map (kbd "t") (ilam (eab/gnome-terminal) (suspend-frame)))
(define-key minibuffer-inactive-mode-map (kbd "q") 'suspend-frame)

(define-key query-replace-map (kbd "C-e") 'edit)
(define-key query-replace-map (kbd "C-r") 'delete-and-edit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	       	   _   	 _     	 _     	       	   _
;;	  __ _ 	__| | __| |    	| |__  	___   ___ | | __
;;	 / _` |/ _` |/ _` |_____| '_ \ / _ \ / _ \| |/ /
;;	| (_| |	(_| | (_| |_____| | | |	(_) | (_) |   <
;;	 \__,_|\__,_|\__,_|    	|_| |_|\___/ \___/|_|\_\
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add-hook

(eab/add-hook rec-mode-hook eab/rec-hook
  )

(eab/add-hook proced-mode-hook eab/proced-hook
  (define-key proced-mode-map (kbd "O") 'top))

(defadvice top-mode (after eab-javascript-mode-after activate)
  (define-key top-mode-map (kbd "O") (ilam (switch-to-buffer "*Proced*"))))

(eab/add-hook bibtex-mode-hook eab/bibtex-hook
  (define-key bibtex-mode-map (kbd "C-M-\\") 'bibtex-fill-entry))

(eab/add-hook ediff-after-setup-control-frame-hook eab/ediff-hook
  (define-key ediff-mode-map (kbd "d") 'nil))

(eab/add-hook markdown-mode-hook eab/markdown-hook
  (define-key markdown-mode-map (kbd "C-M-b") 'nil)
  (define-key markdown-mode-map (kbd "C-M-f") 'nil)
  (define-key markdown-mode-map (kbd "M-n") 'nil)
  (define-key markdown-mode-map (kbd "M-p") 'nil)
  (define-key markdown-mode-map (kbd "<tab>") 'nil))

(eab/add-hook ibuffer-mode-hook eab/ibuffer-hook
  (define-key ibuffer-mode-map (kbd "C-d") 'nil)
  (define-key ibuffer-mode-map (kbd "C-k") 'nil)
  (define-key ibuffer-mode-map (kbd "C-o") 'nil)
  (define-key ibuffer-mode-map (kbd "C-y") 'nil)
  (define-key ibuffer-mode-map (kbd "M-g") 'nil)
  (define-key ibuffer-mode-map (kbd "M-j") 'nil)
  (define-key ibuffer-mode-map (kbd "M-n") 'nil)
  (define-key ibuffer-mode-map (kbd "M-o") 'nil)
  (define-key ibuffer-mode-map (kbd "M-p") 'nil)
  (define-key ibuffer-mode-map (kbd "M-s") 'nil))

(eab/add-hook magit-mode-hook eab/magit-hook
  (define-key magit-log-mode-map (kbd "C-l M-n") 'log-edit-next-comment)
  (define-key magit-log-mode-map (kbd "C-l M-p") 'log-edit-previous-comment)
  (define-key magit-log-mode-map (kbd "M-n") 'nil)
  (define-key magit-log-mode-map (kbd "M-p") 'nil)
  (define-key magit-mode-map (kbd "W") (kbd "l a"))
  (define-key magit-mode-map (kbd "Q") (kbd "l - a l = a E v g e n y SPC B  o y k o v RET l"))
  ;;  (ilam (execute-kbd-macro (read-kbd-macro "l - a l l")))
  (define-key magit-mode-map (kbd "J") 'magit-commit-amend)
  (define-key magit-mode-map (kbd "M-n") 'nil)
  (define-key magit-mode-map (kbd "M-p") 'nil)
  (define-key magit-mode-map (kbd "M-s") 'nil)
  (define-key magit-mode-map (kbd "M-S") 'nil)
  (define-key magit-mode-map (kbd "M-h") 'nil)
  (define-key magit-mode-map (kbd "M-H") 'nil)
  (define-key magit-mode-map (kbd "M-1") 'nil)
  (define-key magit-mode-map (kbd "M-2") 'nil)
  (define-key magit-mode-map (kbd "M-g") 'magit-fetch-all)
;;  (define-key magit-mode-map (kbd "M-g") 'magit-remote-update)
  (define-key magit-mode-map (kbd "C-d") 'magit-section-show-level-4)
  (define-key magit-mode-map (kbd "C-D") 'magit-section-show-level-4-all)
;;  (define-key magit-mode-map (kbd "C-f") 'magit-show-only-files)
;;  (define-key magit-mode-map (kbd "C-F") 'magit-show-only-files-all)
  (define-key magit-mode-map (kbd "s-1") 'magit-section-show-level-1-all)  ;; temacs
  (define-key magit-mode-map (kbd "s-2") 'magit-section-show-level-2-all)  ;; temacs
  (define-key magit-mode-map (kbd "<backtab>") 'magit-section-show-level-2-all)
;;  (define-key magit-mode-map (kbd "RET") (ilam (magit-visit-item 't)))
  (define-key magit-mode-map (kbd "s-3") 'magit-section-show-level-3-all)  ;; temacs
  (define-key magit-mode-map (kbd "s-4") 'magit-section-show-level-4-all))  ;; temacs

(eab/add-hook nroff-mode-hook eab/nroff-hook
  (define-key nroff-mode-map (kbd "M-s") 'nil)
  (define-key nroff-mode-map (kbd "M-n") 'nil)
  (define-key nroff-mode-map (kbd "M-p") 'nil))

(eab/add-hook twittering-edit-mode-hook eab/twittering-edit-hook
  (define-key twittering-edit-mode-map (kbd "C-l M-p") 'twittering-edit-previous-history)
  (define-key twittering-edit-mode-map (kbd "C-l M-n") 'twittering-edit-next-history)
  (define-key twittering-edit-mode-map (kbd "M-p") 'nil)
  (define-key twittering-edit-mode-map (kbd "M-n") 'nil))

(eab/add-hook eshell-mode-hook eab/eshell-hook
  (define-key eshell-mode-map (kbd "M-s") 'nil)
  (define-key eshell-mode-map (kbd "M-s") 'nil))

(eab/add-hook shell-mode-hook eab/shell-hook
  (define-key shell-mode-map (kbd "M-p") 'nil)
  (define-key shell-mode-map (kbd "M-n") 'nil))

;; DONE это ведь то же самое, что просто вызов (eab/free-map git-commit-mode-map)

(eab/add-hook git-commit-mode-hook eab/git-commit-hook
  (eab/free-map git-commit-mode-map))

;; TODO плохая зависимость от eab/free-map, которая может еще не
;; существовать на момент вызова (log-edit-mode) в ergoemacs-mode
;; это даже при запуске (el-get 'sync eab/el-get-sources)
;; (eab/add-hook log-edit-mode-hook eab/log-edit-hook
;;   (eab/free-map log-edit-mode-map))

(eab/add-hook etags-select-mode-hook eab/etags-select-hook
	      )

;; (eab/add-hook erc-mode-hook eab/erc-hook
;;   (define-key erc-mode-map (kbd "C-l M-n") 'erc-next-command)
;;   (define-key erc-mode-map (kbd "C-l M-p") 'erc-previous-command)
;;   (define-key erc-mode-map (kbd "C-a") 'nil)
;;   (define-key erc-mode-map (kbd "M-n") 'nil)
;;   (define-key erc-mode-map (kbd "M-p") 'nil))


;; (define-key popup-isearch-keymap (kbd "C-k") (ilam (insert "л")))
;; 

(eab/add-hook auto-complete-mode-hook eab/ac-complete-mode-hook
  (define-key ac-completing-map "\C-s" 'ac-isearch)
  (define-key ac-complete-mode-map (kbd "M-c") 'ac-expand-common)
  (define-key ac-complete-mode-map (kbd "M-k") 'ac-next)
  (define-key ac-complete-mode-map (kbd "M-i") 'ac-previous))

(eab/add-hook bookmark-bmenu-mode-hook eab/bookmark-bmenu-mode-hook
  (define-key bookmark-bmenu-mode-map (kbd "M-s") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-l") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-m") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-a") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-d") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-u") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-I") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "C-d") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "C-o") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-~") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-a") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-c") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-L") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-m") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-o") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-q") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-r") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-t") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "SPC") 'bmkp-describe-bookmark)
  (define-key bookmark-bmenu-mode-map (kbd "M-X") 'nil))

(eab/add-hook moccur-mode eab/moccur-hook
  (define-key moccur-mode-map (kbd "M-n") 'nil)
  (define-key moccur-mode-map (kbd "M-p") 'nil)
  (define-key moccur-mode-map (kbd "M-m") 'nil)
  (define-key moccur-mode-map (kbd "M-d") 'nil))

(eab/add-hook org-mode-hook eab/org-hook
  (define-key org-mode-map (kbd "M-D") 'ace-link-org)
  (define-key org-mode-map (kbd "C-d") eab/compile-map)
  (define-key org-mode-map (kbd "<f6>") 'eab/revert-buffer)

  (key-chord-define org-mode-map "jj" 'org-edit-src-code)
  (define-key org-mode-map (kbd "s-'") 'org-edit-src-code)  ;; temacs
  (define-key org-mode-map (kbd "s-k") 'org-metadown)
  (define-key org-mode-map (kbd "s-i") 'org-metaup)
  (define-key org-mode-map (kbd "s-p") 'org-priority-up)
  (define-key org-mode-map (kbd "s-j") 'org-metaleft)
  (define-key org-mode-map (kbd "s-l") 'org-metaright)
  (define-key org-mode-map (kbd "s-K") 'org-shiftmetadown)
  (define-key org-mode-map (kbd "s-I") 'org-shiftmetaup)
  (define-key org-mode-map (kbd "s-J") 'org-shiftmetaleft)
  (define-key org-mode-map (kbd "s-L") 'org-shiftmetaright)
  (define-key org-mode-map (kbd "s-<return>") 'org-insert-heading)
  (define-key org-mode-map (kbd "s-S-<return>") 'org-insert-todo-heading)
  (define-key org-mode-map (kbd "M-s-k") 'org-shiftdown)
  (define-key org-mode-map (kbd "M-s-i") 'org-shiftup)
  (define-key org-mode-map (kbd "M-s-j") 'org-shiftleft)
  (define-key org-mode-map (kbd "M-s-l") 'org-shiftright)  ;; temacs
  (define-key org-mode-map (kbd "C-y") 'nil)
  (define-key org-mode-map (kbd "C-e") 'nil)
  (define-key org-mode-map (kbd "C-,") 'nil)  ;; temacs
  (define-key org-mode-map (kbd "C-SPC") 'nil)
  (define-key org-mode-map (kbd "M-a") 'nil)
  (define-key org-mode-map (kbd "M-e") 'nil)
  (define-key org-mode-map (kbd "C-a") 'nil)
  (define-key org-mode-map (kbd "C-k") 'nil)
  (define-key org-mode-map (kbd "M-h") 'org-beginning-of-line)
  (define-key org-mode-map (kbd "M-p") 'org-end-of-line)
  (define-key org-mode-map (kbd "M-g") 'org-kill-line)
  (define-key org-mode-map (kbd "M-v") 'org-yank)
  (define-key org-mode-map (kbd "M-RET") (ilam (org-insert-heading nil)))
  (define-key org-mode-map (kbd "M-N") 'org-backward-sentence)
  (define-key org-mode-map (kbd "M-M") 'org-forward-sentence)
  (define-key org-mode-map (kbd "C-M-u") 'outline-previous-visible-heading)
  (define-key org-mode-map (kbd "C-M-o") 'outline-next-visible-heading)
  (define-key org-mode-map (kbd "s-u") 'org-preview-latex-fragment)  ;; temacs
  (define-key org-mode-map (kbd "C-c C-x M-c") 'org-copy-special)
  (define-key org-mode-map (kbd "C-c C-x M-x") 'org-cut-special)
  (define-key org-mode-map (kbd "C-c C-x M-v") 'org-paste-special)
  (define-key org-mode-map (kbd "s-x M-c") 'org-copy-special)  ;; temacs
  (define-key org-mode-map (kbd "s-x M-x") 'org-cut-special)  ;; temacs
  (define-key org-mode-map (kbd "s-x M-v") 'org-paste-special)  ;; temacs
  (define-key org-mode-map (kbd "s-.") (kbd "C-c . RET"))

  (key-chord-define org-src-mode-map "jj" 'org-edit-src-exit)
  (define-key org-src-mode-map (kbd "s-'") 'org-edit-src-exit)  ;; temacs
  (define-key org-src-mode-map (kbd "C-l '") 'org-edit-src-exit)
  ;; (define-key org-agenda-mode-map (kbd "s-.") (ilam (org-agenda-todo 3)))  ;; temacs
  (define-key org-agenda-mode-map (kbd "M-j") 'nil)
  (define-key org-agenda-mode-map (kbd "M-l") 'nil)
  (define-key org-agenda-mode-map (kbd "C-p") 'nil)
  (define-key org-agenda-mode-map (kbd "C-n") 'nil)
  (define-key org-agenda-mode-map (kbd "C-k") 'nil)
  (define-key org-agenda-mode-map (kbd "s") 'flx-isearch-forward)
  (define-key org-agenda-mode-map (kbd "M-g") 'org-agenda-kill)
  (define-key org-agenda-mode-map (kbd "M-k") 'org-agenda-next-line)
  (define-key org-agenda-mode-map (kbd "M-i") 'org-agenda-previous-line))

(eab/add-hook comint-mode-hook eab/coming-hook
  (define-key comint-mode-map (kbd "M-p") 'comint-previous-matching-input-from-input)
  (define-key comint-mode-map (kbd "M-n") 'comint-next-matching-input-from-input)
  (define-key comint-mode-map (kbd "C-M-n") 'comint-next-input)
  (define-key comint-mode-map (kbd "C-M-p") 'comint-previous-input))

(eab/add-hook diff-mode-hook eab/diff-hook
  (define-key diff-mode-map (kbd "M-SPC") 'nil)
  (define-key diff-mode-map (kbd "M-1") 'nil)
  (define-key diff-mode-map (kbd "M-2") 'nil)
  (define-key diff-mode-map (kbd "M-5") 'nil)
  (define-key diff-mode-map (kbd "M-k") 'nil)
  (define-key diff-mode-map (kbd "M-<") 'nil)
  (define-key diff-mode-map (kbd "M->") 'nil)
  (define-key diff-mode-map (kbd "M-K") 'nil)
  (define-key diff-mode-map (kbd "M-h") 'nil)
  (define-key diff-mode-map (kbd "M-n") 'nil)
  (define-key diff-mode-map (kbd "M-N") 'nil)
  (define-key diff-mode-map (kbd "M-o") 'nil)
  (define-key diff-mode-map (kbd "M-p") 'nil))

(eab/add-hook fortran-mode-hook eab/fortran-hook
  (define-key fortran-mode-map (kbd "C-d") eab/compile-map))

(eab/add-hook f90-mode-hook eab/f90-hook
  (define-key f90-mode-map (kbd "C-j") 'nil)
  (define-key f90-mode-map (kbd "C-d") eab/compile-map))

(eab/add-hook twittering-mode-hook eab/twittering-hook
  (define-key twittering-mode-map (kbd "u") 'eab/twittering-update-status-interactive)
  (define-key twittering-mode-map (kbd "d") 'ace-link-info)
  (define-key twittering-mode-map (kbd "M-v") 'nil)
  (define-key twittering-mode-map (kbd "C-v") 'nil)
  (define-key twittering-mode-map (kbd "@") 'eab/twit-filter)
  (define-key twittering-mode-map (kbd "f") 'twittering-follow)
  (define-key twittering-mode-map (kbd "r") 'twittering-retweet)
  (define-key twittering-mode-map (kbd "R") 'twittering-toggle-or-retrieve-replied-statuses)
  (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
  (define-key twittering-mode-map (kbd "s-f") 'twittering-friends-timeline)  ;; temacs
  (define-key twittering-mode-map (kbd "s-r") 'twittering-replies-timeline)
  (define-key twittering-mode-map (kbd "s-u") 'twittering-user-timeline)
  (define-key twittering-mode-map (kbd "s-d") 'twittering-direct-messages-timeline)
  (define-key twittering-mode-map (kbd "s-s") 'twittering-update-status-interactive)
  (define-key twittering-mode-map (kbd "s-e") 'twittering-erase-old-statuses)
  (define-key twittering-mode-map (kbd "s-m") 'twittering-retweet)
  (define-key twittering-mode-map (kbd "s-t") 'twittering-set-current-hashtag)
  (define-key twittering-mode-map (kbd "C-m") 'twittering-enter)
  (define-key twittering-mode-map (kbd "s-l") 'twittering-update-lambda))  ;; temacs

(eab/add-hook slime-repl-mode-hook eab/slime-repl-hook
  (define-key slime-repl-mode-map (kbd "M-n") 'nil)
  (define-key slime-repl-mode-map (kbd "M-p") 'nil)
  (define-key slime-repl-mode-map (kbd "M-r") 'nil)
  (define-key slime-repl-mode-map (kbd "M-s") 'nil)
  (define-key slime-repl-mode-map (kbd "C-a") 'nil)
  (define-key slime-repl-mode-map (kbd "C-A") 'nil)
  (define-key slime-repl-mode-map (kbd "C-l M-p") 'slime-repl-previous-input)
  (define-key slime-repl-mode-map (kbd "C-l M-n") 'slime-repl-next-input))

(eab/add-hook maxima-mode-hook eab/maxima-hook
  (define-key maxima-mode-map (kbd "C-M-a") 'nil)
  (define-key maxima-mode-map (kbd "C-M-b") 'nil)
  (define-key maxima-mode-map (kbd "C-M-e") 'nil)
  (define-key maxima-mode-map (kbd "C-M-f") 'nil)
  (define-key maxima-mode-map (kbd "M-;") 'nil)
  (define-key maxima-mode-map (kbd "C-d") eab/compile-map)
  (define-key maxima-mode-map (kbd "M-h") 'nil))

(eab/add-hook slime-mode-hook eab/slime-hook
  (define-key slime-mode-map (kbd "M-p") 'nil)
  (define-key slime-mode-map (kbd "M-n") 'nil))

(eab/add-hook message-mode-hook eab/message-hook
  (define-key message-mode-map (kbd "C-c C-c") 'eab/message-send)
  (define-key message-mode-map (kbd "M-;") 'nil)
  (define-key message-mode-map (kbd "M-n") 'nil))

(eab/add-hook makefile-gmake-mode-hook eab/makefile-gmake-mode
  (define-key makefile-gmake-mode-map (kbd "\C-d") eab/compile-map)
  (define-key makefile-gmake-mode-map (kbd "M-n") 'nil)
  (define-key makefile-gmake-mode-map (kbd "M-p") 'nil))

(eab/add-hook nxml-mode-hook eab/nxml-mode
  (define-key nxml-mode-map (kbd "M-h") 'nil))

(eab/add-hook term-mode-hook eab/term-hook
  (define-key term-mode-map (kbd "M-q") 'nil)
  (define-key term-mode-map (kbd "M-s") 'nil)
  (define-key term-mode-map (kbd "M-n") 'nil)
  (define-key term-mode-map (kbd "M-p") 'nil)
  (define-key term-mode-map (kbd "<tab>") 'eab/wrap-tab)
  (define-key term-mode-map (kbd "C-p") 'term-previous-input)
  (define-key term-mode-map (kbd "C-n") 'term-next-input)
  (key-chord-define term-mode-map "jj" 'term-char-mode)
  
  (key-chord-define term-raw-map "jj" 'term-line-mode)
  (define-key term-raw-map (kbd "M-a") 'nil)
  (define-key term-raw-map (kbd "M-A") 'nil)
  (define-key term-raw-map (kbd "M-q") 'nil)
  (define-key term-raw-map (kbd "M-Q") 'nil)
  (define-key term-raw-map (kbd "M-v") 'nil)
  (define-key term-raw-map (kbd "M-g") 'nil)
  (define-key term-raw-map (kbd "M-V") 'nil)
  (define-key term-raw-map (kbd "M-z") 'nil)
  (define-key term-raw-map (kbd "M-s") 'nil)
  (define-key term-raw-map (kbd "C-b") 'nil)
  (define-key term-raw-map (kbd "C-a") 'nil)
  (define-key term-raw-map (kbd "C-o") 'nil)
  (define-key term-raw-map (kbd "C-h") 'nil)
  (define-key term-raw-map (kbd "C-c s") 'nil)
  (define-key term-raw-map (kbd "M-1") 'nil)
  (define-key term-raw-map (kbd "C-r") 'term-send-raw)
  (define-key term-raw-map (kbd "M-r") 'eab/append-this-line)
  (define-key term-raw-map (kbd "C-l") eab/temacs-map)
  (define-key term-raw-map (kbd "M-h") 'term-send-home)
  (define-key term-raw-map (kbd "M-p") 'term-send-end)
  (define-key term-raw-map (kbd "M-j") 'term-send-left)
  (define-key term-raw-map (kbd "M-l") 'term-send-right)
  (define-key term-raw-map (kbd "M-k") 'term-send-up) 
  (define-key term-raw-map (kbd "M-i") 'term-send-down)
  (define-key term-raw-map (kbd "C-p") 'term-send-up)
  (define-key term-raw-map (kbd "C-n") 'term-send-down))

(eab/add-hook comint-mode-hook eab/comint-hook
  (define-key comint-mode-map (kbd "M-s") 'nil)
  (define-key comint-mode-map (kbd "M-p") 'nil)
  (define-key comint-mode-map (kbd "M-n") 'nil)
  (define-key comint-mode-map (kbd "M-r") 'nil)
  (define-key comint-mode-map (kbd "C-p") 'comint-previous-input)
  (define-key comint-mode-map (kbd "C-n") 'comint-next-input))

(eab/add-hook compilation-mode-hook eab/compilation-hook
  (define-key compilation-button-map (kbd "M-RET") 'eab/compile-goto-error)
  (define-key compilation-button-map (kbd "RET") 'compile-goto-error)
  (define-key compilation-mode-map (kbd "g") (ilam (let ((compilation-buffer-name-function nil)) (recompile))))
  (define-key compilation-mode-map (kbd "\C-d") eab/compile-map)
  (define-key compilation-mode-map (kbd "\C-o") 'nil)
  (define-key compilation-mode-map (kbd "M-k") 'nil)
  (define-key compilation-mode-map (kbd "M-p") 'nil)
  (define-key compilation-mode-map (kbd "M-i") 'nil)
  (define-key compilation-mode-map (kbd "M-n") 'nil))

(eab/add-hook grep-mode-hook eab/grep-hook
  (define-key grep-mode-map (kbd "B") 'eab/switch-grep-prev)
  (define-key grep-mode-map (kbd "F") 'eab/switch-grep-next)
  (define-key grep-mode-map (kbd "C-o") 'nil)
  (define-key grep-mode-map (kbd "M-p") 'nil)
  (define-key grep-mode-map (kbd "M-RET") 'eab/compile-goto-error)
  (define-key grep-mode-map (kbd "RET") 'compile-goto-error)
  (define-key grep-mode-map (kbd "g") (ilam (let ((compilation-buffer-name-function nil)) (recompile))))
  (define-key grep-mode-map (kbd "M-n") 'nil)
  (define-key grep-mode-map (kbd "C-w") 'wgrep-change-to-wgrep-mode))

(eab/add-hook gnus-started-hook eab/gnus-article-hook
  (define-key gnus-article-mode-map (kbd "M-g") 'nil)
  (define-key gnus-article-mode-map (kbd "M-u") 'nil)
  (define-key gnus-article-mode-map (kbd "M-*") 'nil)
  (define-key gnus-article-mode-map (kbd "M-n") 'nil)
  (define-key gnus-article-mode-map (kbd "C-c C-v") 'gnus-article-browse-html-article))

(eab/add-hook gnus-started-hook eab/gnus-summary-hook 
  (define-key gnus-summary-mode-map (kbd "g") 'eab/gnus-inbox)
  (define-key gnus-summary-mode-map (kbd "RET") 'gnus-summary-show-article)
  (define-key gnus-summary-mode-map (kbd "A o") 'gnus-summary-insert-old-articles)
  (define-key gnus-summary-mode-map (kbd "M-I") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-i") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-k") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-K") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-s") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-p") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-n") 'nil)
  (define-key gnus-summary-mode-map (kbd "\C-c\C-w") 'gnus-summary-move-article)
  (define-key gnus-summary-mode-map (kbd "m") 'gnus-summary-mark-as-processable)
  (define-key gnus-summary-mode-map (kbd "u") 'gnus-summary-unmark-as-processable))

(eab/add-hook gnus-started-hook eab/gnus-group-hook
  (define-key gnus-group-mode-map (kbd "RET") 'eab/gnus-group-select)
  (define-key gnus-group-mode-map (kbd "M-d") 'nil)
  (define-key gnus-group-mode-map (kbd "M-k") 'nil)
  (define-key gnus-group-mode-map (kbd "M-n") 'nil))

(eab/add-hook dired-mode-hook eab/dired-hook 
  (define-key dired-mode-map (kbd "C-M-b") 'nil)
  (define-key dired-mode-map (kbd "M-i") 'nil)
  (define-key dired-mode-map (kbd "M-j") 'nil)
  (define-key dired-mode-map (kbd "C-n") 'nil)
  (define-key dired-mode-map (kbd "M-c") 'nil)
  (define-key dired-mode-map (kbd "M-g") 'nil)
  (define-key dired-mode-map (kbd "M-G") 'nil)
  (define-key dired-mode-map (kbd "M-v") 'nil)
  (define-key dired-mode-map (kbd "M-!") 'nil)
  (define-key dired-mode-map (kbd "M-l") 'nil)
  (define-key dired-mode-map (kbd "M-p") 'nil)
  (define-key dired-mode-map (kbd "M-o") 'nil)
  (define-key dired-mode-map (kbd "M-s") 'nil)
  (define-key dired-mode-map (kbd "M-u") 'nil)
  (define-key dired-mode-map (kbd "M-m") 'nil)
  (define-key dired-mode-map (kbd "C-o") 'nil)
  (define-key dired-mode-map (kbd "C-p") 'nil)
  (define-key dired-mode-map (kbd "C-k") 'nil)
  (define-key dired-mode-map (kbd "C-S-a") 'nil)
  (define-key dired-mode-map (kbd "C-c C-w") 'dired-do-rename)
  (define-key dired-mode-map (kbd "C-w") 'wdired-change-to-wdired-mode)
  (define-key dired-mode-map (kbd "b") 'browse-url-of-dired-file)
  (define-key dired-mode-map (kbd "o") 'eab/dired-find-file-other-window)
  (define-key dired-mode-map (kbd "C-|") 'eab/dired-see-file) ;; temacs
  (define-key dired-mode-map (kbd "s-SPC") 'eab/dired-see-file)  ;; temacs
  (define-key dired-mode-map (kbd "E") 'ediff-files)  ;; temacs
  (define-key dired-mode-map (kbd "SPC") 'open-in-external-app))

(eab/add-hook wdired-mode-hook eab/wdired-hook
  (define-key wdired-mode-map (kbd "s-w") 'wdired-finish-edit))  ;; temacs

(eab/add-hook java-mode-hook eab/java-hook
  (define-key java-mode-map (kbd "M-M") 'c-end-of-defun)
  (define-key java-mode-map (kbd "M-N") 'c-beginning-of-defun)
  (define-key java-mode-map (kbd "M-j") 'nil)
  (define-key java-mode-map (kbd "M-e") 'nil))

(eab/add-hook c-mode-hook eab/c-hook
  (define-key c-mode-map (kbd "C-d") eab/compile-map)
  (define-key c-mode-map (kbd "C-M-a") 'nil)
  (define-key c-mode-map (kbd "C-M-e") 'nil)
  (define-key c-mode-map (kbd "M-a") 'nil)
  (define-key c-mode-map (kbd "M-M") 'nil)
  (define-key c-mode-map (kbd "M-N") 'nil)
  (define-key c-mode-map (kbd "M-j") 'nil)
  (define-key c-mode-map (kbd "M-q") 'nil)
  (define-key c-mode-map (kbd "M-M") 'c-end-of-defun)
  (define-key c-mode-map (kbd "M-N") 'c-beginning-of-defun)
  (define-key c-mode-map (kbd "M-e") 'nil))

(eab/add-hook c++-mode-hook eab/c++-hook
  (define-key c++-mode-map (kbd "C-d") eab/compile-map)
  (define-key c++-mode-map (kbd "C-M-a") 'nil)
  (define-key c++-mode-map (kbd "C-M-e") 'nil)
  (define-key c++-mode-map (kbd "M-a") 'nil)
  (define-key c++-mode-map (kbd "M-M") 'nil)
  (define-key c++-mode-map (kbd "M-N") 'nil)
  (define-key c++-mode-map (kbd "M-j") 'nil)
  (define-key c++-mode-map (kbd "M-q") 'nil)
  (define-key c++-mode-map (kbd "M-M") 'c-end-of-defun)
  (define-key c++-mode-map (kbd "M-N") 'c-beginning-of-defun)
  (define-key c++-mode-map (kbd "M-e") 'nil))

(eab/add-hook w3m-mode-hook eab/w3m-hook 
  (define-key w3m-mode-map (kbd "M-d") 'nil)
  (define-key w3m-mode-map (kbd "M-k") 'nil)
  (define-key w3m-mode-map (kbd "M-l") 'nil)
  (define-key w3m-mode-map (kbd "M-i") 'nil)
  (define-key w3m-mode-map (kbd "M-a") 'nil)
  (define-key w3m-mode-map (kbd "M-s") 'nil)
  (define-key w3m-mode-map (kbd "M-g") 'nil))

(eab/add-hook helm-before-initialize-hook eab/helm-hook
  (define-key helm-map (kbd "C-k") 'toggle-input-method)
  (define-key helm-map (kbd "M-H") 'helm-select-2nd-action-or-end-of-line)
  (define-key helm-map (kbd "M-g") 'helm-delete-minibuffer-contents)
  (define-key helm-map (kbd "s-SPC") 'eab/helm-select-action)
  (define-key helm-map (kbd "C-|") 'eab/helm-select-action)
  ;; (define-key helm-map (kbd "@") 'helm-select-with-prefix-shortcut)      
  ;; (define-key helm-map (kbd "M-d") 'helm-select-with-prefix-shortcut)
  (define-key helm-map (kbd "M-j") 'nil)
  (define-key helm-map (kbd "M-v") 'nil)
  (define-key helm-map (kbd "M-l") 'nil)
  (define-key helm-map (kbd "M-k") 'helm-next-line)
  (define-key helm-map (kbd "M-i") 'helm-previous-line)
  (define-key helm-generic-files-map (kbd "M-i") 'helm-previous-line)
  (define-key helm-map (kbd "C-n") 'next-history-element)
  (define-key helm-map (kbd "C-p") 'previous-history-element)
  ;; (define-key helm-map (kbd "M-;") 'helm-isearch)
  (define-key helm-map (kbd "C-SPC") 'helm-toggle-visible-mark)
  (define-key helm-map (kbd "M-K") 'helm-next-page)
  (define-key helm-map (kbd "M-J") 'helm-beginning-of-buffer)
  (define-key helm-map (kbd "M-L") 'helm-end-of-buffer)
  (define-key helm-map (kbd "M-I") 'helm-previous-page))

(eab/add-hook ido-minibuffer-setup-hook eab/ido-minibuffer-hook
  (define-key ido-file-dir-completion-map (kbd "M-v") 'yank)
  (define-key ido-file-completion-map (kbd "C-d") 'eab/ace-ibuffer)
  (define-key ido-file-completion-map (kbd "C-|") 'eab/ido-see-file)  ;; temacs
  (define-key ido-file-completion-map (kbd "s-SPC") 'eab/ido-see-file)  ;; temacs
  (define-key ido-buffer-completion-map (kbd "C-k") 'nil)
  (define-key ido-common-completion-map (kbd "C-v") 'eab/toggle-cxb-ido-item)
  (define-key ido-buffer-completion-map (kbd "C-d") 'eab/ace-ibuffer)
  (define-key ido-common-completion-map (kbd "C-d") 'eab/ace-ibuffer)
  (define-key ido-buffer-completion-map (kbd "C-d") 'ido-buffer-helm)
  (define-key ido-buffer-completion-map (kbd "M-RET") 'eab/ido-main)
  ;; DONE слетают хоткеи. М. б. где-то в другом месте переделывается map?
  (define-key ido-buffer-completion-map (kbd "C-M-j") 'eab/ido-main)
  (define-key ido-buffer-completion-map (kbd "C-b") 'eab/ido-wmctrl)
  (define-key ido-common-completion-map (kbd "C-b") 'eab/ido-wmctrl))

(eab/add-hook emacs-lisp-mode-hook eab/emacs-lisp-hook
  (define-key emacs-lisp-mode-map (kbd "s-r") 'paredit-raise-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-L") 'paredit-forward-barf-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-J") 'paredit-backward-barf-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-l") 'paredit-forward-slurp-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-j") 'paredit-backward-slurp-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-I") 'paredit-splice-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-K") 'paredit-splice-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-i") 'paredit-splice-sexp-killing-backward)
  (define-key emacs-lisp-mode-map (kbd "s-k") 'paredit-splice-sexp-killing-forward)
  (define-key emacs-lisp-mode-map (kbd "M-(") 'paredit-wrap-round)
  (define-key emacs-lisp-mode-map (kbd "M-r") 'paredit-forward-kill-word)
  (define-key emacs-lisp-mode-map (kbd "M-e") 'paredit-backward-kill-word)
  (define-key emacs-lisp-mode-map (kbd "M-g") 'paredit-kill)
  (define-key emacs-lisp-mode-map (kbd "M-'") 'paredit-comment-dwim)
  (define-key emacs-lisp-mode-map (kbd "RET") 'paredit-newline))

(eab/add-hook smartparens-enabled-hook eab/smartparens-hook
  (progn
    (define-key sp-keymap (kbd "/") 'nil)
    (define-key sp-keymap (kbd "b") 'sp--self-insert-command) ;; for latex sp-local-tag
    (define-key sp-keymap (kbd "B") 'nil)
    (define-key sp-keymap (kbd "f") 'nil)
    (define-key sp-keymap (kbd "g") 'nil)
    (define-key sp-keymap (kbd "h") 'nil)
    (define-key sp-keymap (kbd "l") 'nil)
    (define-key sp-keymap (kbd "t") 'nil)
    (define-key sp-keymap (kbd "i") 'nil)
    (define-key sp-keymap (kbd "e") 'nil)
    (define-key sp-keymap (kbd "r") 'nil)
    (define-key sp-keymap (kbd "к") 'nil)))

;; TODO в multiple-cursors-mode этот hook только запускается, но не определяется
;; возможны проблемы в будущем
(eab/add-hook multiple-cursors-mode-enabled-hook eab/multiple-cursors-hook
  (progn
    ;; DONE mc/cycle-*
    (define-key mc/keymap (kbd "M-K") 'mc/cycle-forward)
    (define-key mc/keymap (kbd "M-I") 'mc/cycle-backward)
    (define-key mc/keymap (kbd "M-v") 'nil)
    (define-key mc/keymap (kbd "C-v") 'nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'flyspell-mode-hook
	  (lambda () (define-key flyspell-mode-map (kbd "C-k") 'toggle-input-method)))

(add-hook 'LaTeX-mode-hook  
	  (lambda ()
	    ;; DONE в temacs проблемы с производительностью у команды sp-forward-sexp в latex-mode
	    (define-key LaTeX-mode-map (kbd "M-m") 'forward-sexp)
	    (define-key LaTeX-mode-map (kbd "C-d") 'TeX-command-master)
	    ;; (define-key LaTeX-mode-map (kbd "C-d") (ilam (TeX-command "LaTeX" 'TeX-master-file)))
	    (define-key LaTeX-mode-map (kbd "C-S-d") eab/compile-map)))

(add-hook 'graphviz-dot-mode-hook
	  (lambda () (define-key graphviz-dot-mode-map (kbd "C-d") eab/compile-map)
	    (set (make-local-variable 'compile-command) nil)))


(add-hook 'text-mode-hook
	  (lambda () (define-key text-mode-map (kbd "C-c C-c") 'server-edit)))

(add-hook 'ruby-mode-hook
	  (lambda () (progn
		       (define-key ruby-mode-map (kbd "C-d") eab/compile-map)
		       (define-key ruby-mode-map (kbd "C-M-b") 'nil)
		       )))

(add-hook 'python-mode-hook
	  (lambda () (progn
		       (define-key python-mode-map (kbd "C-d") eab/compile-map)
		       (define-key python-mode-map (kbd "C-j") 'nil)
		       (define-key python-mode-map (kbd "M-RET") 'newline)
		       (define-key python-mode-map (kbd "RET") 'newline)
		       (define-key python-mode-map (kbd "C-h C-f") 'jedi:goto-definition)
		       )))

(add-hook 'py-shell-hook
	  (lambda () (progn
		       ;; (define-key py-shell-map (kbd "<tab>") ')
		       ;; (define-key py-shell-map (kbd "TAB") ')
		       )) 't) ;; to the end!!

(add-hook 'maplev-mode-hook
	  (lambda () 
            ;; (define-key smart-operator-mode-map ":" 'self-insert-command)
            ;; (define-key smart-operator-mode-map "." 'self-insert-command)
            ;; (define-key smart-operator-mode-map "," 'self-insert-command)

	    (define-key maplev-mode-map (kbd "C-c d") 'maplev-help-at-point)
	    (define-key maplev-mode-map (kbd "C-k") 'toggle-input-method)))

(add-hook 'help-mode-hook
	  (lambda ()
	    (require 'view)
	    (define-key help-mode-map "o" 'ace-link-help)
	    (define-key help-mode-map "B" 'help-go-back)
	    (define-key help-mode-map "F" 'help-go-forward)
	    (define-key view-mode-map "F" 'nil)))

;; TODO does it really work?
(add-hook 'dictionary-mode-hook
	  (lambda ()
	    (define-key dictionary-mode-map "B" 'eab/help-mode-back)
	    (define-key dictionary-mode-map "F" 'eab/help-mode-forward)))

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
      (define-key region-bindings-mode-map "u" 'untabify)
      (define-key region-bindings-mode-map "г" 'untabify)
      (define-key region-bindings-mode-map "0" (ilam (eab/or-self-insert-body (er/expand-region 0))))
      (define-key region-bindings-mode-map "p" (ilam (eab/or-self-insert-body (er/expand-region 1))))
      (define-key region-bindings-mode-map "-" (ilam (eab/or-self-insert-body (er/expand-region -1))))
      (define-key region-bindings-mode-map "P" (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-paragraph)))))
      (define-key region-bindings-mode-map "З" (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-paragraph)))))
      (define-key region-bindings-mode-map "I" (ilam (eab/or-self-insert 'indent-region)))
      (define-key region-bindings-mode-map "Ш" (ilam (eab/or-self-insert 'indent-region)))
      (define-key region-bindings-mode-map "d" (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-defun)))))
      (define-key region-bindings-mode-map "/" (ilam (let ((this-command 'ergoemacs-toggle-letter-case)) (eab/or-self-insert 'ergoemacs-toggle-letter-case))))
      (define-key region-bindings-mode-map "r" (ilam (eab/or-self-insert 'string-rectangle)))
      (define-key region-bindings-mode-map "к" (ilam (eab/or-self-insert 'string-rectangle)))
      (define-key region-bindings-mode-map "t" (ilam (eab/or-self-insert 'anchored-transpose)))
      ;; TODO C-g неправильно работает с region-bindings-mode
      (define-key region-bindings-mode-map "g" (ilam (eab/or-self-insert 'mc/keyboard-quit)))
      (define-key region-bindings-mode-map "п" (ilam (eab/or-self-insert 'mc/keyboard-quit)))
      ;; (define-key region-bindings-mode-map (kbd "C-g") (ilam (eab/or-self-insert 'mc/keyboard-quit)))
      (define-key region-bindings-mode-map "G" (ilam (eab/or-self-insert 'google)))
      (define-key region-bindings-mode-map "П" (ilam (eab/or-self-insert 'google)))
      (define-key region-bindings-mode-map "l" (ilam (eab/or-self-insert 'eab/replace-selection)))
      (define-key region-bindings-mode-map "д" (ilam (eab/or-self-insert 'eab/replace-selection)))
      (define-key region-bindings-mode-map "s" (ilam (eab/or-self-insert 'gnugol-search-selection)))
      (define-key region-bindings-mode-map "ы" (ilam (eab/or-self-insert 'gnugol-search-selection)))
      (define-key region-bindings-mode-map "e" 'mc/edit-lines) ;; (lambda () (interactive) (eab/or-self-insert 'mc/edit-lines)))
      (define-key region-bindings-mode-map "x" (ilam (eab/or-self-insert 'kill-rectangle)))
      (define-key region-bindings-mode-map "ч" (ilam (eab/or-self-insert 'kill-rectangle))) ;; TODO возможные проблемы с раскладками
      (define-key region-bindings-mode-map "A" (ilam
						  (eab/or-self-insert-body
						      (save-restriction
							(narrow-to-region (window-start) (window-end))
							(ignore-errors (mc/mark-all-like-this))))))

      (define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
      (define-key region-bindings-mode-map "i" 'mc/mark-previous-like-this)
      (define-key region-bindings-mode-map "ш" 'mc/mark-previous-like-this)
      (define-key region-bindings-mode-map "k" 'mc/mark-next-like-this)
      (define-key region-bindings-mode-map "л" 'mc/mark-next-like-this)
      (define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)))


(defadvice artist-mode (before eab-artist-mode activate)
  (define-key artist-mode-map (kbd "C-b") 'nil))

(provide 'eab-kbd)
