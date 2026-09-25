(eab/search-word eab/google-translate "google translate" eab/shell-translate (word))
(eab/search-word eab/google-translate "google translate" eab/shell-translate-remote (word))

(defvar eab/translate-path (eab/config "~/bin/translate") "")

;; TODO баг: зацикливание (много bash процессов) trying with detected language
;; пример со словом hunchentoot
;; убить можно pkill -f bash
(defun eab/shell-translate (phrase &optional not-abbrevp)
  (interactive)
  (setq eab/tmp-str
        (split-string
         (ansi-color-filter-apply
          (shell-command-to-string
           (concat "export TERM=eterm-color && " eab/translate-path " " phrase)))
         "\n"))
  (unless not-abbrevp
    (define-abbrev eab-abbrev-table phrase (car eab/tmp-str)))
  (message "%s" (car eab/tmp-str)))

(defun eab/shell-translate-remote (phrase)
  (interactive)
  (funcall
   `(lambda ()
      (async-start
       (lambda ()
         (require 'server)
         (let ((server-use-tcp ,server-C-use-tcp))
           (server-eval-at ,(eab/target-C)
                           '(eab/shell-translate ,phrase 't))))
       (lambda (result)
         (message "async result: <%s>" result)
         (define-abbrev eab-abbrev-table ,phrase result))))))
