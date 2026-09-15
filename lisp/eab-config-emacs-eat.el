;;; eab-config-emacs-eat.el --- eab-config emacs-eat configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eat
  :after (key-chord eab-minimal)
  :config
  (setq eat-mode-map
        (let ((map (make-sparse-keymap)))
          (define-key map [?\C-c ?\M-d] #'eat-char-mode)
          (define-key map [?\C-c ?\C-j] #'eat-semi-char-mode)
          (define-key map [?\C-c ?\C-k] #'eat-kill-process)
          (define-key map [?\C-c ?\C-p] #'eat-previous-shell-prompt)
          (define-key map [?\C-c ?\C-n] #'eat-next-shell-prompt)
          (key-chord-define map "jj" #'eat-semi-char-mode)
          (define-key map [?\C-c ?\C-e] #'eat-semi-char-mode)
          map))

  (setq eat-semi-char-mode-map
        (let ((map (eat-term-make-keymap
                    #'eat-self-input
                    '(:ascii :arrow :navigation)
                    '( [?\C-\\] [?\C-q] [?\C-c] [?\C-x] [?\C-g] [?\C-h]
                       [?\e ?\C-c] [?\C-u] [?\C-q] [?\e ?x] [?\e ?:]
                       [?\C-a] [?\C-l] [?\e ?a] [?\e ?s] [?\C-b] [?\e ?1]
                       [?\e ?c] [?\e ?v] [?\e ?g] [?\e ?h] [?\e ?p]
                       [?\C-p] [?\C-n] [?\C-v] [?\C-o] [?\C-e]
                       [?\e ?o] [?\e ?j] [?\e ?l] [?\e ?k] [?\e ?i] [?\e ?\s]
                       [?\e ?!] [?\e ?&] [?\C-y] [?\e ?y]))))
          (define-key map [?\C-q] #'eat-quoted-input)
          (define-key map [?\C-y] #'eat-yank)
          (define-key map [?\M-v] #'eat-yank)
          (define-key map [?\M-y] #'eat-yank-from-kill-ring)
          (define-key map [?\M-m] (ilam (eab/eepitch-prepare-m-r)))
          (define-key map [?\M-r] (ilam (eab/m-r)))
          (define-key map [?\M-j] (ilam (eat-self-input 1 'left)))
          (define-key map [?\M-l] (ilam (eat-self-input 1 'right)))
          (define-key map [?\M-k] (ilam (eat-self-input 1 'down)))
          (define-key map [?\M-i] (ilam (eat-self-input 1 'up)))
          (define-key map [?\M-h] (ilam (eat-self-input 1 'home)))
          (define-key map [?\M-p] (ilam (eat-self-input 1 'end)))
          (define-key map [?\C-p] (ilam (eat-self-input 1 'up)))
          (define-key map [?\C-n] (ilam (eat-self-input 1 'down)))
          (define-key map [?\C-c ?\C-c] #'eat-self-input)
          (define-key map [?\C-c ?\C-e] #'eat-emacs-mode)
          (define-key map [remap insert-char] #'eat-input-char)
          (key-chord-define map "jj" #'eat-emacs-mode)
          map))

  (setq eat-char-mode-map
        (let ((map (eat-term-make-keymap
                    #'eat-self-input
                    '(:ascii :arrow :navigation :function)
                    '([?\e ?\C-m]))))
          (define-key map [?\C-\M-m] #'eat-semi-char-mode)
          map))

  (define-minor-mode eat--semi-char-mode
    "Minor mode for semi-char mode keymap."
    :interactive nil
    :keymap eat-semi-char-mode-map)

  (define-minor-mode eat--char-mode
    "Minor mode for char mode keymap."
    :interactive nil
    :keymap eat-char-mode-map)

  (defun eab/m-r ()
    (interactive)
    (execute-kbd-macro (read-kbd-macro "C-]"))
    (sleep-for 0.2)
    (eat-emacs-mode)
    (move-beginning-of-line 1)
    (call-interactively 'set-mark-command)
    (re-search-backward "^> EOF")
    (next-line)
    (call-interactively 'kill-ring-save)
    (ergoemacs-move-cursor-previous-pane -1)
    (yank)
    (ergoemacs-move-cursor-previous-pane -1)
    (eat-semi-char-mode)
    (sleep-for 0.2)
    (eat-self-input 1 'right))

  (eab/patch-this-code
   'eat
   `((,(let ((print-quoted 't))
         (prin1-to-string
          `(format "%s<%d>" eat-buffer-name arg))) .
          ,(let ((print-quoted 't))
             (prin1-to-string
              `(format "*ansi-term%d*" arg))))))

  (add-hook 'eat--semi-char-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))
  ;; (add-hook 'eat--char-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))
  (add-hook 'eat-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))

  (custom-set-faces
   '(eat-term-color-4 ((t (:inherit eat-term-color-32))))))
