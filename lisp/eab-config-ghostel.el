;;; eab-config-ghostel.el --- eab-config ghostel configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package ghostel
  :after (eat key-chord eab-minimal)
  :config
  (setq ghostel-mode-map
        (let ((map (make-sparse-keymap)))
          (define-key map [?\C-c ?\M-d] #'ghostel-char-mode)
          (define-key map [?\C-c ?\C-j] #'ghostel-semi-char-mode)
          (define-key map [?\M-v] #'ghostel-yank)
          ;; (key-chord-define map "jj" #'ghostel-semi-char-mode)
          (define-key map [?\C-c ?\C-e] #'ghostel-emacs-mode)
          (define-key map (kbd "C-r") #'ghostel--send-event)
          map))

  (define-key ghostel-readonly-fast-exit-mode-map (kbd "C-r") #'ghostel--send-event)
  (define-key ghostel-readonly-mode-map (kbd "C-r") #'ghostel--send-event)

  (key-chord-define ghostel-readonly-fast-exit-mode-map "jj" #'ghostel-readonly-exit)
  (key-chord-define ghostel-readonly-mode-map "jj" #'ghostel-readonly-exit)

  (setq ghostel-semi-char-mode-map
        (let ((map (eat-term-make-keymap
                    #'ghostel--send-event
                    '(:ascii :arrow :navigation)
                    '( [?\C-\\] [?\C-q] [?\C-c] [?\C-g] [?\C-h]
                       [?\e ?\C-c] [?\C-u] [?\C-q] [?\e ?x] [?\e ?:]
                       [?\C-a] [?\C-l] [?\e ?a] [?\e ?s] [?\C-b] [?\e ?1]
                       [?\e ?c] [?\e ?v] [?\e ?g] [?\e ?h] [?\e ?p]
                       [?\C-p] [?\C-n] [?\C-v] [?\C-o] [?\C-e]
                       [?\e ?o] [?\e ?j] [?\e ?l] [?\e ?k] [?\e ?i]
                       [?\e ?!] [?\e ?&] [?\C-y] [?\e ?y]))))
          (define-key map (kbd "<C-return>") #'ghostel--send-event)
          (define-key map (kbd "<backtab>") #'ghostel--send-event)
          (define-key map (kbd "<escape>") #'ghostel--send-event)
          (define-key map [?\C-o] #'ghostel--send-event)
          (define-key map [?\C-k] #'toggle-input-method)
          (define-key map [?\C-y] #'ghostel-yank)
          (define-key map [?\M-v] #'ghostel-yank)
          (define-key map [?\M-y] #'ghostel-yank)
          (define-key map [?\M-m] (ilam-no-def (eab/eepitch-prepare-m-r)))
          (define-key map [?\M-r] (ilam-no-def (eab/m-r-ghostel)))
          (define-key map [?\M-j] (ilam-no-def (let ((last-command-event 'left)) (ghostel--send-event))))
          (define-key map [?\M-l] (ilam-no-def (let ((last-command-event 'right)) (ghostel--send-event))))
          (define-key map [?\M-k] (ilam-no-def (let ((last-command-event 'down)) (ghostel--send-event))))
          (define-key map [?\M-i] (ilam-no-def (let ((last-command-event 'up)) (ghostel--send-event))))
          (define-key map [?\M-K] (ilam-no-def (let ((last-command-event 'next)) (ghostel--send-event))))
          (define-key map [?\M-I] (ilam-no-def (let ((last-command-event 'prior)) (ghostel--send-event))))
          (define-key map [?\M-h] (ilam-no-def (let ((last-command-event 'home)) (ghostel--send-event))))
          (define-key map [?\M-p] (ilam-no-def (let ((last-command-event 'end)) (ghostel--send-event))))
          (define-key map [?\C-p] (ilam-no-def (let ((last-command-event 'up)) (ghostel--send-event))))
          (define-key map [?\C-n] (ilam-no-def (let ((last-command-event 'down)) (ghostel--send-event))))
          (define-key map [?\C-c ?\C-c] #'ghostel--send-event)
          (define-key map [?\C-c ?\C-e] #'ghostel-emacs-mode)
          (key-chord-define map "jj" #'ghostel-emacs-mode)
          map))

  (setq ghostel-char-mode-map
        (let ((map (eat-term-make-keymap
                    #'ghostel--send-event
                    '(:ascii :arrow :navigation :function)
                    '([?\e ?\C-m] [?\e ?s]))))
          (define-key map [?\C-\M-m] #'ghostel-semi-char-mode)
          map))

  ;; C-] doesn't work inside container
  (defun eab/m-r-ghostel ()
    (interactive)
    (execute-kbd-macro (read-kbd-macro "C-]"))
    (sleep-for 0.2)
    (ghostel-emacs-mode)
    (move-beginning-of-line 1)
    (call-interactively 'set-mark-command)
    (re-search-backward "^> EOF")
    (next-line)
    (call-interactively 'kill-ring-save)
    (ergoemacs-move-cursor-previous-pane -1)
    (yank)
    (ergoemacs-move-cursor-previous-pane -1)
    (ghostel-semi-char-mode)
    (sleep-for 0.2)
    (let ((last-command-event 'right))
      (ghostel--send-event)))

  (add-hook 'ghostel-mode-hook (lambda () (setq input-method-function 'key-chord-input-method)))

  )
