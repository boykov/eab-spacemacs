(require 'etags-select)
(require 'etags-table)

(setq tags-table-list nil)
(setq tags-file-name nil)

(setq etags-table-alist 'nil) ;; попробуем использовать search up depth

;; см. также locate -r TAGS$ - полный список файлов TAGS в системе
;; пример целевого файла для конкретного проекта

(setq etags-table-search-up-depth 10)

(defun eab/etags-find-or-pop ()
  (interactive)
  (if (memq last-command '(eab/etags-find-or-pop))
      (call-interactively 'pop-tag-mark)
    (call-interactively 'etags-select-find-tag-at-point)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eab/ido-find-tag ()
  "Find a tag using ido"
  (interactive)
  (tags-completion-table)
  (let (tag-names)
    (mapatoms (lambda (x)
                (push (prin1-to-string x t) tag-names))
              tags-completion-table)
    (etags-select-find (ido-completing-read "Tag: " tag-names))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Tags file creation
;; DONE также, можно посмотреть gtags: посмотрел, не подходит, там для больших проектов и мало языков
;; Вообще, здесь надо использовать defmacro или просто одну обобщённую функцию
;; также, можно использовать вариант с оберточной функцией, в которой выбирается нужная строка:
;; "-regex \"\\(.*el\\\|.*el.gz\\)\""
;; "-name \"*mpl\""
;; Интерфейс, аналогичный grep
;; CANCELLED вместо перебора вариантов сделать общий вызов для всех используемых мной языков.
;; Если будет плохо работать, там и посмотрим.
;; А нужно ли, вручную запускать? М.б. по типу updatedb?
(defun create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -regex \"\\(.*el\\\|.*el.gz\\)\" | etags - &"
                          dir-name)))


(defun mpl-create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -name \"*mpl\" | etags - &"
                          dir-name)))

(defun py-create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -name \"*py\" | etags - &"
                          dir-name)))


(defun c-and-fortran-create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -regex \"\\(.*\\.c\\\|.*\\.cpp\\\|.*\\.h\\\|.*\\.hpp\\\|.*\\.F90\\\|.*\\.F\\\|.*\\.f\\\|.*\\.f90\\\|.*\\.for\\\|.*\\.FOR\\|.*py\\)\" | ctags-exuberant -e  -f TAGS -L - &"
                          dir-name)))

(defun c-create-tags (dir-name) 
  "Create tags file." 
  (interactive "DDirectory: ")
  (shell-command (format "find %s -type f -regex \"\\(.*.c\\\|.*.h\\)\" | etags - &"
                          dir-name)))

(provide 'eab-tags)
