;;; eab-config-term.el --- eab-config term configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(if (eab/ondaemon "cyclos")
    (progn
      (setq eab/sync-rsync-command
            (eab/config (concat "ssh cyclos"
                    " screen -d -m bash -c \"echo; "
                    "rsync -WavR --files-from=/home/eab/.emacs.d/historyCyclos/recentf-eabpool /mnt/lion/ kairos:/mnt/lion/; "
                    "rsync -WavR --files-from=/home/eab/.emacs.d/historyCyclos/recentf-eabpool /mnt/lion/ chronos:/mnt/lion/; "
                    "/home/eab/git/auto/notify.sh -a " (eab/gotify-token) " -t \"OK\" -m \"rsync\" -p 0; "
                    "\"")))
      (setq eab/sync-zfs-command
            (eab/config (concat "ssh cyclos" " screen -d -m bash -c \"echo; syncoid.sh chronos kairos\"")))))

(if (eab/ondaemon "chronosP")
    (progn
      (setq eab/sync-rsync-command
            (eab/config (concat "ssh cyclos"
                    " screen -d -m bash -c \"echo; "
                    "rsync -WavR --files-from=/home/eab/.emacs.d/historyCyclos/recentf-eabpool /mnt/lion/ kairos:/mnt/lion/; "
                    "rsync -WavR --files-from=/home/eab/.emacs.d/historyCyclos/recentf-eabpool /mnt/lion/ cyclos:/mnt/lion/; "
                    "/home/eab/git/auto/notify.sh -a " (eab/gotify-token) " -t \"OK\" -m \"rsync\" -p 0; "
                    "\"")))
      (setq eab/sync-zfs-command
            (eab/config (concat "ssh chronos" " screen -d -m bash -c \"echo; syncoid.sh cyclos kairos\"")))))

(setq eab/dl.sh-command
      (eab/config (concat "ssh chronos" " dl.sh ")))

(setq eab/test-dotemacs-command
      ;; host=`dig test-dotemacs.salmon.eab.su TXT +short | tr -d '"'`
      (eab/config (concat "ssh chronos" " ~/git/auto/test-dotemacs.sh")))

(eab/redefine-keymap "C-l" 'recenter-top-bottom)
(general-define-key
 :prefix "C-l"
 "C-o"          'find-file
 "C-k"          (ilam (set-input-method nil) (setq default-input-method "russian-computer")) ;; "C-S-k" Disabled, bug
 "H"            'nil
 "C-h"          'nil
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
 "."            (kbd "C-c . RET")
 "M-."          (ilam (execute-kbd-macro (read-kbd-macro "C-c . RET C-l RET C-l l")))
 "O"            'esc-toggle-window-selectability
 "D"            'toggle-window-dedicated
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
 "M-b"          (ilam
                 (call-process-shell-command
                  (concat eab/dl.sh-command
                          (if region-bindings-mode
                              (buffer-substring (mark) (point))
                            (current-kill 0)))  nil 0))
 "M-s"          (ilam (call-process-shell-command eab/sync-rsync-command nil 0))
 "M-S"          (ilam (call-process-shell-command eab/sync-zfs-command nil 0)))
;; (lookup-key global-map (kbd "C-c")) ;; mode-specific-command-prefix
;; (lookup-key global-map (kbd "C-x")) ;; Control-X-prefix

(use-package term
  :config
  (defvar eab/temacs-map (make-sparse-keymap)
    "Keymap for console temacs.")
  ;; TODO: может присвоиться неполный комплект, если C-l будет еще в другом месте
  (setq eab/temacs-map (lookup-key global-map (kbd "C-l")))
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
     "C-n"        'term-send-down)))

(provide 'eab-config-term)