;; require smex, helm

(require 'smex)

(eab/bind-path smex-save-file)

(smex-initialize)

(defadvice smex-show-key-advice (around eab-advice-smex activate)
  "Put item to extended-command-history"
  (add-to-list 'extended-command-history (car smex-ido-cache)))

;; DONE сделать переключение в "полный" режим, где доступны все команды,
;; а не только extended-command-history
;; это похоже на eab/toggle-cxb-ido-item
(defun eab/smex-limited-commands ()
  "Command used instead `execute-extended-command'"
  (interactive)
  (let ((commands (append (nthcar 10 smex-ido-cache) extended-command-history))) ;; smex-ido-cache))
    (smex-read-and-run commands)))

;; DONE remove from extended-command-history all that not in obarray
(defun eab/clear-extended-history ()
  (interactive)
  (setq extended-command-history
	(let ((oblist (all-completions "" obarray 'fboundp)))
	  (remove-if-not (lambda (x) (member x oblist)) extended-command-history))))

;; DONE переместить курсор в конец текста после вызова
;; всё дело в (car choices)
(defun eab/smex-repeat ()
  (interactive)
  (smex-update-and-rerun))

;; DONE убрать грубое внедрение в код smex.el
(eab/patch-this-code 'smex-completing-read "(car choices)" "")

(defun eab/smex-extended ()
  "Command for calling `helm-minibuffer-history' from `smex'"
  (interactive)
  (if (smex-already-running)
      (let ((minibuffer-history-variable 'extended-command-history))
	(helm-minibuffer-history))
        (helm-minibuffer-history)))

(provide 'eab-smex)
