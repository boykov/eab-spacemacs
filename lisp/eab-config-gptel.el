;;; eab-config-gptel.el --- eab-config gptel configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package gptel
  :after (eab-depend)
  :config
  (global-set-key (kbd "C-v") nil)
  (general-define-key
   "C-v d"        'vc-diff
   "C-v p"        'gptel-system-prompt
   "C-v c"        'eab/gptel-magit-generate-message
   "C-v m"        'gptel-menu
   "C-v g"        'gptel
   "C-v n"        (ilam (call-interactively 'eab/ergoemacs-new-empty-buffer)
                        (call-interactively 'eab/gptel-mode))
   "C-v A"        'gptel-agent
   "C-v a"        'ai-code-menu
   "C-v r"        'eab/gptel-rewrite
   "C-v v"        'eab/gptel-mode
   "C-v t"        'gptel-tools
   "C-v s"        'gptel-abort ;; stop
   "C-v C-v"      'eab/gptel-mode)

  (defvar eab/orai-token-cache "" "")
  (defun eab/orai-token ()
    (if (not (equal (length eab/orai-token-cache) 73))
        (setq eab/orai-token-cache
              (substring (shell-command-to-string
                          (eab/config (concat eab/ssh-host " bash <<'END'
~/git/auto/keepass.sh \"openrouter\" -a or-ai-api-key
END
" ))) 0 -1)))
    eab/orai-token-cache)
  (defvar eab/webui-token-cache "" "")
  (defun eab/webui-token ()
    (if (not (equal (length eab/webui-token-cache) 35))
        (setq eab/webui-token-cache
              (substring (shell-command-to-string
                          (eab/config (concat eab/ssh-host " bash <<'END'
~/git/auto/keepass.sh \"openrouter\" -a webui-api-key
END
" ))) 0 -1)))
    eab/webui-token-cache)
  (setq gptel-default-mode 'org-mode)
  (setq gptel-expert-commands 't)
  ;; TODO: use gptel-api-key-from-auth-source + auth-source-search instead?
  (setq gptel-api-key (eab/orai-token))
  (require 'gptel-request)
  (add-to-list 'gptel-directives
               '(google-ai-eab . "Действуй как поисковая система Google с функцией AI Overviews.
Соблюдай следующие правила структуры и стиля:
Начни с прямого, емкого ответа на 2–3 предложения в самом начале.
Продолжи развернутым объяснением, разбив ключевые детали на маркированные списки (bullet points).
Тон ответа должен быть объективным, информативным, нейтральным и экспертным.
В конце добавь блок из 3–4 коротких вопросов для дальнейшего углубления в тему (раздел \"С этим часто ищут\").
Пиши так, будто синтезируешь данные из нескольких авторитетных интернет-источников.
К КАЖДОМУ важному факту, цифре или утверждению обязательно добавляй
гиперссылку на авторитетный источник в формате [[URL][Название источника]].
 Если точной ссылки из базы данных нет, используй
реальные домены первоисточников или официальных баз данных, избегая
выдуманных URL. В конце ответа добавь блок «Источники», где перечисли
все использованные сайты списком с активными ссылками.
"))
  ;; (setq gptel-log-level 'debug)
  ;; (setq gptel-confirm-tool-calls 'always)
  ;; (setq gptel-use-curl nil) ;; url-retrieve
  (gptel-make-openai "OpenWebui"
    :host "192.168.2.18:3003"
    :protocol "http"
    :endpoint "/api/chat/completions"
    :stream t
    ;; :request-params '(:metadata [(:web_search "true")])
    :request-params '(:params (:function_calling "legacy")
                              :features (:web_search "true")
                              :terminal_id "b24d07f3-ed81-46c7-a395-84b6fdbf23dc")
    :key (eab/webui-token)
    :models '(google/gemini-3.7-flash
              z-ai/glm-5.3-flash))
  (gptel-make-openai "OpenRouter"
    :host "openrouter.ai"
    :curl-args '("-xsocks5://192.168.2.19:9050")
    :endpoint "/api/v1/chat/completions"
    ;; :request-params '(:plugins [(:id "web")]) ;; deprecated openrouter web plugin
    ;; :request-params '(:tools [(:type "openrouter:web_search")])
    :stream t
    :key gptel-api-key
    :models '(openai/gpt-oss-120b
              openai/gpt-oss-120b:nitro
              z-ai/glm-5.3-flash
              z-ai/glm-5.2
              openai/gpt-6-astra
              qwen/qwen3.8-max-0902
              perplexity/sonar
              x-ai/grok-4.20-multi-agent
              qwen/qwen-turbo
              nvidia/nemotron-3-super-120b-a12b:free
              qwen/qwen3-coder-30b-a3b-instruct
              qwen/qwen3-coder-next
              deepseek/deepseek-v3.2
              deepseek/deepseek-v4-pro
              deepseek/deepseek-v4-flash
              mistralai/mixtral-8x7b-instruct
              meta-llama/codellama-34b-instruct
              codellama/codellama-70b-instruct
              google/palm-2-codechat-bison-32k
              minimax/minimax-m2.7
              morph/morph-v3-fast
              google/gemini-3.7-flash
              google/gemini-3.5-flash-lite:nitro
              ))
  '((setq gptel-model   'z-ai/glm-5.3-flash
          gptel-backend (gptel-get-backend "OpenWebui"))
    )
  (setq gptel-model   'z-ai/glm-5.3-flash
        gptel-backend (gptel-get-backend "OpenRouter"))

  (defun eab/gptel-one-shot-3 ()
    (interactive)
    (setq eab/gptel-one-shot-model gptel-model)
    (setq gptel-model 'google/gemini-3.5-flash-lite:nitro)
    ;; (setq gptel-model 'openai/gpt-oss-120b:nitro)
    (let ((inhibit-message t))
      (kill-new
       "Суммируй приведенный текст ровно тремя словами.
Не приводи предупреждение о противоречии и приоритете требований.
Формат ответа -- только 3 слова через дефис, например: деньги-дата-отложить.
"))
    (execute-kbd-macro
     (read-kbd-macro "C-v m d M-v RET k m RET RET"))
    (setq gptel-model eab/gptel-one-shot-model))
  (setq eab/gptel-rewrite-note
        "Rewrite: Все текстовые блоки должны стать элементами org-mode списка.
 Строки текста должны быть не длиннее 80 символов, перенос на следующую строку если длиннее.")
  (defun eab/gptel-rewrite ()
    "Rewrite the current buffer or region.
This function sets the gptel model to qwen/qwen3-coder-30b-a3b-instruct and
calls the gptel-rewrite interactive command."
    (interactive)
    (setq gptel-model 'qwen/qwen3-coder-30b-a3b-instruct)
    (call-interactively 'gptel-rewrite))
  (defun eab/gptel-mode ()
    (interactive)
    (call-interactively 'org-mode)
    (call-interactively 'gptel-mode)))
