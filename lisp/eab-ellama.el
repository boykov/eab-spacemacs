;;; eab-ellama.el --- eab ellama configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defvar eab/ycai-token-cache "" "")
(defun eab/ycai-token ()
  (if (not (equal (length eab/ycai-token-cache) 40))
      (setq eab/ycai-token-cache
            (substring (shell-command-to-string
                        (eab/config (concat eab/ssh-host " bash <<'END'
~/git/auto/keepass.sh \"portal/yandex cloud\" -a yc-ai-api-key
END
" ))) 0 -1)))
  eab/ycai-token-cache)

(defvar eab/yc-id-cache "" "")
(defun eab/yc-id ()
  (if (not (equal (length eab/yc-id-cache) 20))
      (setq eab/yc-id-cache
            (substring (shell-command-to-string
                        (eab/config (concat eab/ssh-host " bash <<'END'
~/git/auto/keepass.sh \"portal/yandex cloud\" -a yc-id
END
" ))) 0 -1)))
  eab/yc-id-cache)
(use-package ellama
  :after (llm llm-openai)
  :config
  (setq eab-llm (make-llm-openai-compatible
                 :url "https://llm.api.cloud.yandex.net/v1"
                 :chat-model (concat "gpt://" (eab/yc-id) "/yandexgpt/rc")
                 :key (eab/ycai-token)))
  (setopt ellama-language "Russian")
  (setopt ellama-provider eab-llm)
  (setopt ellama-coding-provider eab-llm))
