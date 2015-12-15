(require 'eev-all)
(require 'eev-browse-url)
(require 'eev-mini-steps)

(eab/bind-path eab/eeansi-path)
(eab/bind-path eab/eegchannel-path)
(eab/bind-path eab/maple-path)
(eab/bind-path eab/maxima-path)
(eab/bind-path eab/ipython-path)

(defun eab/run-ansi (prog buf)
  (let ((buffer (get-buffer (concat "*" buf "*"))))
    (if buffer
        (switch-to-buffer-other-window buffer)
      (ansi-term prog buf))))

(defun eepitch-ansi-term (sym)
  (interactive)
  (shell-command (concat "echo \"" eab/eegchannel-path " " sym " /bin/bash\" > " eab/eeansi-path))
  (eechannel sym)
  (save-window-excursion
    (eepitch `(eab/run-ansi eab/eeansi-path (concat "ansi-term" ,sym))))
  (switch-to-buffer-other-window (concat "*ansi-term" sym "*")))

(defun eab/in-target-buffer? (str)
  (if (<= (+ (length str) 1) (length (buffer-name eepitch-target-buffer)))
      (string= (substring (buffer-name eepitch-target-buffer) 0 (+ (length str) 1))
               (concat "*" str))))

(defun eab/ansi-prepare (line)
  (if (or (string-match "^$ " line)
          (string-match "^~$ " line))
      (list (substring line 2) 't)
    (list line 't)))

(defun eab/py-prepare (line)
  (pymacs-eval (concat "r\"\"\"" line " \"\"\".strip().split(\">>> \")[-1]")))

;; TODO здесь, вместо рассмотрения различных вариантов(т.е. логика в коде)
;; попробовать применить табличный метод (логика в таблице)
(defun eab/this-line (line)
  ;; return true or false in depending on
  (cond
	;;  ((eab/in-target-buffer? "sage -python")
        ;;  (list (eab/py-prepare line) t))
        ;; ((eab/in-target-buffer? "sage")
        ;;  (eab/sage-prepare line))
        ((eab/in-target-buffer? "ansi")
         (eab/ansi-prepare line))
        ;; ((eab/in-target-buffer? "maple")
        ;;  (if (string-match "^# \\*\\(.*\\)" line) ; lines with a comment and star
        ;;      (list (substring line 3) (eab/mpl-prepare))
        ;;    (list line (eab/mpl-prepare))))
        ((eab/in-target-buffer? "python")
         (list (eab/py-prepare line) t))
        ((eab/in-target-buffer? "ipython")
         (list (eab/py-prepare line) t))
        (t (list line 't))))

(defun eab/wrap-eepitch-this (line)
  (interactive)
  ;; (if (string-match "^\\(.*\\)" line)             ; lines with a red star
  ;;     (ee-eval-string (match-string 1 line))       ; are eval'ed -
  (if (eab/in-target-buffer? "ansi")
      (eechannel-send nil (concat line "\n"))
    (progn
      (eepitch-prepare-target-buffer)	; for other lines reconstruct the
      (eepitch-display-target-buffer)	; target buffer, display it, make
      (eepitch-not-this-buffer)  ; sure it's a different buffer, and
      (eepitch-line line))))	   ; pitch the line to the target.

;; badstyle

(defun eab/eepitch-buffer-end ()
  (save-window-excursion
    (let ((cur (current-buffer)))
      (switch-to-buffer-other-window eepitch-target-buffer)
      (goto-char (point-max))
      (switch-to-buffer-other-window cur))))

(defun eab/append-this-line ()
  (interactive)
  (let* ((prepare (eab/ansi-prepare (url-eat-trailing-space (buffer-substring (ee-bol) (ee-eol)))))
	 (line (car prepare))
	 (line-split (cadr (split-string line"\\$ "))))
    (ergoemacs-move-cursor-next-pane)
    (insert line-split)
    (newline)
    (ergoemacs-move-cursor-next-pane)))

(defun eab/append-this-line ()
  (interactive)
  (ergoemacs-move-cursor-next-pane)
  (insert (substring (shell-command-to-string "cat ~/.bash_history | tail -1") 0 -1))
  (newline)
  (ergoemacs-move-cursor-next-pane))

;; TODO (buffer-name) -> (file-name-nondirectory (buffer-file-name))
(defun eab/eepitch-this-line (&optional arg)
  (interactive "p")
  (eab/eepitch-buffer-end)
  (let* ((prepare (eab/this-line (buffer-substring (ee-bol) (ee-eol))))
         (line (car prepare))
         (name (concat (buffer-name) ".line")))
    (if (cadr prepare)
        (if (string-match "^\\(.*\\)" line)             ; lines with a red star
            (ee-eval-string (match-string 1 line))       ; are eval'ed -
          (if (eq arg 4) (eab/wrap-eepitch-this (concat "    " line))
            (if (eq arg 2) (eab/wrap-eepitch-this (concat "        " line))
              (if (eq arg 3) (eab/wrap-eepitch-this (concat "            " line))
                (eab/wrap-eepitch-this line))))
          (ee-next-line 1)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO (buffer-name) -> (file-name-nondirectory (buffer-file-name))
(defun eab/mpl-prepare ()
  ;; Frozen
  (if (string= "*maple 117*" (buffer-name eepitch-target-buffer))
      (shell-command (concat "scp " buffer-file-name " user@192.168.0.140:" (buffer-name))))
  (eab/maplev-mint-region (ee-bol) (ee-eol)))

(defun eab/sage-prepare (line)
  (if (string-match "sage: " line)
      (list (substring line 6) 't)
    (list "" 't)))

(defun moz-send (string)
  "Send a string for evaluation to the inferior Mozilla process."
  (comint-send-string (inferior-moz-process) string)
  (comint-send-string "\n--end-emacs-input\n")
  (display-buffer (process-buffer (inferior-moz-process))))

(defun eab/moz-this-line (&optional arg)
  (interactive "p")
  (let* ((prepare (eab/this-line (buffer-substring (ee-bol) (ee-eol))))
	 (line (car prepare)))
    (moz-send line)
    (ee-next-line 1)))

;; CANCELLED сделать аналогично maple
;; почти весь код продублирован из функции py-execute-region
(defun eab/py-execute-region (start end)
  (interactive "r")
  (save-excursion
    (goto-char start)
    (beginning-of-line)
    ;; Пропустить пустую строку.
    (while (and (looking-at "\\s *$")
                (< (point) end))
      (forward-line 1))
    (setq start (point))
    (or (< start end)
        (error "Region is empty"))
    ;; 1 строка: посчитать отступ.
    (let ((indent (- (py-point 'boi) (py-point 'bol)))
          (name (concat buffer-file-name ".region"))
          (cur (current-buffer)))
      (switch-to-buffer name)
      ;; Обезвредить этот отступ путем добавления if 1:\n со всех строк, чтобы область соответствовала правилу питона для пробелов.
      (while (not (= indent 0))
        (insert "if 1:\n")
        (if (not (= indent 4)) (insert "    "))
        (setq indent (- indent 4)))
      (insert-buffer-substring cur start end)
      (write-file name)
      (kill-buffer)
      (let ((line (concat "execfile(\"" name "\")"))) ; contents of this line
        (eab/wrap-eepitch-this line))
      )
    ))

(defun eab/py-execute-buffer ()
  (interactive)
  ;; подготовить выражение для line
  (let ((line (concat "execfile(\"" buffer-file-name "\")"))) ; contents of this line
    (eab/wrap-eepitch-this line)))

(defun eab/maplev-mint-region (start end)
  (let ((maplev-mint-info-level maplev-mint-error-level)) ;; CANCELLED: Change to -S for syntax only!
    (equal 0 (maplev-mint-region start end))))

;; TODO (buffer-name) -> (file-name-nondirectory (buffer-file-name))
(defun eab/mpl-execute-region (start end)
  (interactive "r")
  (eab/eepitch-buffer-end)
  (save-excursion
    (goto-char start)
    (beginning-of-line)
    ;; Пропустить пустую строку.
    (setq start (point))
    (or (< start end)
        (error "Region is empty"))
    (let* ((cur (current-buffer))
           (name (concat (buffer-name) ".region")))
      (switch-to-buffer name)
      (insert-buffer-substring cur start end)
      (if (not (equal (eab/maplev-mint-region (point-min) (point-max)) 0))
          (progn
            ;; (insert "print();")
            (write-file name)
            (eab/mpl-prepare) ;; this functionality for lines only
            (kill-buffer)
            (let ((line (concat "read \"" name "\";"))) ; contents of this line
              (eab/wrap-eepitch-this line)
              )))
      )
    (sleep-for 0.6)
    (keyboard-quit)
    (keyboard-quit)
    (keyboard-quit)))

;; (eepitch-maple)
;; CANCELLED эта строка срабатывает только после запуска eepitch-maple
(fset 'maplev-cmaple-send-region 'eab/mpl-execute-region)

(defun eab/eepitch-paragraph ()
  (interactive)
  (backward-paragraph)
  (let ((st (point)))
    (forward-paragraph)
    (let ((en (point)))
      (cond
       ((eab/in-target-buffer? "maple")
        (eab/mpl-execute-region st en))
       ((eab/in-target-buffer? "python")
        (eab/py-execute-region st en))
       ((eab/in-target-buffer? "ipython")
        (eab/py-execute-region st en))))))

(defun eab/run-eshell (buf)
  (let ((buffer (get-buffer (concat "*" buf "*"))))
    (if buffer
        (switch-to-buffer buffer)
      (eshell))))

(defun eepitch-eshell2  () (interactive) (eepitch `(eab/run-eshell "eshell")))

(defun eepitch-sage  () (interactive) (eepitch-comint "sage"  "sage"))
(defun eepitch-php  () (interactive) (eepitch-comint "php"  "phpsh"))
(defun eepitch-sage-python  () (interactive) (eepitch-comint "sage -python"  "sage -python"))
(defun eepitch-maple-cluster () (interactive)
  (if (eq (comint-check-proc "*maple 117*") nil)
      (progn
        (eepitch-comint "maple 117" "ssh user@192.168.0.140")
        (eab/wrap-eepitch-this "\"C:\\Program Files\\Maple 10\\bin.win\\cmaple\" -q"))
    (eepitch-comint "maple 117" "ssh user@192.168.0.140")))

(defun eepitch-maple ()
  (interactive)
  (fset 'maplev-cmaple-send-region 'eab/mpl-execute-region)
  (shell-command (concat "echo \"" eab/maple-path " -q\" > " eab/eeansi-path))
  (eepitch `(eab/run-ansi eab/eeansi-path "maple local"))
  (switch-to-buffer-other-window "*maple local*")
  (term-line-mode))

(defun eepitch-maxima ()
  (interactive)
  (shell-command (concat "echo \"" eab/maxima-path " -q\" > " eab/eeansi-path))
  (eepitch `(eab/run-ansi eab/eeansi-path "maxima local"))
  (switch-to-buffer-other-window "*maxima local*")
  (term-line-mode))

(defun eepitch-ipython ()
  (interactive)
  (shell-command (concat "echo \"" eab/ipython-path " \" > " eab/eeansi-path))
  (eepitch `(eab/run-ansi eab/eeansi-path "ipython local"))
  (switch-to-buffer-other-window "*ipython local*"))

(defun eepitch-maple2 () (interactive) (eepitch-comint "maple 2 local" (concat eab/maple-path " -q")))
(defun eepitch-shell-cluster () (interactive) (eepitch-comint "shell febras" "ssh mercury.febras.net"))

;; problems between python.el and python-mode.el
;; C-c\C-r from python.el, but we need python-mode.el
;; There C-c| py-execute-region
;; (fset 'eab/python-send-paragraph
;;    "\350\C-c\C-r\M-}\C-n")

(provide 'eab-eepitch)
