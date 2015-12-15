(eab/bind-path eab/print-dir)
(eab/bind-path eab/tmp-ps)

(setq ps-multibyte-buffer 'bdf-font-except-latin) ; set bdf fonts for russian lang

(defun print-region-to-pdf (from to)
  (interactive "r")
  (ps-spool-region-with-faces from to)
  (switch-to-buffer "*PostScript*")
  (write-file eab/tmp-ps)
  (kill-buffer "tmp.ps")
  (setq cmd (concat "ps2pdf14 " eab/tmp-ps " " eab/print-dir (buffer-name) ".pdf"))
  (shell-command cmd)
  (shell-command (concat "rm " eab/tmp-ps))
  (message (concat "Saved to:  " (buffer-name) ".pdf")))

(defun print-buffer-to-pdf ()
  (interactive)
  (ps-spool-buffer-with-faces)
  (switch-to-buffer "*PostScript*")
  (write-file eab/tmp-ps)
  (kill-buffer "tmp.ps")
  (setq cmd (concat "ps2pdf14 " eab/tmp-ps " " eab/print-dir (buffer-name) ".pdf"))
  (shell-command cmd)
  (shell-command (concat "rm " eab/tmp-ps))
  (message (concat "Saved to:  " (buffer-name) ".pdf")))

(provide 'eab-ps)
