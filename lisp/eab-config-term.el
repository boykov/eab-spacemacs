;;; eab-config-term.el --- eab-config term configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

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

(provide 'eab-config-term)