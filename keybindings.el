;;; keybindings.el ---

;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eab-minimal
  :after (cl-macs eab-workgroups2 workgroups2))
(use-package eab-workflow)

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
 "C-s-k"        '(:def (lambda (ch) "insert ch" (interactive "c") (insert ch)) :which-key "insert ch")
 "C-h C-c"      'describe-command
 "C-h c"        'eab/describe-key-briefly
 "C-h C-f"      'eab/find-function-at-point
 "C-h C-k"      'eab/describe-key-find
 "C-h C-v"      'eab/find-variable-at-point
 "C-x M-g"      (ilam (eab/grep 2))
)

(general-define-key
 "s-o"          'org-open-at-point
 "C-c a"        'org-agenda
 "C-c C-M-p"    'org-open-at-point-global
 "C-c C-l"      'org-insert-link
 "C-c l"        'org-store-link
 "C-c r"        'org-capture
 "C-x C-M-p"    'org-open-at-point-global
 "s-c"          'org-store-link
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
 "C-s-i"        'imenu
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
 "s-0"          'delete-window
 "s-2"          'split-window-below
 "M-%"          'query-replace-regexp
 "M-&"          'count-matches
 "M-'"          'comment-dwim
 "M-<"          'kmacro-start-macro
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
 "s-,"          'kmacro-end-or-call-macro-repeat
 "s-."          nil
 "s-m"          'kmacro-keymap
 "<kp-insert>"  'nil
 "s-a"          'append-to-buffer)

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
 "s-v"          'eab/org-insert-link-fast
 "s-h"          'eab/hron-todo)

;; shell and shell-utils
(general-define-key
 "C-c T"        'eab/google-translate
 "C-x T"        'eab/google-translate
 "s-f"          'eab/see-file
 "C-S-f"        'eab/gr-status)

(general-define-key
 "s-z"          'org-archive-set-tag
 "s-y"          'yas-minor-mode
 "C-c i"        'yas-expand)

(general-define-key
 "<f8>"         'eepitch-this-line
 "<kp-enter>"   'winner-undo
 "<kp-add>"     'nil
 "<kp-begin>"   'nil
 "<M-kp-equal>" 'nil
 "<kp-delete>"  (ilam (kill-buffer-and-window)))

(defvar eab/explore-map (make-sparse-keymap)
  "Keymap for minimal configuration")
(general-define-key
 :keymaps 'eab/explore-map
 "t"          'git-timemachine
 "a"          'vc-annotate
 "o"          'org-sort
 "e"          'ediff-buffers
 "c"          'eab/switch-or-clone-indirect-buffer
 "C"          (ilam (call-interactively 'clone-a-lot-goto-prev))
 "f"          'eab/magit-status
 "C-f"        'eab/magit-status
 "C-j"        'eab/magit-amend-modified
 "s"          'sort-lines
 "u"          'untabify
 "C-w"        'whitespace-mode
 "w"          'whitespace-mode)

(general-define-key
 "C-c g"        'eab/google
 "M-z"          'undo-tree-undo
 "C-b"          'eab/cxb
 "M-a"          'eab/smex-limited-commands
 "C-t"          'sp-transpose-sexp
 "M-m"          'sp-forward-sexp
 "M-n"          'sp-backward-sexp
 "M-?"          (ilam (auto-complete))
 "s-k"          (ilam (if (equal current-input-method "TeX") (set-input-method "russian-computer") (set-input-method "TeX")) (setq default-input-method "russian-computer"))
 "C-s"          (ilam (save-some-buffers 't))
 "C-:"          'isearch-moccur
 "C-c t"        'dictionary-search
 "C-f"          eab/explore-map
 "C-p"          'er/expand-region
 "C-s-l"        'helm-locate
 "C-x C-k d"    'pm-define
 "C-x C-k e"    'pm-switch-buf
 "C-x t"        'dictionary-search
 "M-V"          'helm-show-kill-ring
 "M-Z"          'undo-tree-redo
 "M-d"          'avy-goto-word-1
 "s-Y"          'auto-complete-mode
 "s-g"          'helm-google-suggest
 "s-/"          'ac-start
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
 :keymaps 'minibuffer-local-completion-map
 "M-g"  'nil
 "C-r"  'nil
 "M-n"  'nil
 "M-p"  'nil
 "M-v"  'nil
 "M-s"  'nil)

(general-define-key
 :keymaps 'minibuffer-local-map
 "C-q"          'quoted-insert
 "M-;"          'isearch-backward
 "C-l M-i"      'previous-line
 "C-l M-k"      'next-line
 "M-RET"        (ilam
                 (run-with-timer
                  0.01 nil
                  `(lambda ()
                     (eab/helm-org-goto-marker ,eab/helm-org-goto-marker)))
                 (if (string= (minibuffer-contents) "")
                     (abort-recursive-edit)
                   (exit-minibuffer)))
 "M-c"          (ilam
                 (run-with-timer
                  0.01 nil
                  `(lambda ()
                     (save-window-excursion
                       (eab/helm-org-goto-marker ,eab/helm-org-goto-marker)
                       (call-interactively 'org-store-link))))
                 (if (string= (minibuffer-contents) "")
                     (abort-recursive-edit)
                   (exit-minibuffer)))
 "M-i"          'previous-history-element
 "M-r"          'nil
 "M-p"          'nil
 "M-n"          'nil
 "M-x"          'nil
 "M-I"          'previous-matching-history-element
 "M-K"          'next-matching-history-element
 "M-v"          'nil
 "M-:"          'helm-minibuffer-history
 "M-k"          'next-history-element
 "C-d"          'eab/clear-extended-history
 "C-|"          'eab/minibuffer-see-file
 "s-SPC"        'eab/ido-see-file
 "M-a"          'eab/smex-extended
 "C-w"          'eab/smex-repeat
 "M-E"          (ilam (delete-minibuffer-contents)))

(general-define-key
 :keymaps 'kmacro-keymap
 "m"    'kmacro-start-macro
 ","    'kmacro-end-or-call-macro-repeat
 "i"    'kmacro-insert-counter
 "s"    'kmacro-set-counter
 "v"    'insert-kbd-macro)

(general-define-key
 :keymaps 'isearch-mode-map
 "M-d" 'eab/isearch-ace-jump)

(general-define-key
 :keymaps 'minibuffer-inactive-mode-map
 "o"    'eab/screen-off
 "t"    (ilam (eab/gnome-terminal) (suspend-frame))
 "q"    'suspend-frame)

(general-define-key
 :keymaps 'query-replace-map
 "C-e"  'edit
 "C-r"  'delete-and-edit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;       _  __
;;      | |/ /___ _   _ _ __ ___   __ _ _ __  ___
;;      | ' // _ \ | | | '_ ` _ \ / _` | '_ \/ __|
;;      | . \  __/ |_| | | | | | | (_| | |_) \__ \
;;      |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
;;                |___/                |_|
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keymaps

(defvar eab/temacs-map (make-sparse-keymap)
  "Keymap for console temacs.")
(global-set-key (kbd "C-l") nil)
(general-define-key
 :prefix "C-l"
 "C-o"          'find-file
 "C-k"          (ilam (set-input-method nil) (setq default-input-method "russian-computer")) ;; "C-S-k" Disabled, bug
 "H"            'nil
 "C-h"          'nil
 "c"            'org-store-link
 "M-c"          'org-copy-special
 "M-x"          'org-cut-special
 "M-v"          'org-paste-special
 "p"            'org-priority-up
 "i"            'org-metaup
 "k"            'org-metadown
 "j"            'org-metaleft
 "l"            'org-metaright
 "<backtab>"    (ilam (org-content 6) (org-fold-hide-drawer-all))
 "M-k"          'org-shiftdown
 "M-i"          'org-shiftup
 "M-j"          'org-shiftleft
 "M-l"          'org-shiftright
 "K"            'org-shiftmetadown
 "I"            'org-shiftmetaup
 "J"            'org-shiftmetaleft
 "L"            'org-shiftmetaright
 "RET"          'org-meta-return
 "C-<return>"   'org-insert-heading-respect-content
 "C-j"          'org-insert-heading-respect-content
 "C-M-j"        'org-insert-heading-respect-content
 "o"            'org-open-at-point
 "'"            'org-edit-special
 "C-h"          'nil
 "C-s"          'nil
 "b"            'nil
 "w"            'whitespace-mode
 "W"            'subword-mode
 "C-l"          'recenter-top-bottom
 "a"            'append-to-buffer
 "m"            'kmacro-keymap
 ","            'kmacro-end-or-call-macro-repeat
 "x"            'kmacro-keymap
 "C-x"          ctl-x-map  ;; Control-X-prefix
 "M-a"          'eval-expression
 "u"            'rename-uniquely
 "S"            'toggle-truncate-lines
 "d"            'toggle-debug-on-error
 "M-f"          'ispell-change-dictionary
 "F"            'flyspell-mode
 "q"            'ergoemacs-open-last-closed
 "/"            'ergoemacs-toggle-letter-case
 "C-f"          'eab/gr-status
 "h"            'eab/hron-todo
 "C-h"          'eab/hron-todo
 "M-h"          'eab/jump-current-time
 "v"            'eab/org-insert-link-fast
 "V"            'org-insert-link
 "C-v"          'eab/org-insert-capture-from-clipboard
 "."            (kbd "C-c . RET")
 "M-."          (ilam (execute-kbd-macro (read-kbd-macro "C-c . RET C-l RET C-l l")))
 "O"            'esc-toggle-window-selectability
 "D"            'toggle-window-dedicated
 "<tab>"        (ilam (progn (show-all) (run-hook-with-args 'org-cycle-hook 'all)))
 "z"            'org-archive-set-tag
 "b"            'eab/bookmark-set
 "B"            'eab/bookmark-delete
 "C-b"          'eab/bookmark-jump
 "nf"           'eab/pm-write-last-kbd-macro
 "nw"           'widen
 "Y"            'auto-complete-mode
 "g"            'eab/kill-last-grep
 "y"            'yas-minor-mode
 "P"            'smartparens-global-mode
 ";"            'isearch-moccur
 "r"            'region-bindings-mode
 ;; shell and shell-utils
 "f"            'eab/see-file
 "SPC"          'eab/gr-tag-default-directory
 "M-d"          (ilam (call-process-shell-command eab/test-dotemacs-command nil 0))
 "M-b"          (ilam (call-process-shell-command (concat eab/dl.sh-command (current-kill 0))  nil 0))
 "M-s"          (ilam (call-process-shell-command eab/sync-rsync-command nil 0))
 "M-S"          (ilam (call-process-shell-command eab/sync-zfs-command nil 0)))
(setq eab/temacs-map (lookup-key global-map (kbd "C-l")))
;; (lookup-key global-map (kbd "C-c")) ;; mode-specific-command-prefix
;; (lookup-key global-map (kbd "C-x")) ;; Control-X-prefix

 (defvar eab/one-key-map (make-sparse-keymap)
   "One-key keymap.")
(global-set-key (kbd "C-e") nil)
(general-define-key
 :prefix "C-e"
 "b"    'eab/switch-browser
 "v"    'eab/switch-viewer
 "t"    'eab/switch-eepitch-target
 "a"    (ilam (eepitch-ansi-term "1"))
 "1"    (ilam (eepitch-ansi-term "1"))
 "2"    (ilam (eepitch-ansi-term "2"))
 "3"    (ilam (eepitch-ansi-term "3"))
 "4"    (ilam (eepitch-ansi-term "4"))
 "5"    (ilam (eepitch-ansi-term "5"))
 "6"    (ilam (eepitch-ansi-term "6"))
 "7"    (ilam (eepitch-ansi-term "7"))
 "8"    (ilam (eepitch-ansi-term "8"))
 "9"    (ilam (eepitch-ansi-term "9"))
 "c"    'eab/switch-compile
 "d c"  '(:def (ilam-no-def (setq eab/daemons-host "chronos") (call-interactively 'eab/daemons)) :which-key "(c)hronos")
 "d k"  (ilam (setq eab/daemons-host "kairos") (call-interactively 'eab/daemons))
 "d y"  (ilam (setq eab/daemons-host "cyclos") (call-interactively 'eab/daemons))
 "x"    (ilam
         (eab/sh-over-bash eab/emacs-service-command "" 't))
 "X"    (ilam
         (desktop-save (eab/desktop-dir))
         (run-with-timer 0.1 nil 'kill-emacs)
         (eab/sh-over-bash
          (concat "sleep 0.3 && emacs --daemon=" eab/daemon-name) "" 't))
 "h"    'eab/switch-help
 "z"    'undo-tree-visualize
 "s"    'eab/switch-async
 "S"    'eab/switch-shell
 "m"    'eab/switch-message
 "k"    (ilam (eepitch-kill))
 "o"    'proced
 "g"    'eab/switch-grep
 "G"    'eab/kill-last-grep
 "l"    'helm-locate
 "C"    'docker-containers
 "I"    'docker-images)
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
 "a"            (ilam (eab/wg-switch-to-workgroup ":clock:"))
 "A"            (ilam (eab/wg-switch-to-workgroup ":auto:"))
 "e"            (ilam (eab/wg-switch-to-workgroup ":eab-spacemacs:"))
 "4"            (ilam (eab/wg-switch-to-workgroup ":portal:"))
 "b"            (ilam (eab/wg-switch-to-workgroup ":fz:"))
 "p"            'eab/wg-switch-to-previous-workgroup
 "o"            'eab/wg-rotate-base
 "O"            'eab/wg-rotate-twice
 "P"            'eab/wg-switch-to-previous-workgroup-1
 "s"            'eab/wg-switch-to-workgroup-history ;; +
 "S"            'wg-switch-to-workgroup ;; +
 "x"            'wg-kill-ring-save-working-config ;; wg-kill-ring-save-working-wconfig
 "v"            'wg-yank-config ;; wg-yank-wconfig
 "r"            'eab/wg-revert-workgroup
 "R"            'wg-revert-workgroup ;; +
 "u"            (ilam (eab/wg-update-workgroup "dflt"))
 "U"            'wg-save-session ;; wg-update-workgroup
 ;;  "S"        'eab/eab-wg-save
 ;;  "L"        'eab/eab-wg-load
 ;; TODO wg-make-workgroups-mode-map
 "z"            'winner-undo
 "C-z"          'winner-undo
 "Z"            'winner-redo
 "n"            'eab/wg-create-workgroup-xxx ;; +
 "N"            'wg-create-workgroup ;; +
 "k"            'wg-kill-workgroup ;; +
 "c"            (ilam (eab/wg-kill-tmp) (wg-clone-workgroup (wg-current-workgroup) ":tmp:")) ;; +
 "SPC"          'eab/wg-revert-and-update
 ;; DONE по имени буфера: нарушение SPOT!
 "M-h"          'eab/helm-org-agenda-files-headings
 "C-h"          (ilam (eab/org-ql-switch 'eab/org-ql-H-query))
 "h"            'eab/helm-org-agenda-files-headings
 "H"            (ilam (eab/org-ql-search 'eab/org-ql-H-query))
 "t"            (ilam (eab/org-ql-switch 'eab/org-ql-T-query))
 "T"            (ilam (eab/org-ql-search 'eab/org-ql-T-query))
 "0"            (ilam (eab/org-ql-switch 'eab/org-ql-O-query))
 ")"            (ilam (eab/org-ql-search 'eab/org-ql-O-query))
 "w"            'window-toggle-side-windows
 ;; "w"            (ilam (eab/org-ql-switch 'eab/org-ql-W-query))
 ;; "W"            (ilam (eab/org-ql-search 'eab/org-ql-W-query))
 "C-s"          'eab/gotify-status)
(setq eab/wg-map (lookup-key global-map (kbd "C-a")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 _     _       _                 _
;;        __ _  __| | __| |     | |__   ___   ___ | | __
;;       / _` |/ _` |/ _` |_____| '_ \ / _ \ / _ \| |/ /
;;      | (_| | (_| | (_| |_____| | | | (_) | (_) |   <
;;       \__,_|\__,_|\__,_|     |_| |_|\___/ \___/|_|\_\
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add-hook

(eab/add-hook groovy-mode-hook eab/groovy-hook
  (general-define-key
   :keymaps 'groovy-mode-map
   "C-i"        'eab/outline-toggle-children
   "<backtab>"  'eab/outline-toggle-all))

(eab/add-hook git-rebase-mode-hook eab/git-rebase-hook
  (general-define-key
   :keymaps 'git-rebase-mode-map
   "d"          'git-rebase-kill-line
   "p"          'git-rebase-pick
   "M-n"        'git-rebase-move-line-down
   "M-p"        'git-rebase-move-line-up))

(eab/add-hook proced-mode-hook eab/proced-hook
  (general-define-key
   :keymaps 'proced-mode-map
   "O"  'top))

(eab/add-hook bibtex-mode-hook eab/bibtex-hook
  (general-define-key
   :keymaps 'bibtex-mode-map
   "C-M-\\"     'bibtex-fill-entry))

(eab/add-hook fortran-mode-hook eab/fortran-hook
  (general-define-key
   :keymaps 'fortran-mode-map
   "C-d"        eab/compile-map))

(eab/add-hook ag-mode-hook eab/ag-hook
  (general-define-key
   :keymaps 'ag-mode-map
   "C-w"        'eab/wgrep-change-to-wgrep-mode))

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

(eab/add-hook moccur-mode eab/moccur-hook
  (general-define-key
   :keymaps 'moccur-mode-map
   "M-n"        'nil
   "M-p"        'nil
   "M-m"        'nil
   "M-d"        'nil))

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

(eab/add-hook term-mode-hook eab/term-hook
  (general-define-key
   :keymaps 'term-mode-map
   "M-q"        'nil
   "M-s"        'nil
   "M-n"        'nil
   "M-p"        'nil
   "C-r"        (ilam (term-send-raw-string "\C-r"))
   "<tab>"      'eab/wrap-tab
   "C-p"        'term-previous-input
   "C-n"        'term-next-input)

  (key-chord-define term-mode-map "jj" 'term-char-mode)
  (key-chord-define term-raw-map "jj" 'term-line-mode)

  (general-define-key
   :keymaps 'term-raw-map
   "M-a"        'nil
   "M-r"        (ilam (let ((output (replace-regexp-in-string
                        "\n" ""
                        (let ((bol (save-excursion
                                     (re-search-backward "reverse-i-search")
                                     (re-search-forward ": "))))
                          (buffer-substring bol (point-max))))))
                        (with-current-buffer (get-buffer-create "untitled")
                          (progn
                            (insert output)
                            (insert "\n")))))
   "M-A"        'nil
   "M-q"        'nil
   "M-Q"        'nil
   "M-v"        'nil
   "M-g"        'nil
   "M-V"        'nil
   "M-z"        'nil
   "M-s"        'nil
   "C-b"        'nil
   "C-a"        'nil
   "C-e"        'nil
   "C-o"        'nil
   "C-h"        'nil
   "M-1"        'nil
   "C-r"        'term-send-raw
   "C-l"        eab/temacs-map
   "M-h"        'term-send-home
   "M-p"        'term-send-end
   "M-j"        'term-send-left
   "M-l"        'term-send-right
   "M-k"        'term-send-up
   "M-i"        'term-send-down
   "C-p"        'term-send-up
   "C-n"        'term-send-down))

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

(eab/add-hook eww-mode-hook eab/eww-hook
  (general-define-key
   :keymaps 'eww-mode-map
   "M-I"  'nil
   ))

(use-package eab-depend)
