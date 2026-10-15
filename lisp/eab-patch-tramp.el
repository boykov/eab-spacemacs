;;; eab-patch-tramp.el --- eab tramp extension -*- lexical-binding: t -*-

(require 'find-func)

(eab/patch-this-code
 'tramp-do-copy-or-rename-file-out-of-band
 `(("(not (file-exists-p newname))" .
    ,(let ((print-quoted 't))
       (prin1-to-string
        `(progn 't))))
   ("(tramp-make-copy-file-name v2)" .
    ,(let ((print-quoted 't))
       (prin1-to-string
        `(if (string-equal (tramp-file-name-method v) "rsync")
             (let* ((vec (tramp-dissect-file-name newname))
                    (host (tramp-file-name-host vec))
                    (localname (tramp-file-name-localname vec)))
               (format "%s:%s" host localname))
           (tramp-make-copy-file-name v2))))))
 :lexical 't)

(defun eab/tramp-rsync-copy-args-add-a ()
  "Add additional arg (\"-a\") to `tramp-copy-args' of rsync method."
  (let ((copy-args
         (assq 'tramp-copy-args (cdr (assoc "rsync" tramp-methods)))))
    (when copy-args
      (setcdr copy-args
              (list (append (cadr copy-args) '(("-a"))))))))

(eab/tramp-rsync-copy-args-add-a)

(provide 'eab-patch-tramp)
