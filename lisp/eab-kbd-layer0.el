;;; eab-kbd-layer0.el --- 

;; Copyright (C) 2010-2015 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;; TODO это временное средство, пока перемещаю сюда команды, которые
;; не доступны в dpemacs

(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "C-b") 'switch-to-buffer)
(global-set-key (kbd "M-a") 'execute-extended-command)
(global-set-key (kbd "C-t") 'transpose-sexps)
(global-set-key (kbd "M-m") 'forward-sexp)
(global-set-key (kbd "M-n") 'backward-sexp)

(provide 'eab-kbd-layer0)
