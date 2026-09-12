;;; eab-eaf.el --- eab eaf configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package eaf
  :if (eab/ondaemon "cyclos")
  :config
  (setq eaf-webengine-pc-user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36")
  ;; (setq eaf-proxy-host "192.168.2.19")
  ;; (setq eaf-proxy-port "9152")
  ;; (setq eaf-proxy-type "http")
  ;; (eaf-restart-process)
  (advice-remove #'org-open-file #'eaf--find-file-advisor)
  (defun eab/org-eaf-open (path link)
    (eaf-open path))
  (defun eaf--dired-find-file-advisor (orig-fn)
    "Advisor of `dired-find-file' and `dired-find-alternate-file' that opens EAF supported file using EAF.

It currently identifies PDF, videos, images, and mindmap file extensions."
    (dolist (file (dired-get-marked-files))
      (let* ((local-file
              (if (and (file-remote-p file) (string-match-p "\\.[pP][dD][fF]\\'" file))
                  (let* ((tmp-file
                          (tramp-handle-file-local-copy file)))
                    tmp-file)
                file)))
        (eaf--find-file orig-fn local-file t))))
  (defun eab/eaf-open-viewer-other-window (url &optional args)
    "Open EAF browser application given a URL and ARGS in other window."
    (interactive "M[EAF/browser] URL: ")
    (when (< (length (window-list)) 2)
      (split-window-right))
    (other-window 1)
    (eaf-open url "pdf-viewer" args))
  (defmacro eab/eaf-bind-key (pair kb)
    (let ((f (intern (cdr pair)))
          (k (car pair)))
      `(eaf-bind-key ,f ,k ,kb)))
  (general-define-key
   :keymaps 'eaf-mode-map*
   "C-o"   'nil
   "C-c b" 'nil
   ))
;; doesn't work in eaf + remote vnc
;; (eaf-create-send-sequence-function "ctrl-t" "C-t") ;; needs eaf--buffer-id ?
;; (eaf-create-send-sequence-function "ctrl-v" "C-v") ;; needs eaf--buffer-id ?
(use-package eaf-browser
  :if (eab/ondaemon "cyclos")
  :after (eaf)
  :init
  (add-to-list 'load-path (concat eab-spacemacs-path "local/eaf/app/browser"))
  :config
  (setq eaf-browser-auto-import-chrome-cookies 't)
  (setq eaf-browser-chrome-browser-name "chrome")
  (setq eaf-browser-dark-mode-theme "light")
  (setq eaf-browser-dark-mode nil)
  ;; (eaf-create-send-sequence-function "ctrl-f" "C-f") ;; needs eaf--buffer-id ?
  (setq eaf-browser-keybinding nil)
  (let ((kb 'eaf-browser-keybinding))
    (mapc (lambda (x)
            (eval `(eab/eaf-bind-key ,x ,kb)))
          '(
            ("C-t" . "eab/eaf-browser-ctrl-t")
            ("C-f" . "eab/eaf-browser-ctrl-f")
            ("C-v" . "eab/eaf-browser-paste-clip")
            ("C-<escape>" . "eaf-browser-send-esc-or-exit-fullscreen")
            ("<escape>" . "eaf-browser-send-esc-or-exit-fullscreen")
            ;; ("C-t" . "eaf-send-ctrl-t-sequence")
            ;; ("C-v" . "eaf-send-ctrl-v-sequence")
            ("M-b" . "browser-a-lot-goto-prev")
            ;; ("0" . "insert_or_zoom_reset")
            ;; ("=" . "insert_or_zoom_in")
            ;; ("-" . "insert_or_zoom_out")
            ("C-<home>" . "scroll_to_begin")
            ("M-J" . "scroll_to_begin")
            ("C-<end>" . "scroll_to_bottom")
            ("M-L" . "scroll_to_bottom")
            ("M-l" . "toggle_dark_mode_light_theme")
            ("M-D" . "open_link")
            ("M-d" . "toggle_dark_mode")
            ("M-F" . "insert_or_history_forward")
            ("M-B" . "insert_or_history_backward")
            ("M-;" . "search_text_forward")
            ("M-:" . "search_text_backward")
            ("M-i" . "scroll_down")
            ("M-k" . "scroll_up")
            ("M-I" . "scroll_down_page")
            ("M-K" . "scroll_up_page")
            ("<next>" . "scroll_up_page")
            ("<prior>" . "scroll_down_page")
            ("M-c" . "copy_text")
            ("M-v" . "yank_text")
            ("C-w" . "insert_or_export_text")
            ("C-q" . "insert_or_close_buffer")
            ("C-e e" . "insert_or_edit_url")
            ))))
(use-package eaf-pdf-viewer
  :if (eab/ondaemon "cyclos")
  :after (eaf)
  :init
  (add-to-list 'load-path (concat eab-spacemacs-path "local/eaf/app/pdf-viewer"))
  :config
  (setq eaf-pdf-viewer-keybinding nil)
  (let ((kb 'eaf-pdf-viewer-keybinding))
    (mapc (lambda (x)
            (eval `(eab/eaf-bind-key ,x ,kb)))
          '(
            ("0" . "zoom_reset")
            ("=" . "zoom_in")
            ("-" . "zoom_out")
            ("B" . "viewer-a-lot-goto-prev")
            ("q" . "close_buffer")
            ("p" . "jump_to_page")
            ("o" . "eaf-pdf-outline")
            ("M-i" . "scroll_down")
            ("M-k" . "scroll_up")
            ("M-I" . "scroll_down_page")
            ("M-K" . "scroll_up_page")
            ("<next>" . "scroll_up_page")
            ("<prior>" . "scroll_down_page")
            ("M-c" . "copy_select")
            ("M-;" . "search_text_forward")
            ("M-:" . "search_text_backward")
            ("C-w" . "eaf-pdf-extract-page-text")
            ("C-<home>" . "scroll_to_begin")
            ("M-J" . "scroll_to_begin")
            ("C-<end>" . "scroll_to_end")
            ("M-L" . "scroll_to_end")
            ))))
