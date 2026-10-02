;;; eab-config-term.el --- eab-config term configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package term
  :config
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
     "C-l"        eab/ctrl-l-map
     "M-h"        'term-send-home
     "M-p"        'term-send-end
     "M-j"        'term-send-left
     "M-l"        'term-send-right
     "M-k"        'term-send-up
     "M-i"        'term-send-down
     "C-p"        'term-send-up
     "C-n"        'term-send-down)))

(use-package eab-eepitch
  :config
  (general-define-key
   :keymaps 'eab/one-key-map
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
   "k"    (ilam (eepitch-kill))
   )
  (general-define-key
   "C-,"          'eab/eepitch-this-line
   "C-r"          'eab/eepitch-this-line
   "C-M-r"        'eab/eepitch-paragraph
   )
  (setq eab/eeansi-path (eab/config (expand-file-name "~/.eev/eeansi.sh")))
  (setq eab/eegchannel-path
        (eab/config
         (expand-file-name (concat eab-spacemacs-path "local/eev-current/eegchannel"))))
  (setq vterm-shell eab/eeansi-path))

(use-package vterm
  :config
  (setq
   vterm-keymap-exceptions
   '(
     "C-c" "C-x" "C-u" "C-g" "C-h" "C-l" "M-x" "M-o" "C-v" "M-v"
     "C-y" "M-y" "M-s" "M-a" "M-i" "M-k" "M-j" "M-l" "C-a" "M-c" "M-p"))
  (defun vterm-send-meta-c-b ()
    "Send `M-<backspace>' to the libvterm."
    (interactive)
    (vterm-send-key "b" nil t t)))

(provide 'eab-config-term)