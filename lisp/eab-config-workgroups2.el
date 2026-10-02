;;; eab-config-workgroups2.el --- eab-config workgroups2 configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eab-window
  :config
  (general-define-key
   "M-@"          'split-window-horizontally
   "M-2"          'split-window-vertically
   "M-1"          'delete-other-windows
   "C-x o"        'other-window
   "M-!"          'delete-window
   "C-x b"        'switch-to-buffer
   )
  (general-define-key
   :keymaps 'eab/ctrl-l-map
   "C-l"          'recenter-top-bottom
   "O"            'esc-toggle-window-selectability
   "D"            'toggle-window-dedicated
   "g"            'eab/kill-last-grep)
  (general-define-key
   :keymaps 'eab/one-key-map
   "G"    'eab/kill-last-grep
   "g"    'eab/switch-grep
   "s"    'eab/switch-async
   "S"    'eab/switch-shell
   "m"    'eab/switch-message
   "h"    'eab/switch-help
   "c"    'eab/switch-compile
   "b"    'eab/switch-browser
   "v"    'eab/switch-viewer
   "t"    'eab/switch-eepitch-target
   ))

(use-package buffer-move
  :config
  (general-define-key
   :keymaps 'eab/ctrl-l-map
   "s"            'buf-move
   )
  (defun buf-move ()
    "Begin moving the current buffer to different windows.
Use the arrow keys to move in the desired direction.  Pressing
any other key exits this function."
    (interactive)
    (let ((map (make-sparse-keymap)))
      (dolist (x '(("M-i" . buf-move-up)
                   ("M-j" . buf-move-left)
                   ("M-k" . buf-move-down)
                   ("M-l" . buf-move-right)))
        (define-key map (read-kbd-macro (car x)) (cdr x)))
      (set-transient-map map t))))

(use-package eab-workgroups2
  :load-path "~/.emacs.d/private/eab-spacemacs/local/workgroups2/src"
  :after (eab-minimal eab-notify)
  :init
  (setq eab/workgroups-save
        (eab/config (concat (eab/history-dir) ".emacs_workgroups")))
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
  (general-define-key
   :keymaps 'eab/wg-map
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
   "S"            'wg-switch-to-workgroup             ;; +
   "x"            'wg-kill-ring-save-working-config ;; wg-kill-ring-save-working-wconfig
   "v"            'wg-yank-config                   ;; wg-yank-wconfig
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
   "N"            'wg-create-workgroup         ;; +
   "k"            'wg-kill-workgroup           ;; +
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
  :config
  (setq wg-use-default-session-file 't)
  (setq wg-control-frames 'nil)
  (setq wg-session-load-on-start nil)
  (ignore-errors (workgroups-mode 1))
  (setq wg-mode-line-decor-divider "")
  (setq eab/wg-path (eab/config "~/git/eab-system/wg/*"))
  (defun eab/wg-update-list-1 (path)
    (let* ((true-path (file-truename path))
           (nondir (file-name-nondirectory path))
           (name nondir))
      `(,true-path ,name)))
  (setq eab/wg-update-list
        (mapcar 'eab/wg-update-list-1 (file-expand-wildcards eab/wg-path)))
  (eab/wg-init))

(use-package eab-desktop
  :after (autorevert eab-workgroups2)
  :config
  (general-define-key
   :keymaps 'eab/one-key-map
   "X"    (ilam
           (desktop-save (eab/desktop-dir))
           (run-with-timer 0.1 nil 'kill-emacs)
           (eab/sh-over-bash
            (concat "sleep 0.3 && emacs --daemon=" eab/daemon-name) "" 't))))

(use-package eab-bookmark
  :after (eab-minimal eab-workgroups2)
  :config
  (general-define-key
   :keymaps 'eab/ctrl-l-map
   "b"            'eab/bookmark-set
   "B"            'eab/bookmark-delete
   "C-b"          'eab/bookmark-jump
   )
  (general-define-key
   :keymaps 'bookmark-minibuffer-read-name-map
   "C-l" (ilam
          (let ((string
                 (with-current-buffer
                     bookmark-current-buffer
                   (eab/replace-in-string "{{{kb_hide}}}" "" (thing-at-point 'line)))))
            (insert (substring string 0 -1))))))

(use-package eab-workflow
  :config
  (general-define-key
   "C-M-f"        'toggle-frame-maximized
   "C-h C-c"      'describe-command
   "C-h c"        'eab/describe-key-briefly
   "C-h C-f"      'eab/find-function-at-point
   "C-h C-k"      'eab/describe-key-find
   "C-h C-v"      'eab/find-variable-at-point
   "<f7>"         'eab/fix-windows-coding
   "<f6>"         'eab/revert-buffer
   "C-c u"        'eab/unbound-var
   "C-c U"        'eab/unbound-fun
   ))

(use-package eab-outline
  :after (eab-minimal))

(use-package eab-ido
  :after (projectile eab-minimal)
  :config
  (general-define-key
   "C-b"          'eab/cxb
   )
  (eab/add-hook ido-minibuffer-setup-hook eab/ido-minibuffer-hook
    (general-define-key
     :keymaps 'ido-file-dir-completion-map
     "M-v"        'yank)
    (general-define-key
     :keymaps 'ido-file-completion-map
     "C-n"        (eab/do-action
                   (ilam-no-def
                    (execute-kbd-macro
                     (read-kbd-macro
                      "C-x C-f / 2*s h : k a i r o s - h o s t | s u d o : k a i r o s - h o s t : / C-x Q"))))
     "C-d"        'eab/ace-ibuffer
     "C-|"        'eab/ido-see-file
     )
    (general-define-key
     :keymaps 'ido-common-completion-map
     "C-v"        'eab/toggle-cxb-ido-item
     )
    (general-define-key
     :keymaps 'ido-buffer-completion-map
     "C-k"        'nil
     "C-d"        'eab/ace-ibuffer
     "M-RET"      'eab/ido-main
     "C-M-j"      'eab/ido-main
     ))
  (setq ido-save-directory-list-file
        (eab/config (concat (eab/history-dir) ".ido.last"))))

(use-package eab-smex
  :after (helm eab-minimal)
  :config
  (general-define-key
   :keymaps 'minibuffer-local-map
   "M-a"          'eab/smex-extended
   "C-w"          'eab/smex-repeat)
  (general-define-key
   "M-a"          'eab/smex-limited-commands)
  (setq smex-save-file (eab/config (concat (eab/history-dir) ".smex-items"))))

(use-package undo-tree
  :config
  (general-define-key
   :keymaps 'eab/one-key-map
   "z"    'undo-tree-visualize
   )
  (general-define-key
   "M-z"          'undo-tree-undo
   "M-Z"          'undo-tree-redo
   )
  (global-undo-tree-mode))

(use-package redo+
  :config
  (general-define-key
   "M-z"          'undo))

(provide 'eab-config-workgroups2)
