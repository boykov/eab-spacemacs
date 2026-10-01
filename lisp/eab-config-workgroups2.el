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
  (eab/redefine-keymap "C-e" 'move-end-of-line)
  (general-define-key
   :prefix "C-e"
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
  (eab/redefine-keymap "C-l" 'recenter-top-bottom)
  (general-define-key
   :prefix "C-l"
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
  (setq eab/wg-map (lookup-key global-map (kbd "C-a")))
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
  :after (autorevert eab-workgroups2))

(use-package eab-bookmark
  :after (eab-minimal eab-workgroups2)
  :config
  (eab/redefine-keymap "C-l" 'recenter-top-bottom)
  (general-define-key
   :prefix "C-l"
   "b"            'eab/bookmark-set
   "B"            'eab/bookmark-delete
   "C-b"          'eab/bookmark-jump
   ))

(provide 'eab-config-workgroups2)
