(require 'yasnippet)

(setq yas-snippet-dirs '())
;; cd el-get && git clone https://github.com/AndreaCrotti/yasnippet-snippets
(add-to-list 'yas-snippet-dirs (eab/bind-path eab/yasnippets-path))
(add-to-list 'yas-snippet-dirs (eab/bind-path eab/eab-snippets-path))

(setq yas-key-syntaxes '("w_" "w_." "w_.()" "^ "))

(defun yas-org-very-safe-expand ()
  (let ((yas-fallback-behavior 'return-nil))
    (yas-expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas-trigger-key)
            (setq yas-trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas-org-very-safe-expand)
            (define-key yas-keymap [tab] 'yas-next-field)))

(provide 'eab-yasnippet)
