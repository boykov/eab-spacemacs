;;; keybindings.el --- -*- lexical-binding: t -*-

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;           ____ _       _           _
;;          / ___| | ___ | |__   __ _| |
;;         | |  _| |/ _ \| '_ \ / _` | |
;;         | |_| | | (_) | |_) | (_| | |
;;          \____|_|\___/|_.__/ \__,_|_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global

(general-define-key
 "C-M-f"        'toggle-frame-maximized
 "C-M-:"        'isearch-backward-regexp
 "C-M-;"        'isearch-forward-regexp
 "C-h C-c"      'describe-command
 "C-h c"        'eab/describe-key-briefly
 "C-h C-f"      'eab/find-function-at-point
 "C-h C-k"      'eab/describe-key-find
 "C-h C-v"      'eab/find-variable-at-point
)

(general-define-key
 "C-c a"        'org-agenda
 "C-c C-M-p"    'org-open-at-point-global
 "C-c C-l"      'org-insert-link
 "C-c l"        'org-store-link
 "C-c r"        'org-capture
 "C-x C-M-p"    'org-open-at-point-global
 "M-z"          'undo
 "C-b"          'switch-to-buffer
 "M-a"          'execute-extended-command
 "C-t"          'transpose-sexps
 "M-m"          'forward-sexp
 "M-n"          'backward-sexp
 "M-q"          'kill-current-buffer
 "C-i"          'indent-for-tab-command
 "C-m"          'newline
 "C-@"          'set-mark-command
 "C-S-a"        'eval-expression
 "C-S-b"        'select-frame-by-name
 "C-S-s"        'write-file
 "C-SPC"        'set-mark-command
 "S-SPC"        'nil
 "C-c M-f"      'find-file-at-point
 "C-k"          'toggle-input-method
 "C-o"          'find-file
 "C-x C-d"      'dired-jump
 "C-x C-e"      'eval-defun
 "C-x C-k k"    'kill-region
 "C-x M-f"      'find-file-at-point
 "C-x c"        'customize-variable
 "C-x e"        'eval-last-sexp
 "C-x j"        'comment-region
 "C-x o"        'other-window
 "C-x Q"        'eab/kbd-macro-query
 "C-z"          'repeat
 "M-!"          'delete-window
 "M-%"          'query-replace-regexp
 "M-&"          'count-matches
 "M-'"          'comment-dwim
 "M-<"          'kmacro-start-macro
 "M-."          'kmacro-edit-macro
 "M-,"          'eab/kmacro-end-or-call-macro
 "C-M-,"        'eab/pm-write-last-kbd-macro
 "M-/"          'dabbrev-expand
 "M-1"          'delete-other-windows
 "M-2"          'split-window-vertically
 "M-5"          'query-replace
 "M-:"          'isearch-backward
 "M-;"          'isearch-forward
 "M-@"          'split-window-horizontally
 "M-B"          'backward-kill-sexp
 "M-C"          'copy-all
 "M-H"          'move-end-of-line
 "M-I"          'scroll-down
 "M-J"          'beginning-of-buffer
 "M-K"          'scroll-up
 "M-L"          'end-of-buffer
 "M-M"          'end-of-defun
 "M-N"          'beginning-of-defun
 "M-O"          'forward-paragraph
 "C-S-SPC"      'mark-defun
 "M-S-SPC"      'org-mark-paragraph
 "M-SPC"        'set-mark-command
 "C-M-@"        'set-rectangular-region-anchor
 "M-U"          'backward-paragraph
 "M-X"          'delete-region
 "M-b"          'kill-sexp
 "M-c"          'kill-ring-save
 "M-e"          'backward-kill-word
 "M-f"          'delete-char
 "M-F"          'delete-backward-char
 "M-g"          'kill-line
 "M-h"          'move-beginning-of-line
 "M-i"          'previous-line
 "M-j"          'backward-char
 "C-M-j"        'delete-backward-char
 "M-k"          'next-line
 "M-l"          'forward-char
 "M-o"          'forward-word
 "M-p"          'move-end-of-line
 "M-r"          'kill-word
 "M-u"          'backward-word
 "M-v"          'yank
 "M-x"          'kill-region
 ;; "M-y"               'god-mode-all
)

(general-define-key
 "<f10>"        'eab/flyspell-buffer
 "<f12>"        'eab/make-list-paths
 "<f6>"         'eab/revert-buffer
 "<f7>"         'eab/fix-windows-coding
 "<print>"      'eab/make-list-paths
 "C-,"          'eab/eepitch-this-line
 "C-r"          'eab/eepitch-this-line
 "C-M-r"        'eab/eepitch-paragraph
 "M-DEL"        'eab/completion-at-point
 "C-j"          'eab/completion-at-point
 "C-c RET"      'org-return
 "C-c c"        'eab/add-eab-abbrev
 "C-c d"        'nil
 "C-c O"        'eab/open-corresponding-html
 "C-c B"        'eab/open-heading-browser
 "C-c b"        'browse-url
 "C-c s"        'eab/org-agenda-search
 "C-c u"        'eab/unbound-var
 "C-c U"        'eab/unbound-fun
 "C-c v"        'nil
 "C-c w"        'nil
 "C-c e"        'eab/edit-list-at-point
 "C-x b"        'switch-to-buffer
 "C-x C-b"      'ibuffer
 "C-x g"        'eab/grep
 "C-x C-g"      (kbd "C-u C-x g")
 "M-."          'nil
 "M-A"          'eab/call-shell-command
)

;; shell and shell-utils
(general-define-key
 "C-c T"        'eab/google-translate
 "C-x T"        'eab/google-translate
 "C-S-f"        'eab/gr-status)

(general-define-key
 "C-c i"        'yas-expand)

(general-define-key
 "M-?"          'auto-complete
 "C-c g"        'eab/google
 "M-z"          'undo-tree-undo
 "C-b"          'eab/cxb
 "M-a"          'eab/smex-limited-commands
 "C-t"          'sp-transpose-sexp
 "M-m"          'sp-forward-sexp
 "M-n"          'sp-backward-sexp
 "C-:"          'isearch-moccur
 "C-c t"        'dictionary-search
 "C-f"          eab/explore-map
 "C-p"          'er/expand-region
 "C-x C-k d"    'pm-define
 "C-x C-k e"    'pm-switch-buf
 "C-x t"        'dictionary-search
 "M-V"          'helm-show-kill-ring
 "M-Z"          'undo-tree-redo
 "M-d"          'avy-goto-word-1
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;        _           _ _ _        _
;;       | |__  _   _(_) | |_     (_)_ __
;;       | '_ \| | | | | | __|____| | '_ \
;;       | |_) | |_| | | | ||_____| | | | |
;;       |_.__/ \__,_|_|_|\__|    |_|_| |_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; built-in

(general-define-key
 :keymaps 'isearch-mode-map
 "M-p"  'nil
 "M-n"  'nil
 "M-y"  'nil
 "M-c"  'nil
 "M-s"  'nil
 "C-y"  'nil
 "C-l"  'nil
 "M-r"  'isearch-edit-string
 "C-e"  'isearch-edit-string
 "M-;"  'isearch-repeat-forward
 "M-:"  'isearch-repeat-backward
 "M-v"  'isearch-yank-kill
 "M-k"  'isearch-ring-advance
 "M-i"  'isearch-ring-retreat
 "C-k"  'isearch-toggle-input-method
 "M-5"  'isearch-query-replace)

(general-define-key
 :keymaps 'read-expression-map
 "M-g"  'nil)

(general-define-key
 :keymaps 'isearch-mode-map
 "M-d" 'eab/isearch-ace-jump)

(general-define-key
 :keymaps 'query-replace-map
 "C-e"  'edit
 "C-r"  'delete-and-edit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 _     _       _                 _
;;        __ _  __| | __| |     | |__   ___   ___ | | __
;;       / _` |/ _` |/ _` |_____| '_ \ / _ \ / _ \| |/ /
;;      | (_| | (_| | (_| |_____| | | | (_) | (_) |   <
;;       \__,_|\__,_|\__,_|     |_| |_|\___/ \___/|_|\_\
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add-hook

(eab/add-hook fortran-mode-hook eab/fortran-hook
  (general-define-key
   :keymaps 'fortran-mode-map
   "C-d"        eab/compile-map))

(eab/add-hook text-mode-hook eab/text-hook
  (general-define-key
   :keymaps 'text-mode-map
   "C-c C-c"    'server-edit))

(define-advice artist-mode (:before (&rest args) eab-artist-mode)
  (general-define-key
   :keymaps 'artist-mode-map
   "C-b"        'nil))

(eab/add-hook nroff-mode-hook eab/nroff-hook
  (general-define-key
   :keymaps 'nroff-mode-map
   "M-s"        'nil
   "M-n"        'nil
   "M-p"        'nil))

(eab/add-hook eshell-mode-hook eab/eshell-hook
  (general-define-key
   :keymaps 'eshell-mode-map
   "M-s"        'nil
   "M-s"        'nil))

(eab/add-hook shell-mode-hook eab/shell-hook
  (general-define-key
   :keymaps 'shell-mode-map
   "M-p"        'nil
   "M-n"        'nil))

(eab/add-hook diff-mode-hook eab/diff-hook
  (general-define-key
   :keymaps 'diff-mode-map
   "M-SPC"      'nil
   "M-1"        'nil
   "M-2"        'nil
   "M-5"        'nil
   "M-k"        'nil
   "M-<"        'nil
   "M->"        'nil
   "M-K"        'nil
   "M-h"        'nil
   "M-n"        'nil
   "M-N"        'nil
   "M-o"        'nil
   "M-p"        'nil))

(eab/add-hook f90-mode-hook eab/f90-hook
  (general-define-key
   :keymaps 'f90-mode-map
   "C-j"        'nil
   "C-d"        eab/compile-map))

(eab/add-hook message-mode-hook eab/message-hook
  (general-define-key
   :keymaps 'message-mode-map
   "C-c C-c"    'eab/message-send
   "M-;"        'nil
   "M-n"        'nil))

(eab/add-hook makefile-gmake-mode-hook eab/makefile-gmake-mode
  (general-define-key
   :keymaps 'makefile-gmake-mode-map
   "\C-d"       eab/compile-map
   "M-n"        'nil
   "M-p"        'nil))

(eab/add-hook java-mode-hook eab/java-hook
  (general-define-key
   :keymaps 'java-mode-map
   "M-M"        'c-end-of-defun
   "M-N"        'c-beginning-of-defun
   "M-j"        'nil
   "M-a"        'nil
   "M-e"        'nil))

(eab/add-hook c-mode-hook eab/c-hook
  (general-define-key
   :keymaps 'c-mode-map
   "C-d"        eab/compile-map
   "C-M-a"      'nil
   "C-M-e"      'nil
   "M-a"        'nil
   "M-M"        'nil
   "M-N"        'nil
   "M-j"        'nil
   "M-q"        'nil
   "M-M"        'c-end-of-defun
   "M-N"        'c-beginning-of-defun
   "M-e"        'nil))

(eab/add-hook c++-mode-hook eab/c++-hook
  (general-define-key
   :keymaps 'c++-mode-map
   "C-d"        eab/compile-map
   "C-M-a"      'nil
   "C-M-e"      'nil
   "M-a"        'nil
   "M-M"        'nil
   "M-N"        'nil
   "M-j"        'nil
   "M-q"        'nil
   "M-M"        'c-end-of-defun
   "M-N"        'c-beginning-of-defun
   "M-e"        'nil))

(eab/add-hook ruby-mode-hook eab/ruby-hook
  (general-define-key
   :keymaps 'ruby-mode-map
   "C-d"        eab/compile-map
   "C-M-b"      'nil))

(eab/add-hook help-mode-hook eab/help-hook
  (general-define-key
   :keymaps 'help-mode-map
   "o"  'ace-link-help
   "B"  'help-go-back
   "F"  'help-go-forward))

(add-to-list 'auto-mode-alist '("\\.tmpl$" . conf-mode))
(add-to-list 'auto-mode-alist '("AUTOEXEC\\." . 'bat-mode))
(add-to-list 'auto-mode-alist '("CONFIG\\." . 'bat-mode))
(add-to-list 'auto-mode-alist '("\\.F90\\'" . f90-mode))
(add-to-list 'auto-mode-alist '("\\.[bB][aA][tT]$" . 'bat-mode))
(add-to-list 'auto-mode-alist '("\\.lsp\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.rtf\\'" . rtf-mode))

(autoload 'rtf-mode "rtf-mode" "RTF" t)
(autoload 'bat-mode "bat-mode" "DOS and WIndows BAT files" t)
