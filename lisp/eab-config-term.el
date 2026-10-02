;;; eab-config-term.el --- eab-config term configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(general-define-key
 :keymaps 'eab/ctrl-l-map
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
 "C-x"          ctl-x-map ;; Control-X-prefix
 "M-a"          'eval-expression
 "u"            'rename-uniquely
 "d"            'toggle-debug-on-error
 "M-f"          'ispell-change-dictionary
 "nw"           'widen
 ";"            'isearch-moccur
 "r"            'region-bindings-mode
 )
;; (lookup-key global-map (kbd "C-c")) ;; mode-specific-command-prefix
;; (lookup-key global-map (kbd "C-x")) ;; Control-X-prefix

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

(provide 'eab-config-term)