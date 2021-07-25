

(eab/bind-path source-directory)
(setq find-function-C-source-directory source-directory)
(setq browse-url-browser-function (quote browse-url-firefox))


;; TODO depend on auto-complete, eab/trans-path
(eab/bind-path eab/trans-path)

(setq ring-bell-function 'ignore)

(defadvice kmacro-start-macro (before eab-kmacro-start activate)
  (if auto-complete-mode (call-interactively 'auto-complete-mode)))

(defadvice kmacro-end-macro (after eab-kmacro-end activate)
  (if (not auto-complete-mode) (call-interactively 'auto-complete-mode)))

(defun eab/latinize (str)
  (substring (shell-command-to-string (concat "python " eab/trans-path " \"" str "\"")) 0 -1))

(defun eab/latinize-region (start end)
  (interactive "r")
  (let ((str (filter-buffer-substring start end)))
    (kill-region start end)
    (insert (eab/latinize str))))

;; DONE
;; xset dpms force off/on
;; gnome-screensaver-command -a

(defun eab/screen-off ()
  (interactive)
  (sleep-for 0.2)
  (eab/shell-command "xset dpms force off" nil 0)
  (suspend-frame))

(defun eab/gnome-terminal ()
  (eab/shell-command "gnome-terminal" nil 0))

(defun google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
			   (buffer-substring (region-beginning) (region-end))
			 (read-string "Google: "))))))

(provide 'eab-ui)
