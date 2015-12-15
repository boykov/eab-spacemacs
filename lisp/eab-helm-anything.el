(require 'helm) ;; fix boundp helm-map
(require 'helm-descbinds)
(helm-descbinds-mode)
(require 'helm-elisp)
(require 'helm-locate)
(require 'helm-config)
(require 'helm-multi-match)
;;(require 'helm-match-plugin)
;; (helm-match-plugin-mode 0) ;; bug in terminal mode
(remove-hook 'helm-update-hook 'helm-mp-highlight-match)

(eab/bind-path helm-c-adaptative-history-file)

(defun eab/helm-select-action ()
  (interactive)
  (eab/sh-over-bash "xdg-open" (helm-get-selection) 't)
  (minibuffer-keyboard-quit))

(setq anything-source-ipython
      '((name . "Ipython completion")
	(candidates . (lambda ()
			(let ((py-which-bufname "ipython"))
			  (anything-ipython-completion-list anything-pattern))))
	(action . anything-ipyton-default-action)
	(volatile)
	(requires-pattern . 2)))

(setq anything-enable-shortcuts 'prefix)

;; (setq anything-c-locate-options `("locate" "-d" ,anything-c-locate-db-file "-i" "-r"))
;; (setq anything-c-locate-command "locate -i -e %s")
(setq helm-locate-command "locate %s -e -r %s")

;; (descbinds-anything-install)

(setq helm-idle-delay 0.01)
(setq helm-input-idle-delay 0.01)
(setq helm-candidate-number-limit 100)

(setq anything-sources '(anything-c-source-buffers
			 anything-c-source-file-name-history
			 anything-c-source-files-in-current-dir
			 anything-c-source-complex-command-history
			 anything-c-source-shell-history
			 anything-c-source-extended-command-history
			 ))

(setq helm-sources '(helm-c-source-buffers-list
		     helm-c-source-file-name-history
		     helm-c-source-files-in-current-dir
		     helm-c-source-complex-command-history
		     ))

(ignore-errors
  (add-to-list
   'anything-type-attributes
   '(eab
     (action
      ("Exec file" . (lambda (candidate)
		       (eab/sh-over-bash "xdg-open" candidate 'nil)
		       ))
      ("Find file" . anything-find-many-files)
      ("Move File"
       . (lambda (candidate)
	   (anything-c-open-dired candidate)
	   (dired-do-copy)
	   (dired-do-delete)
	   ))
      ("Copy File"
       . (lambda (candidate)
	   (anything-c-open-dired candidate)
	   (dired-do-copy)
	   ))
      ("Open dired in file's directory" . anything-c-open-dired))
     (persistent-help . "Show this file")
     (action-transformer
      anything-c-transform-file-load-el
      anything-c-transform-file-browse-url)
     (candidate-transformer
      anything-c-w32-pathname-transformer
      anything-c-skip-current-file
      anything-c-skip-boring-files
      anything-c-shorten-home-path))))

(eab/bind-path eab/downloads-path)

;; TODO м.б. делать локальные locate.db для подобных директорий? C-u helm-locate
(setq
 anything-c-source-ls-download
 '((name . "ls eab/downloads-path | grep -i %s")
   (candidates . (lambda ()
		   (start-process-shell-command
		    "ls-download"
		    nil
		    "find"
		    (concat " " eab/downloads-path " | grep -i ")
		    anything-pattern)))
   (type . eab)
   (requires-pattern . 1)
   (delayed)))

(ignore-errors
  (add-to-list
   'anything-type-attributes
   '(music
     (action
      ("Banshee File"
       . (lambda (candidate)
	   (eab/sh-over-bash "xdg-open" candidate 'nil)
	   ))
      ("Open dired in file's directory" . anything-c-open-dired))
     (persistent-help . "Show this file")
     (action-transformer
      anything-c-transform-file-load-el
      anything-c-transform-file-browse-url)
     (candidate-transformer
      anything-c-w32-pathname-transformer
      anything-c-skip-current-file
      anything-c-skip-boring-files
      anything-c-shorten-home-path))))

;; CANCELLED можно сделать через locate для скорости
;; возможно, не следует городить отдельную db для этого, а включить ../music в общую
;; (anything-other-buffer 'anything-c-source-ls-music "*anything locate*")

(eab/bind-path eab/musicdb-path)

(setq anything-c-source-ls-music
      '((name . "locate music")
        (candidates . (lambda () (let
                                     ((anything-c-locate-command
                                       (concat "locate -d " eab/musicdb-path " -i -r %s")))
                                   (anything-c-locate-init))))
        (type . music)
        (requires-pattern . 3)
        (delayed)))


(setq eab/anything-c-source-litrffi '((name . "Lines from file")
                                      (candidates . eab/anything-litrffi)
                                      (action . insert)))

(provide 'eab-helm-anything)
