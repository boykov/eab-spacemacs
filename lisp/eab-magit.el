;;; eab-magit.el --- eab magit configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package magit
  :defer
  :config
  (eab/add-hook magit-mode-hook eab/magit-hook
    (general-define-key
     :keymaps 'magit-log-mode-map
     "C-l M-n"    'log-edit-next-comment
     "C-l M-p"    'log-edit-previous-comment
     "M-n"        'nil
     "M-p"        'nil
     "C-d"        'nil)
    (general-define-key
     :keymaps 'magit-revision-mode-map
     "C-j"        'magit-diff-visit-file
     "RET"        'magit-diff-visit-worktree-file
     "C-d"        'nil)
    (general-define-key
     :keymaps 'magit-status-mode-map
     "C-d"        'nil)
    ;;  "C-f"     'magit-show-only-files
    ;;  "C-F"     'magit-show-only-files-all
    (general-define-key
     :keymaps 'magit-mode-map
     "J"          'magit-commit-amend
     "R"          (kbd "r - A e o r i g i n / m a s t e r RET")
     "N"          (kbd "P o m a s t e r 2*RET")
     "{"          (ilam (execute-kbd-macro (read-kbd-macro "C-u S ESC A g i t SPC c o 2*m i t SPC - m SPC u p d a t e RET g")))
     "M-n"        'nil
     "M-p"        'nil
     "M-s"        'nil
     "M-S"        'nil
     "M-h"        'nil
     "M-H"        'nil
     "M-1"        'nil
     "M-2"        'nil
     "M-g"        'magit-fetch-all
     "C-d"        'nil
     "C-D"        'magit-section-show-level-4-all
     "s-1"        'magit-section-show-level-1-all
     "s-2"        'magit-section-show-level-2-all
     "<backtab>"  'magit-section-show-level-2-all
     "s-3"        'magit-section-show-level-3-all
     "s-4"        'magit-section-show-level-4-all)
    (general-define-key
     :keymaps 'git-commit-mode-map
     "C-v c"      'gptel-magit-generate-message
     "M-n"        'nil
     "M-p"        'nil))
  (transient-append-suffix 'magit-diff "-A"
    '("-a" "Treat all files as text." "--text"))
  (transient-append-suffix 'magit-diff "-a"
    '("-S" "Submodule diff" "--submodule=diff"))
  (setq magit-section-visibility-indicator nil)
  (defun eab/magit-amend-modified ()
    (interactive)
    (magit-stage-modified)
    (call-interactively 'magit-commit-amend)))
(eab/add-hook magit-file-mode-hook eab/magit-file-mode-hook
  (general-define-key
   :keymaps 'magit-file-mode-map
   "C-x g"      'nil
   ))
(use-package magit-status
  :after (magit)
  :config
  (add-to-list 'magit-status-sections-hook 'magit-insert-modules 't))
(define-advice vc-annotate (:before (&rest args) eab-vc-annotate)
  (vc-refresh-state))
(eab/bind-path transient-history-file)
(use-package git-wip)
