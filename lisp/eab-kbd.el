;;; eab-kbd.el --- 

;; Copyright (C) 2010-2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'eab-minimal)
(require 'eab-kbd-ext)

(eab/add-hook rec-mode-hook eab/rec-hook
  )

(eab/add-hook proced-mode-hook eab/proced-hook
  (define-key proced-mode-map (kbd "O") 'top))

(defadvice top-mode (after eab-javascript-mode-after activate)
  (define-key top-mode-map (kbd "O") (ilam (switch-to-buffer "*Proced*"))))

(eab/add-hook bibtex-mode-hook eab/bibtex-hook
  (define-key bibtex-mode-map (kbd "C-M-\\") 'bibtex-fill-entry))

(eab/add-hook ediff-after-setup-control-frame-hook eab/ediff-hook
  (define-key ediff-mode-map (kbd "d") 'nil))

(eab/add-hook markdown-mode-hook eab/markdown-hook
  (define-key markdown-mode-map (kbd "C-M-b") 'nil)
  (define-key markdown-mode-map (kbd "C-M-f") 'nil)
  (define-key markdown-mode-map (kbd "M-l") 'nil)
  (define-key markdown-mode-map (kbd "M-i") 'nil)
  (define-key markdown-mode-map (kbd "M-n") 'nil)
  (define-key markdown-mode-map (kbd "M-p") 'nil)
  (define-key markdown-mode-map (kbd "<tab>") 'nil))

(eab/add-hook ibuffer-mode-hook eab/ibuffer-hook
  (define-key ibuffer-mode-map (kbd "C-d") 'nil)
  (define-key ibuffer-mode-map (kbd "C-k") 'nil)
  (define-key ibuffer-mode-map (kbd "C-o") 'nil)
  (define-key ibuffer-mode-map (kbd "C-y") 'nil)
  (define-key ibuffer-mode-map (kbd "M-g") 'nil)
  (define-key ibuffer-mode-map (kbd "M-j") 'nil)
  (define-key ibuffer-mode-map (kbd "M-n") 'nil)
  (define-key ibuffer-mode-map (kbd "M-o") 'nil)
  (define-key ibuffer-mode-map (kbd "M-p") 'nil)
  (define-key ibuffer-mode-map (kbd "M-s") 'nil))

(eab/add-hook magit-mode-hook eab/magit-hook
  (define-key magit-log-mode-map (kbd "C-l M-n") 'log-edit-next-comment)
  (define-key magit-log-mode-map (kbd "C-l M-p") 'log-edit-previous-comment)
  (define-key magit-log-mode-map (kbd "M-n") 'nil)
  (define-key magit-log-mode-map (kbd "M-p") 'nil)
  (define-key magit-log-mode-map (kbd "C-d") 'nil)
  (define-key magit-revision-mode-map (kbd "C-d") 'nil)
  (define-key magit-status-mode-map (kbd "C-d") 'nil)
  (define-key magit-mode-map (kbd "W") (kbd "l a"))
  (define-key magit-mode-map (kbd "Q") (kbd "l = a E v g e n y SPC B o y k o v RET b"))
  ;;  (ilam (execute-kbd-macro (read-kbd-macro "l - a l l")))
  (define-key magit-mode-map (kbd "J") 'magit-commit-amend)
  (define-key magit-mode-map (kbd "M-n") 'nil)
  (define-key magit-mode-map (kbd "M-p") 'nil)
  (define-key magit-mode-map (kbd "M-s") 'nil)
  (define-key magit-mode-map (kbd "M-S") 'nil)
  (define-key magit-mode-map (kbd "M-h") 'nil)
  (define-key magit-mode-map (kbd "M-H") 'nil)
  (define-key magit-mode-map (kbd "M-1") 'nil)
  (define-key magit-mode-map (kbd "M-2") 'nil)
  (define-key magit-mode-map (kbd "M-g") 'magit-fetch-all)
;;  (define-key magit-mode-map (kbd "M-g") 'magit-remote-update)
  (define-key magit-mode-map (kbd "C-d") 'nil)
  (define-key magit-mode-map (kbd "C-D") 'magit-section-show-level-4-all)
;;  (define-key magit-mode-map (kbd "C-f") 'magit-show-only-files)
;;  (define-key magit-mode-map (kbd "C-F") 'magit-show-only-files-all)
  (define-key magit-mode-map (kbd "s-1") 'magit-section-show-level-1-all)  ;; temacs
  (define-key magit-mode-map (kbd "s-2") 'magit-section-show-level-2-all)  ;; temacs
  (define-key magit-mode-map (kbd "<backtab>") 'magit-section-show-level-2-all)
;;  (define-key magit-mode-map (kbd "RET") (ilam (magit-visit-item 't)))
  (define-key magit-mode-map (kbd "s-3") 'magit-section-show-level-3-all)  ;; temacs
  (define-key magit-mode-map (kbd "s-4") 'magit-section-show-level-4-all))  ;; temacs

(eab/add-hook nroff-mode-hook eab/nroff-hook
  (define-key nroff-mode-map (kbd "M-s") 'nil)
  (define-key nroff-mode-map (kbd "M-n") 'nil)
  (define-key nroff-mode-map (kbd "M-p") 'nil))

(eab/add-hook twittering-edit-mode-hook eab/twittering-edit-hook
  (define-key twittering-edit-mode-map (kbd "C-l M-p") 'twittering-edit-previous-history)
  (define-key twittering-edit-mode-map (kbd "C-l M-n") 'twittering-edit-next-history)
  (define-key twittering-edit-mode-map (kbd "M-p") 'nil)
  (define-key twittering-edit-mode-map (kbd "M-n") 'nil))

(eab/add-hook eshell-mode-hook eab/eshell-hook
  (define-key eshell-mode-map (kbd "M-s") 'nil)
  (define-key eshell-mode-map (kbd "M-s") 'nil))

(eab/add-hook shell-mode-hook eab/shell-hook
  (define-key shell-mode-map (kbd "M-p") 'nil)
  (define-key shell-mode-map (kbd "M-n") 'nil))

;; DONE это ведь то же самое, что просто вызов (eab/free-map git-commit-mode-map)

(eab/add-hook git-commit-mode-hook eab/git-commit-hook
  (eab/free-map git-commit-mode-map))

;; TODO плохая зависимость от eab/free-map, которая может еще не
;; существовать на момент вызова (log-edit-mode) в ergoemacs-mode
;; это даже при запуске (el-get 'sync eab/el-get-sources)
;; (eab/add-hook log-edit-mode-hook eab/log-edit-hook
;;   (eab/free-map log-edit-mode-map))

(eab/add-hook etags-select-mode-hook eab/etags-select-hook
	      )

;; (eab/add-hook erc-mode-hook eab/erc-hook
;;   (define-key erc-mode-map (kbd "C-l M-n") 'erc-next-command)
;;   (define-key erc-mode-map (kbd "C-l M-p") 'erc-previous-command)
;;   (define-key erc-mode-map (kbd "C-a") 'nil)
;;   (define-key erc-mode-map (kbd "M-n") 'nil)
;;   (define-key erc-mode-map (kbd "M-p") 'nil))


;; (define-key popup-isearch-keymap (kbd "C-k") (ilam (insert "л")))
;; 

(eab/add-hook auto-complete-mode-hook eab/ac-complete-mode-hook
  (define-key ac-completing-map "\C-s" 'ac-isearch)
  (define-key ac-complete-mode-map (kbd "M-c") 'ac-expand-common)
  (define-key ac-complete-mode-map (kbd "M-k") 'ac-next)
  (define-key ac-complete-mode-map (kbd "M-i") 'ac-previous))

(eab/add-hook bookmark-bmenu-mode-hook eab/bookmark-bmenu-mode-hook
  (define-key bookmark-bmenu-mode-map (kbd "M-s") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-l") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-m") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-a") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-d") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-u") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-I") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "C-d") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "C-o") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-~") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-a") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-c") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-L") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-m") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-o") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-q") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-r") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "M-t") 'nil)
  (define-key bookmark-bmenu-mode-map (kbd "SPC") 'bmkp-describe-bookmark)
  (define-key bookmark-bmenu-mode-map (kbd "M-X") 'nil))

(eab/add-hook moccur-mode eab/moccur-hook
  (define-key moccur-mode-map (kbd "M-n") 'nil)
  (define-key moccur-mode-map (kbd "M-p") 'nil)
  (define-key moccur-mode-map (kbd "M-m") 'nil)
  (define-key moccur-mode-map (kbd "M-d") 'nil))

(eab/add-hook org-mode-hook eab/org-hook
  (define-key org-mode-map (kbd "M-D") 'ace-link-org)
  (define-key org-mode-map (kbd "C-d") eab/compile-map)
  (define-key org-mode-map (kbd "<f6>") 'eab/revert-buffer)

  (key-chord-define org-mode-map "jj" 'org-edit-src-code)
  (define-key org-mode-map (kbd "s-'") 'org-edit-src-code)  ;; temacs
  (define-key org-mode-map (kbd "s-k") 'org-metadown)
  (define-key org-mode-map (kbd "s-i") 'org-metaup)
  (define-key org-mode-map (kbd "s-p") 'org-priority-up)
  (define-key org-mode-map (kbd "s-j") 'org-metaleft)
  (define-key org-mode-map (kbd "s-l") 'org-metaright)
  (define-key org-mode-map (kbd "s-K") 'org-shiftmetadown)
  (define-key org-mode-map (kbd "s-I") 'org-shiftmetaup)
  (define-key org-mode-map (kbd "s-J") 'org-shiftmetaleft)
  (define-key org-mode-map (kbd "s-L") 'org-shiftmetaright)
  (define-key org-mode-map (kbd "s-<return>") 'org-insert-heading)
  (define-key org-mode-map (kbd "s-S-<return>") 'org-insert-todo-heading)
  (define-key org-mode-map (kbd "M-s-k") 'org-shiftdown)
  (define-key org-mode-map (kbd "M-s-i") 'org-shiftup)
  (define-key org-mode-map (kbd "M-s-j") 'org-shiftleft)
  (define-key org-mode-map (kbd "M-s-l") 'org-shiftright)  ;; temacs
  (define-key org-mode-map (kbd "C-y") 'nil)
  (define-key org-mode-map (kbd "C-e") 'nil)
  (define-key org-mode-map (kbd "C-,") 'nil)  ;; temacs
  (define-key org-mode-map (kbd "C-SPC") 'nil)
  (define-key org-mode-map (kbd "M-a") 'nil)
  (define-key org-mode-map (kbd "M-e") 'nil)
  (define-key org-mode-map (kbd "C-a") 'nil)
  (define-key org-mode-map (kbd "C-k") 'nil)
  (define-key org-mode-map (kbd "M-h") 'org-beginning-of-line)
  (define-key org-mode-map (kbd "M-p") 'org-end-of-line)
  (define-key org-mode-map (kbd "M-g") 'org-kill-line)
  (define-key org-mode-map (kbd "M-v") 'org-yank)
  (define-key org-mode-map (kbd "M-RET") (ilam (org-insert-heading nil)))
  (define-key org-mode-map (kbd "M-N") 'org-backward-sentence)
  (define-key org-mode-map (kbd "M-M") 'org-forward-sentence)
  (define-key org-mode-map (kbd "C-M-u") 'outline-previous-visible-heading)
  (define-key org-mode-map (kbd "C-M-o") 'outline-next-visible-heading)
  (define-key org-mode-map (kbd "s-u") 'org-preview-latex-fragment)  ;; temacs
  (define-key org-mode-map (kbd "C-c C-x M-c") 'org-copy-special)
  (define-key org-mode-map (kbd "C-c C-x M-x") 'org-cut-special)
  (define-key org-mode-map (kbd "C-c C-x M-v") 'org-paste-special)
  (define-key org-mode-map (kbd "s-x M-c") 'org-copy-special)  ;; temacs
  (define-key org-mode-map (kbd "s-x M-x") 'org-cut-special)  ;; temacs
  (define-key org-mode-map (kbd "s-x M-v") 'org-paste-special)  ;; temacs
  (define-key org-mode-map (kbd "s-.") (kbd "C-c . RET"))

  (key-chord-define org-src-mode-map "jj" 'org-edit-src-exit)
  (define-key org-src-mode-map (kbd "s-'") 'org-edit-src-exit)  ;; temacs
  (define-key org-src-mode-map (kbd "C-l '") 'org-edit-src-exit)
  ;; (define-key org-agenda-mode-map (kbd "s-.") (ilam (org-agenda-todo 3)))  ;; temacs
  (define-key org-agenda-mode-map (kbd "M-j") 'nil)
  (define-key org-agenda-mode-map (kbd "M-l") 'nil)
  (define-key org-agenda-mode-map (kbd "C-p") 'nil)
  (define-key org-agenda-mode-map (kbd "C-n") 'nil)
  (define-key org-agenda-mode-map (kbd "C-k") 'nil)
  (define-key org-agenda-mode-map (kbd "s") 'flx-isearch-forward)
  (define-key org-agenda-mode-map (kbd "M-g") 'org-agenda-kill)
  (define-key org-agenda-mode-map (kbd "M-k") 'org-agenda-next-line)
  (define-key org-agenda-mode-map (kbd "M-i") 'org-agenda-previous-line))

(eab/add-hook comint-mode-hook eab/coming-hook
  (define-key comint-mode-map (kbd "M-p") 'comint-previous-matching-input-from-input)
  (define-key comint-mode-map (kbd "M-n") 'comint-next-matching-input-from-input)
  (define-key comint-mode-map (kbd "C-M-n") 'comint-next-input)
  (define-key comint-mode-map (kbd "C-M-p") 'comint-previous-input))

(eab/add-hook diff-mode-hook eab/diff-hook
  (define-key diff-mode-map (kbd "M-SPC") 'nil)
  (define-key diff-mode-map (kbd "M-1") 'nil)
  (define-key diff-mode-map (kbd "M-2") 'nil)
  (define-key diff-mode-map (kbd "M-5") 'nil)
  (define-key diff-mode-map (kbd "M-k") 'nil)
  (define-key diff-mode-map (kbd "M-<") 'nil)
  (define-key diff-mode-map (kbd "M->") 'nil)
  (define-key diff-mode-map (kbd "M-K") 'nil)
  (define-key diff-mode-map (kbd "M-h") 'nil)
  (define-key diff-mode-map (kbd "M-n") 'nil)
  (define-key diff-mode-map (kbd "M-N") 'nil)
  (define-key diff-mode-map (kbd "M-o") 'nil)
  (define-key diff-mode-map (kbd "M-p") 'nil))

(eab/add-hook fortran-mode-hook eab/fortran-hook
  (define-key fortran-mode-map (kbd "C-d") eab/compile-map))

(eab/add-hook f90-mode-hook eab/f90-hook
  (define-key f90-mode-map (kbd "C-j") 'nil)
  (define-key f90-mode-map (kbd "C-d") eab/compile-map))

(eab/add-hook twittering-mode-hook eab/twittering-hook
  (define-key twittering-mode-map (kbd "u") 'eab/twittering-update-status-interactive)
  (define-key twittering-mode-map (kbd "d") 'ace-link-info)
  (define-key twittering-mode-map (kbd "M-v") 'nil)
  (define-key twittering-mode-map (kbd "C-v") 'nil)
  (define-key twittering-mode-map (kbd "@") 'eab/twit-filter)
  (define-key twittering-mode-map (kbd "f") 'twittering-follow)
  (define-key twittering-mode-map (kbd "r") 'twittering-retweet)
  (define-key twittering-mode-map (kbd "R") 'twittering-toggle-or-retrieve-replied-statuses)
  (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
  (define-key twittering-mode-map (kbd "s-f") 'twittering-friends-timeline)  ;; temacs
  (define-key twittering-mode-map (kbd "s-r") 'twittering-replies-timeline)
  (define-key twittering-mode-map (kbd "s-u") 'twittering-user-timeline)
  (define-key twittering-mode-map (kbd "s-d") 'twittering-direct-messages-timeline)
  (define-key twittering-mode-map (kbd "s-s") 'twittering-update-status-interactive)
  (define-key twittering-mode-map (kbd "s-e") 'twittering-erase-old-statuses)
  (define-key twittering-mode-map (kbd "s-m") 'twittering-retweet)
  (define-key twittering-mode-map (kbd "s-t") 'twittering-set-current-hashtag)
  (define-key twittering-mode-map (kbd "C-m") 'twittering-enter)
  (define-key twittering-mode-map (kbd "s-l") 'twittering-update-lambda))  ;; temacs

(eab/add-hook slime-repl-mode-hook eab/slime-repl-hook
  (define-key slime-repl-mode-map (kbd "M-n") 'nil)
  (define-key slime-repl-mode-map (kbd "M-p") 'nil)
  (define-key slime-repl-mode-map (kbd "M-r") 'nil)
  (define-key slime-repl-mode-map (kbd "M-s") 'nil)
  (define-key slime-repl-mode-map (kbd "C-a") 'nil)
  (define-key slime-repl-mode-map (kbd "C-A") 'nil)
  (define-key slime-repl-mode-map (kbd "C-l M-p") 'slime-repl-previous-input)
  (define-key slime-repl-mode-map (kbd "C-l M-n") 'slime-repl-next-input))

(eab/add-hook maxima-mode-hook eab/maxima-hook
  (define-key maxima-mode-map (kbd "C-M-a") 'nil)
  (define-key maxima-mode-map (kbd "C-M-b") 'nil)
  (define-key maxima-mode-map (kbd "C-M-e") 'nil)
  (define-key maxima-mode-map (kbd "C-M-f") 'nil)
  (define-key maxima-mode-map (kbd "M-;") 'nil)
  (define-key maxima-mode-map (kbd "C-d") eab/compile-map)
  (define-key maxima-mode-map (kbd "M-h") 'nil))

(eab/add-hook slime-mode-hook eab/slime-hook
  (define-key slime-mode-map (kbd "M-p") 'nil)
  (define-key slime-mode-map (kbd "M-n") 'nil))

(eab/add-hook message-mode-hook eab/message-hook
  (define-key message-mode-map (kbd "C-c C-c") 'eab/message-send)
  (define-key message-mode-map (kbd "M-;") 'nil)
  (define-key message-mode-map (kbd "M-n") 'nil))

(eab/add-hook makefile-gmake-mode-hook eab/makefile-gmake-mode
  (define-key makefile-gmake-mode-map (kbd "\C-d") eab/compile-map)
  (define-key makefile-gmake-mode-map (kbd "M-n") 'nil)
  (define-key makefile-gmake-mode-map (kbd "M-p") 'nil))

(eab/add-hook nxml-mode-hook eab/nxml-mode
  (define-key nxml-mode-map (kbd "M-h") 'nil))

(eab/add-hook term-mode-hook eab/term-hook
  (define-key term-mode-map (kbd "M-q") 'nil)
  (define-key term-mode-map (kbd "M-s") 'nil)
  (define-key term-mode-map (kbd "M-n") 'nil)
  (define-key term-mode-map (kbd "M-p") 'nil)
  (define-key term-mode-map (kbd "<tab>") 'eab/wrap-tab)
  (define-key term-mode-map (kbd "C-p") 'term-previous-input)
  (define-key term-mode-map (kbd "C-n") 'term-next-input)
  (key-chord-define term-mode-map "jj" 'term-char-mode)
  
  (key-chord-define term-raw-map "jj" 'term-line-mode)
  (define-key term-raw-map (kbd "M-a") 'nil)
  (define-key term-raw-map (kbd "M-A") 'nil)
  (define-key term-raw-map (kbd "M-q") 'nil)
  (define-key term-raw-map (kbd "M-Q") 'nil)
  (define-key term-raw-map (kbd "M-v") 'nil)
  (define-key term-raw-map (kbd "M-g") 'nil)
  (define-key term-raw-map (kbd "M-V") 'nil)
  (define-key term-raw-map (kbd "M-z") 'nil)
  (define-key term-raw-map (kbd "M-s") 'nil)
  (define-key term-raw-map (kbd "C-b") 'nil)
  (define-key term-raw-map (kbd "C-a") 'nil)
  (define-key term-raw-map (kbd "C-e") 'nil)
  (define-key term-raw-map (kbd "C-o") 'nil)
  (define-key term-raw-map (kbd "C-h") 'nil)
  ;; (define-key term-raw-map (kbd "C-c s") 'nil)
  (define-key term-raw-map (kbd "M-1") 'nil)
  (define-key term-raw-map (kbd "C-r") 'term-send-raw)
  (define-key term-raw-map (kbd "M-r") 'eab/append-this-line)
  (define-key term-raw-map (kbd "C-l") eab/temacs-map)
  (define-key term-raw-map (kbd "M-h") 'term-send-home)
  (define-key term-raw-map (kbd "M-p") 'term-send-end)
  (define-key term-raw-map (kbd "M-j") 'term-send-left)
  (define-key term-raw-map (kbd "M-l") 'term-send-right)
  (define-key term-raw-map (kbd "M-k") 'term-send-up) 
  (define-key term-raw-map (kbd "M-i") 'term-send-down)
  (define-key term-raw-map (kbd "C-p") 'term-send-up)
  (define-key term-raw-map (kbd "C-n") 'term-send-down))

(eab/add-hook comint-mode-hook eab/comint-hook
  (define-key comint-mode-map (kbd "M-s") 'nil)
  (define-key comint-mode-map (kbd "M-p") 'nil)
  (define-key comint-mode-map (kbd "M-n") 'nil)
  (define-key comint-mode-map (kbd "M-r") 'nil)
  (define-key comint-mode-map (kbd "C-p") 'comint-previous-input)
  (define-key comint-mode-map (kbd "C-n") 'comint-next-input))

(eab/add-hook compilation-mode-hook eab/compilation-hook
  (define-key compilation-button-map (kbd "M-RET") 'eab/compile-goto-error-same-window)
  (define-key compilation-button-map (kbd "RET") 'eab/compile-goto-error)
  (define-key compilation-mode-map (kbd "g") 'eab/recompile)
  (define-key compilation-mode-map (kbd "\C-d") eab/compile-map)
  (define-key compilation-mode-map (kbd "\C-o") 'nil)
  (define-key compilation-mode-map (kbd "M-k") 'nil)
  (define-key compilation-mode-map (kbd "M-p") 'nil)
  (define-key compilation-mode-map (kbd "M-i") 'nil)
  (define-key compilation-mode-map (kbd "M-n") 'nil))

(eab/add-hook grep-mode-hook eab/grep-hook
  (define-key grep-mode-map (kbd "B") 'eab/switch-grep-prev)
  (define-key grep-mode-map (kbd "F") 'eab/switch-grep-next)
  (define-key grep-mode-map (kbd "C-o") 'nil)
  (define-key grep-mode-map (kbd "M-p") 'nil)
  (define-key grep-mode-map (kbd "M-RET") 'eab/compile-goto-error-same-window)
  (define-key grep-mode-map (kbd "C-M-j") 'eab/compile-goto-error-same-window)
  (define-key grep-mode-map (kbd "RET") 'eab/compile-goto-error)
  (define-key grep-mode-map (kbd "g") 'eab/recompile)
  (define-key grep-mode-map (kbd "u") 'eab/grep-utf)
  (define-key grep-mode-map (kbd "M-n") 'nil)
  (define-key grep-mode-map (kbd "C-w") 'eab/wgrep-change-to-wgrep-mode))

(eab/add-hook ag-mode-hook eab/ag-hook
  (define-key ag-mode-map (kbd "C-w") 'eab/wgrep-change-to-wgrep-mode))

(eab/add-hook gnus-started-hook eab/gnus-article-hook
  (define-key gnus-article-mode-map (kbd "M-g") 'nil)
  (define-key gnus-article-mode-map (kbd "M-u") 'nil)
  (define-key gnus-article-mode-map (kbd "M-*") 'nil)
  (define-key gnus-article-mode-map (kbd "M-n") 'nil)
  (define-key gnus-article-mode-map (kbd "C-c C-v") 'gnus-article-browse-html-article))

(eab/add-hook gnus-started-hook eab/gnus-summary-hook 
  (define-key gnus-summary-mode-map (kbd "g") 'eab/gnus-inbox)
  (define-key gnus-summary-mode-map (kbd "RET") 'gnus-summary-show-article)
  (define-key gnus-summary-mode-map (kbd "A o") 'gnus-summary-insert-old-articles)
  (define-key gnus-summary-mode-map (kbd "M-I") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-i") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-k") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-K") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-s") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-p") 'nil)
  (define-key gnus-summary-mode-map (kbd "M-n") 'nil)
  (define-key gnus-summary-mode-map (kbd "\C-c\C-w") 'gnus-summary-move-article)
  (define-key gnus-summary-mode-map (kbd "m") 'gnus-summary-mark-as-processable)
  (define-key gnus-summary-mode-map (kbd "u") 'gnus-summary-unmark-as-processable))

(eab/add-hook gnus-started-hook eab/gnus-group-hook
  (define-key gnus-group-mode-map (kbd "RET") 'eab/gnus-group-select)
  (define-key gnus-group-mode-map (kbd "M-d") 'nil)
  (define-key gnus-group-mode-map (kbd "M-k") 'nil)
  (define-key gnus-group-mode-map (kbd "M-n") 'nil))

(eab/add-hook dired-mode-hook eab/dired-hook 
  (define-key dired-mode-map (kbd "C-M-b") 'nil)
  (define-key dired-mode-map (kbd "M-i") 'nil)
  (define-key dired-mode-map (kbd "M-j") 'nil)
  (define-key dired-mode-map (kbd "C-n") 'nil)
  (define-key dired-mode-map (kbd "M-c") 'nil)
  (define-key dired-mode-map (kbd "M-g") 'nil)
  (define-key dired-mode-map (kbd "M-G") 'nil)
  (define-key dired-mode-map (kbd "M-v") 'nil)
  (define-key dired-mode-map (kbd "M-!") 'nil)
  (define-key dired-mode-map (kbd "M-l") 'nil)
  (define-key dired-mode-map (kbd "M-p") 'nil)
  (define-key dired-mode-map (kbd "M-o") 'nil)
  (define-key dired-mode-map (kbd "M-s") 'nil)
  (define-key dired-mode-map (kbd "M-u") 'nil)
  (define-key dired-mode-map (kbd "M-m") 'nil)
  (define-key dired-mode-map (kbd "C-o") 'nil)
  (define-key dired-mode-map (kbd "C-p") 'nil)
  (define-key dired-mode-map (kbd "C-k") 'nil)
  (define-key dired-mode-map (kbd "C-S-a") 'nil)
  (define-key dired-mode-map (kbd "C-c C-w") 'dired-do-rename)
  (define-key dired-mode-map (kbd "C-w") 'wdired-change-to-wdired-mode)
  (define-key dired-mode-map (kbd "b") 'browse-url-of-dired-file)
  (define-key dired-mode-map (kbd "o") 'eab/dired-find-file-other-window)
  (define-key dired-mode-map (kbd "C-|") 'eab/dired-see-file) ;; temacs
  (define-key dired-mode-map (kbd "s-SPC") 'eab/dired-see-file)  ;; temacs
  (define-key dired-mode-map (kbd "E") 'ediff-files)  ;; temacs
  (define-key dired-mode-map (kbd "SPC") 'open-in-external-app))

(eab/add-hook wdired-mode-hook eab/wdired-hook
  (define-key wdired-mode-map (kbd "s-w") 'wdired-finish-edit))  ;; temacs

(eab/add-hook java-mode-hook eab/java-hook
  (define-key java-mode-map (kbd "M-M") 'c-end-of-defun)
  (define-key java-mode-map (kbd "M-N") 'c-beginning-of-defun)
  (define-key java-mode-map (kbd "M-j") 'nil)
  (define-key java-mode-map (kbd "M-e") 'nil))

(eab/add-hook c-mode-hook eab/c-hook
  (define-key c-mode-map (kbd "C-d") eab/compile-map)
  (define-key c-mode-map (kbd "C-M-a") 'nil)
  (define-key c-mode-map (kbd "C-M-e") 'nil)
  (define-key c-mode-map (kbd "M-a") 'nil)
  (define-key c-mode-map (kbd "M-M") 'nil)
  (define-key c-mode-map (kbd "M-N") 'nil)
  (define-key c-mode-map (kbd "M-j") 'nil)
  (define-key c-mode-map (kbd "M-q") 'nil)
  (define-key c-mode-map (kbd "M-M") 'c-end-of-defun)
  (define-key c-mode-map (kbd "M-N") 'c-beginning-of-defun)
  (define-key c-mode-map (kbd "M-e") 'nil))

(eab/add-hook c++-mode-hook eab/c++-hook
  (define-key c++-mode-map (kbd "C-d") eab/compile-map)
  (define-key c++-mode-map (kbd "C-M-a") 'nil)
  (define-key c++-mode-map (kbd "C-M-e") 'nil)
  (define-key c++-mode-map (kbd "M-a") 'nil)
  (define-key c++-mode-map (kbd "M-M") 'nil)
  (define-key c++-mode-map (kbd "M-N") 'nil)
  (define-key c++-mode-map (kbd "M-j") 'nil)
  (define-key c++-mode-map (kbd "M-q") 'nil)
  (define-key c++-mode-map (kbd "M-M") 'c-end-of-defun)
  (define-key c++-mode-map (kbd "M-N") 'c-beginning-of-defun)
  (define-key c++-mode-map (kbd "M-e") 'nil))

(eab/add-hook w3m-mode-hook eab/w3m-hook 
  (define-key w3m-mode-map (kbd "M-d") 'nil)
  (define-key w3m-mode-map (kbd "M-k") 'nil)
  (define-key w3m-mode-map (kbd "M-l") 'nil)
  (define-key w3m-mode-map (kbd "M-i") 'nil)
  (define-key w3m-mode-map (kbd "M-a") 'nil)
  (define-key w3m-mode-map (kbd "M-s") 'nil)
  (define-key w3m-mode-map (kbd "M-g") 'nil))

(eab/add-hook helm-before-initialize-hook eab/helm-hook
  (define-key helm-map (kbd "C-k") 'toggle-input-method)
  (define-key helm-map (kbd "M-H") 'helm-select-2nd-action-or-end-of-line)
  (define-key helm-map (kbd "M-g") 'helm-delete-minibuffer-contents)
  (define-key helm-map (kbd "s-SPC") 'eab/helm-select-action)
  (define-key helm-map (kbd "C-|") 'eab/helm-select-action)
  ;; (define-key helm-map (kbd "@") 'helm-select-with-prefix-shortcut)      
  ;; (define-key helm-map (kbd "M-d") 'helm-select-with-prefix-shortcut)
  (define-key helm-map (kbd "M-j") 'nil)
  (define-key helm-map (kbd "M-v") 'nil)
  (define-key helm-map (kbd "M-l") 'nil)
  (define-key helm-map (kbd "M-k") 'helm-next-line)
  (define-key helm-map (kbd "M-i") 'helm-previous-line)
  (define-key helm-generic-files-map (kbd "M-i") 'helm-previous-line)
  (define-key helm-map (kbd "C-n") 'next-history-element)
  (define-key helm-map (kbd "C-p") 'previous-history-element)
  ;; (define-key helm-map (kbd "M-;") 'helm-isearch)
  (define-key helm-map (kbd "C-SPC") 'helm-toggle-visible-mark)
  (define-key helm-map (kbd "M-K") 'helm-next-page)
  (define-key helm-map (kbd "M-J") 'helm-beginning-of-buffer)
  (define-key helm-map (kbd "M-L") 'helm-end-of-buffer)
  (define-key helm-map (kbd "M-I") 'helm-previous-page))

(eab/add-hook ido-minibuffer-setup-hook eab/ido-minibuffer-hook
  (define-key ido-file-dir-completion-map (kbd "M-v") 'yank)
  (define-key ido-file-completion-map (kbd "C-d") 'eab/ace-ibuffer)
  (define-key ido-file-completion-map (kbd "C-|") 'eab/ido-see-file)  ;; temacs
  (define-key ido-file-completion-map (kbd "s-SPC") 'eab/ido-see-file)  ;; temacs
  (define-key ido-buffer-completion-map (kbd "C-k") 'nil)
  (define-key ido-common-completion-map (kbd "C-v") 'eab/toggle-cxb-ido-item)
  (define-key ido-buffer-completion-map (kbd "C-d") 'eab/ace-ibuffer)
  (define-key ido-common-completion-map (kbd "C-d") 'eab/ace-ibuffer)
  (define-key ido-buffer-completion-map (kbd "C-d") 'ido-buffer-helm)
  (define-key ido-buffer-completion-map (kbd "M-RET") 'eab/ido-main)
  ;; DONE слетают хоткеи. М. б. где-то в другом месте переделывается map?
  (define-key ido-buffer-completion-map (kbd "C-M-j") 'eab/ido-main)
  (define-key ido-buffer-completion-map (kbd "C-b") 'eab/ido-wmctrl)
  (define-key ido-common-completion-map (kbd "C-b") 'eab/ido-wmctrl))

(eab/add-hook emacs-lisp-mode-hook eab/emacs-lisp-hook
  (define-key emacs-lisp-mode-map (kbd "s-r") 'paredit-raise-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-L") 'paredit-forward-barf-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-J") 'paredit-backward-barf-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-l") 'paredit-forward-slurp-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-j") 'paredit-backward-slurp-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-I") 'paredit-splice-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-K") 'paredit-splice-sexp)
  (define-key emacs-lisp-mode-map (kbd "s-i") 'paredit-splice-sexp-killing-backward)
  (define-key emacs-lisp-mode-map (kbd "s-k") 'paredit-splice-sexp-killing-forward)
  (define-key emacs-lisp-mode-map (kbd "M-(") 'paredit-wrap-round)
  (define-key emacs-lisp-mode-map (kbd "M-r") 'paredit-forward-kill-word)
  (define-key emacs-lisp-mode-map (kbd "M-e") 'paredit-backward-kill-word)
  (define-key emacs-lisp-mode-map (kbd "M-g") 'paredit-kill)
  (define-key emacs-lisp-mode-map (kbd "M-'") 'paredit-comment-dwim)
  (define-key emacs-lisp-mode-map (kbd "RET") 'paredit-newline))

(eab/add-hook smartparens-enabled-hook eab/smartparens-hook
  (progn
    (define-key sp-keymap (kbd "/") 'nil)
    (define-key sp-keymap (kbd "b") 'sp--self-insert-command) ;; for latex sp-local-tag
    (define-key sp-keymap (kbd "B") 'nil)
    (define-key sp-keymap (kbd "f") 'nil)
    (define-key sp-keymap (kbd "g") 'nil)
    (define-key sp-keymap (kbd "h") 'nil)
    (define-key sp-keymap (kbd "l") 'nil)
    (define-key sp-keymap (kbd "t") 'nil)
    (define-key sp-keymap (kbd "i") 'nil)
    (define-key sp-keymap (kbd "e") 'nil)
    (define-key sp-keymap (kbd "r") 'nil)
    (define-key sp-keymap (kbd "к") 'nil)))

;; TODO в multiple-cursors-mode этот hook только запускается, но не определяется
;; возможны проблемы в будущем
(eab/add-hook multiple-cursors-mode-enabled-hook eab/multiple-cursors-hook
  (progn
    ;; DONE mc/cycle-*
    (define-key mc/keymap (kbd "M-K") 'mc/cycle-forward)
    (define-key mc/keymap (kbd "M-I") 'mc/cycle-backward)
    (define-key mc/keymap (kbd "M-v") 'nil)
    (define-key mc/keymap (kbd "C-v") 'nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'flyspell-mode-hook
	  (lambda () (define-key flyspell-mode-map (kbd "C-k") 'toggle-input-method)))

(add-hook 'LaTeX-mode-hook  
	  (lambda ()
	    ;; DONE в temacs проблемы с производительностью у команды sp-forward-sexp в latex-mode
	    (define-key LaTeX-mode-map (kbd "M-m") 'forward-sexp)
	    (define-key LaTeX-mode-map (kbd "C-d") 'TeX-command-master)
	    ;; (define-key LaTeX-mode-map (kbd "C-d") (ilam (TeX-command "LaTeX" 'TeX-master-file)))
	    (define-key LaTeX-mode-map (kbd "C-S-d") eab/compile-map)))

(add-hook 'graphviz-dot-mode-hook
	  (lambda () (define-key graphviz-dot-mode-map (kbd "C-d") eab/compile-map)
	    (set (make-local-variable 'compile-command) nil)))


(add-hook 'text-mode-hook
	  (lambda () (define-key text-mode-map (kbd "C-c C-c") 'server-edit)))

(add-hook 'ruby-mode-hook
	  (lambda () (progn
		       (define-key ruby-mode-map (kbd "C-d") eab/compile-map)
		       (define-key ruby-mode-map (kbd "C-M-b") 'nil)
		       )))

(add-hook 'python-mode-hook
	  (lambda () (progn
		       (define-key python-mode-map (kbd "C-d") eab/compile-map)
		       (define-key python-mode-map (kbd "C-j") 'nil)
		       (define-key python-mode-map (kbd "M-RET") 'newline)
		       (define-key python-mode-map (kbd "RET") 'newline)
		       (define-key python-mode-map (kbd "C-h C-f") 'jedi:goto-definition)
		       )))

(add-hook 'py-shell-hook
	  (lambda () (progn
		       ;; (define-key py-shell-map (kbd "<tab>") ')
		       ;; (define-key py-shell-map (kbd "TAB") ')
		       )) 't) ;; to the end!!

(add-hook 'maplev-mode-hook
	  (lambda () 
            ;; (define-key smart-operator-mode-map ":" 'self-insert-command)
            ;; (define-key smart-operator-mode-map "." 'self-insert-command)
            ;; (define-key smart-operator-mode-map "," 'self-insert-command)

	    (define-key maplev-mode-map (kbd "C-c d") 'maplev-help-at-point)
	    (define-key maplev-mode-map (kbd "C-k") 'toggle-input-method)))

(add-hook 'help-mode-hook
	  (lambda ()
	    (require 'view)
	    (define-key help-mode-map "o" 'ace-link-help)
	    (define-key help-mode-map "B" 'help-go-back)
	    (define-key help-mode-map "F" 'help-go-forward)
	    (define-key view-mode-map "F" 'nil)))

;; DONE does it really work? Only back
(add-hook 'dictionary-mode-hook
	  (lambda ()
	    (define-key dictionary-mode-map "B" 'eab/help-mode-back)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	       	       _       	       	 _
;;	 _ __  	___   |	|__   ___   ___	| | __
;;	| '_ \ / _ \  |	'_ \ / _ \ / _ \| |/ /
;;	| | | |	(_) | |	| | | (_) | (_)	|   <
;;	|_| |_|\___/  |_| |_|\___/ \___/|_|\_\
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; no hook

(defadvice region-bindings-mode-on (before eab-region-bindings-mode-on activate)
    (progn
      (setq region-bindings-mode-disabled-modes '(magit-status-mode magit-diff-mode))
      (define-key region-bindings-mode-map "u" 'untabify)
      (define-key region-bindings-mode-map "г" 'untabify)
      (define-key region-bindings-mode-map "0" (ilam (eab/or-self-insert-body (er/expand-region 0))))
      (define-key region-bindings-mode-map "p" (ilam (eab/or-self-insert-body (er/expand-region 1))))
      (define-key region-bindings-mode-map "-" (ilam (eab/or-self-insert-body (er/expand-region -1))))
      (define-key region-bindings-mode-map "P" (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-paragraph)))))
      (define-key region-bindings-mode-map "З" (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-paragraph)))))
      (define-key region-bindings-mode-map "I" (ilam (eab/or-self-insert 'indent-region)))
      (define-key region-bindings-mode-map "Ш" (ilam (eab/or-self-insert 'indent-region)))
      (define-key region-bindings-mode-map "d" (ilam (eab/or-self-insert-body (progn (er/expand-region 0) (mark-defun)))))
      (define-key region-bindings-mode-map "/" (ilam (let ((this-command 'ergoemacs-toggle-letter-case)) (eab/or-self-insert 'ergoemacs-toggle-letter-case))))
      (define-key region-bindings-mode-map "r" (ilam (eab/or-self-insert 'string-rectangle)))
      (define-key region-bindings-mode-map "к" (ilam (eab/or-self-insert 'string-rectangle)))
      (define-key region-bindings-mode-map "t" (ilam (eab/or-self-insert 'anchored-transpose)))
      ;; TODO C-g неправильно работает с region-bindings-mode
      (define-key region-bindings-mode-map "g" (ilam (eab/or-self-insert 'mc/keyboard-quit)))
      (define-key region-bindings-mode-map "п" (ilam (eab/or-self-insert 'mc/keyboard-quit)))
      ;; (define-key region-bindings-mode-map (kbd "C-g") (ilam (eab/or-self-insert 'mc/keyboard-quit)))
      (define-key region-bindings-mode-map "G" (ilam (eab/or-self-insert 'google)))
      (define-key region-bindings-mode-map "П" (ilam (eab/or-self-insert 'google)))
      (define-key region-bindings-mode-map "l" (ilam (eab/or-self-insert 'eab/replace-selection)))
      (define-key region-bindings-mode-map "д" (ilam (eab/or-self-insert 'eab/replace-selection)))
      (define-key region-bindings-mode-map "s" (ilam (eab/or-self-insert 'gnugol-search-selection)))
      (define-key region-bindings-mode-map "ы" (ilam (eab/or-self-insert 'gnugol-search-selection)))
      (define-key region-bindings-mode-map "e" 'mc/edit-lines) ;; (lambda () (interactive) (eab/or-self-insert 'mc/edit-lines)))
      (define-key region-bindings-mode-map "x" (ilam (eab/or-self-insert 'kill-rectangle)))
      (define-key region-bindings-mode-map "ч" (ilam (eab/or-self-insert 'kill-rectangle))) ;; TODO возможные проблемы с раскладками
      (define-key region-bindings-mode-map "A" (ilam
						  (eab/or-self-insert-body
						      (save-restriction
							(narrow-to-region (window-start) (window-end))
							(ignore-errors (mc/mark-all-like-this))))))

      (define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
      (define-key region-bindings-mode-map "i" 'mc/mark-previous-like-this)
      (define-key region-bindings-mode-map "ш" 'mc/mark-previous-like-this)
      (define-key region-bindings-mode-map "k" 'mc/mark-next-like-this)
      (define-key region-bindings-mode-map "л" 'mc/mark-next-like-this)
      (define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)))


(defadvice artist-mode (before eab-artist-mode activate)
  (define-key artist-mode-map (kbd "C-b") 'nil))

(provide 'eab-kbd)
