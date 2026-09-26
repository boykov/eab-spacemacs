;;; eab-config-ellama.el --- eab-config ellama configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package ai-code
  :config
  (setq ai-code-backends-infra-use-side-window nil)
  (setq ai-code-mcp-agent-enabled-backends
        (remove 'claude-code ai-code-mcp-agent-enabled-backends))
  (setq ai-code-claude-code-program "bash")
  (setq ai-code-claude-code-program-switches '("/home/eab/git/eab-system/eab-spacemacs/claude.sh"))
  (setq ai-code-pi-program "bash")
  (setq ai-code-pi-program-switches '("/home/eab/git/eab-system/eab-spacemacs/pi.sh"))
  ;; (setq ai-code--session-project-root-override "/ssh:chronos:/home/eab/claude/")
  (setq ai-code--session-project-root-override "/home/eab/git/eab-system/eab-spacemacs/")
  (setq ai-code-backends-infra-terminal-backend 'ghostel)
  (ai-code-set-backend 'claude-code)
  ;; russian lang
  (setq ai-code-backends-infra-ghostel-enable-ime-integration nil)
  (ai-code-set-backend 'pi)
  )

(use-package llm)
(use-package llm-openai)

(use-package ellama
  :after (llm llm-openai)
  :config
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
  (setq eab-llm (eab/config
                 (make-llm-openai-compatible
                  :url "https://llm.api.cloud.yandex.net/v1"
                  :chat-model (concat "gpt://" (eab/yc-id) "/yandexgpt/rc")
                  :key (eab/ycai-token))))
  (setopt ellama-language "Russian")
  (setopt ellama-provider eab-llm)
  (setopt ellama-coding-provider eab-llm))
