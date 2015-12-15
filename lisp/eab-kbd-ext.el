;;; eab-kbd-ext.el --- 

;; Copyright (C) 2010-2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements:
;; Status: not intended to be distributed yet

(defun eab/wrap-tab ()
  (interactive)
  (term-char-mode)
  (execute-kbd-macro (kbd "<tab>"))
  (term-line-mode))

;; TODO сделать backup перед обнулением eab/free-map
;; (define-key git-commit-mode-map (kbd "M-n") 'git-commit-next-message)
;; (define-key git-commit-mode-map (kbd "M-p") 'git-commit-next-message)

(defun eab/ergo-fill-nil (mode-map keys)
  (mapcar (lambda (x) (eab/ergo-set-nil mode-map x)) keys))

(defun eab/ergo-set-nil (mode-map keystr)
  (eval `(define-key mode-map (kbd ,keystr) nil)))

(defun eab/proc-keys (action maps)
  (mapcar (lambda (m) (list m (funcall action (symbol-value m)))) maps))

(defun eab/get-union-keys (mode-map)
  (mapcar 'car (cadar (eab/proc-keys 'eab/check-map '(mode-map)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; TODO                                                                                 ;;
;; ;; сделать hook на основе eab/get-union-keys для каждой map из списка                   ;;
;; ;; т.о. после загрузки map происходит проверка и переназначение пересекающихся биндов   ;;
;; ;; следующим hook'ом должны добавляться специфичные для данной map бинды,               ;;
;; ;; чтобы не происходила потеря специфичных из-за последующего переназначения            ;;
;; ;; (это если hook'и выполнятся в другом порядке)                                        ;;
;; ;; можно сделать и в одном hook, просто добавить бинды ниже обнуления                   ;;
;; ;; NOTE Для term-raw-map это не подходит                                                ;;
;;                                                                                         ;;
;; ;; (eab/get-union-keys magit-mode-map)                                                  ;;
;; ;; (eab/ergo-fill-nil gnus-article-mode-map (eab/get-union-keys gnus-article-mode-map)) ;;
;; ;; (eab/get-union-keys gnus-article-mode-map)                                           ;;
;; ;; (eab/ergo-fill-nil eab/temacs-map )                                                  ;;
;; ;; (eab/ergo-fill-nil eab/temacs-map '("C-a"))                                          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; remove "too long" keys (e.g. "C-x o"), because they don't matter
(setq eab/ergo-keys '("C-a" "C-A" "C-b" "C-<backspace>" "C-d" "C-e" "C-f" "C-k" "C-M-;" "C-M-:" "C-M-a" "C-M-b" "C-M-e" "C-M-f" "C-M-k" "C-n" "C-<next>" "C-o" "C-p" "C-<pause>" "C-<prior>" "C-r" "C-s" "C-S-a" "C-S-n" "C-S-<next>" "C-SPC" "C-S-<prior>" "C-S-s" "C-S-SPC" "C-S-w" "C-v" "C-w" "C-y" "<delete>" "M-`" "M-~" "M-<" "M->" "M-;" "M-:" "M-!" "M-/" "M-'" "M-@" "M-*" "M-%" "M-1" "M-2" "M-5" "M-8" "M-a" "M-A" "M-b" "M-B" "M-c" "M-C" "M-d" "M-e" "M-f" "M-g" "M-G" "M-h" "M-H" "M-i" "M-I" "M-j" "M-J" "M-k" "M-K" "M-l" "M-L" "M-m" "M-M" "M-n" "M-N" "M-o" "M-O" "M-p" "M-q" "M-r" "M-s" "M-S" "M-S-<next>" "M-SPC" "M-S-<prior>" "M-S-SPC" "M-t" "M-u" "M-U" "M-v" "M-V" "M-w" "M-x" "M-X" "M-y" "M-z" "M-Z" "<tab>"))

(setq eab/all-keys '("C-a" "M-a" "C-b" "M-b" "C-c" "M-c" "C-d" "M-d" "C-e" "M-e" "C-f" "M-f" "C-g" "M-g" "C-h" "M-h" "C-i" "M-i" "C-j" "M-j" "C-k" "M-k" "C-l" "M-l" "C-m" "M-m" "C-n" "M-n" "C-o" "M-o" "C-p" "M-p" "C-q" "M-q" "C-r" "M-r" "C-s" "M-s" "C-t" "M-t" "C-u" "M-u" "C-v" "M-v" "C-w" "M-w" "C-x" "M-x" "C-y" "M-y" "C-z" "M-z" "C-A" "M-A" "C-B" "M-B" "C-C" "M-C" "C-D" "M-D" "C-E" "M-E" "C-F" "M-F" "C-G" "M-G" "C-H" "M-H" "C-I" "M-I" "C-J" "M-J" "C-K" "M-K" "C-L" "M-L" "C-M" "M-M" "C-N" "M-N" "C-O" "M-O" "C-P" "M-P" "C-Q" "M-Q" "C-R" "M-R" "C-S" "M-S" "C-T" "M-T" "C-U" "M-U" "C-V" "M-V" "C-W" "M-W" "C-X" "M-X" "C-Y" "M-Y" "C-Z" "M-Z"))

(setq eab/free-ctrl-alt-keys '("C-M-y" "C-M-j" "C-M-k" "C-M-f" "C-M-d" "C-M-a"))

(setq eab/free-ctrl-keys '("C-d" "C-r" "C-e" "C-j" "C-v" "C-q" "C-t"))

(setq eab/free-alt-keys '("M-t" "M-y" "M-W" "M-E" "M-R" "M-Y" "M-P" "M-]" "M-D" "M-\""))

(setq eab/terminal-skip '("C-i" "C-m" "C-<tab>" "C-." "C-," "C-'" "C-\"" "C-:" "C-;" "C-=" "C-)" "C-(" "C-|" "C-/" "C-?" "C--" "C-+" "C-&" "C-*" "C-%" "C-$" "C-#" "C-!"))

;; (setq eab/all-keys '())

;; (mapcar (lambda (key) (lookup-key global-map (eval `(kbd ,key)))) eab/all-keys)
;; (lookup-key global-map (kbd "C-l"))

;; Add here map
;; На самом деле, в eab-kbd.el полный список, но косвенный.
(setq eab/ergo-maps '(
		      LaTeX-mode-map
		      ac-complete-mode-map
		      c-mode-map
		      comint-mode-map
		      compilation-mode-map
		      diff-mode-map
		      dired-mode-map
		      flyspell-mode-map
		      garak-mode-hook
		      gnus-article-mode-map
		      gnus-group-mode-map
		      gnus-summary-mode-map
		      help-mode-map
		      ido-buffer-completion-map
		      ido-file-completion-map
		      isearch-mode-map
		      java-mode-map
		      makefile-gmake-mode-hook
		      maplev-mode-map
		      maxima-mode-hook
		      message-mode-hook
		      minibuffer-local-map
		      nxml-mode-hook
		      org-agenda-mode-map
		      org-mode-map
		      py-mode-map
		      python-mode-map
		      query-replace-map
		      shell-mode-map
		      slime-mode-hook
		      slime-repl-mode-hook
		      term-mode-map
		      twittering-mode-hook
		      vc-annotate-mode-map
		      w3m-minor-mode-map
		      w3m-mode-map
		      ))

;; DONE isearch-mode-map M-r
;; CANCELLED сделать eab/union-keys не списком, а картой (map)
;; Будут ошибки, т.к. не все карты загружены. Значит, надо через hook, а не сразу все.
;; В eab-kbd.el уже есть заготовка для всех рабочих map
;; Создать eab/union-keys - все совпавшие с eab/ergo-keys кейбинды в рабочих map's - eab/ergo-maps.
;; (setq eab/union-keys (eab/proc-keys 'eab/check-map eab/ergo-maps))

;; (lookup-key (keymapp (car eab/ergo-maps)) (read-kbd-macro "M-l"))
;; (eab/print-0 (eab/check-map gnus-group-mode-map))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;  (mapcar (lambda (e) (if (consp e) (let ((h (car e)) (tl (cdr e))) (if (numberp h) (list (key-description `[,h]) tl))))) (keymap-canonicalize dired-mode-map))

;; (key-description (car (where-is-internal 'shell-command)))

(defun eab/parse-keymaps (a b)
  (push
   (list
    (if (numberp a)
	(key-description `[,a])
      a)
    (if (keymapp b)
	(progn
	  (push "keymap" eab/key-bindings)
	  (map-keymap 'eab/parse-keymaps b)
	  'nil)
      b))
   eab/key-bindings))

;; (progn
;;   (setq eab/key-bindings (make-hash-table :test 'equal))
;;   (map-keymap 'eab/parse-keymaps org-mode-map))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/check-map (map)
  "Make list of overlapping my eab/ergo-keys and keybindings of map"
  (remove-if-not (lambda (l) (cadr l))
                 (mapcar
		  (lambda (key)
		     (let
			 ((fun (lookup-key map (read-kbd-macro key))))
		       (if fun
			   (list key fun))))
		  eab/ergo-keys)
		 ))

(defun eab/print-0 (body)
  "Insert value of body in current-buffer."
  (let ((print-length nil)
	(eval-expression-print-length nil))
    (prin1 `,body (current-buffer))))

(defun eab/free-map (map)
  "Make free my eab/ergo-keys keybindings in map."
  (mapcar (lambda (key)
	     (define-key map (read-kbd-macro key) 'nil))
	  (mapcar (lambda (h)
		     (car h))
		  (eab/check-map map))))

;; (eab/print-0 (eab/check-map dired-mode-map))

(provide 'eab-kbd-ext)
