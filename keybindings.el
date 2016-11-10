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
 "M-n" 'backward-sexp)

(general-define-key
 :keymaps 'kmacro-keymap
 "m" 'kmacro-start-macro
 "," 'kmacro-end-or-call-macro-repeat
 "i" 'kmacro-insert-counter
 "s" 'kmacro-set-counter
 "v" 'insert-kbd-macro)

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
