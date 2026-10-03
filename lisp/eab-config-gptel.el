;;; eab-config-gptel.el --- eab-config gptel configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package gptel
  :after (eab-minimal)
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
              z-ai/glm-5.3-flash
              qwen/qwen3-next-80b-a3b-instruct))
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
              typesafe/jev-1.13
              qwen/qwen3.7-flash
              qwen/qwen3.5-9b
              z-ai/glm-5.3-flash
              z-ai/glm-5.2
              openai/gpt-6-astra
              qwen/qwen3.8-max-0902
              perplexity/sonar
              x-ai/grok-4.20-multi-agent
              qwen/qwen-turbo
              qwen/qwen3-coder-30b-a3b-instruct
              qwen/qwen3-next-80b-a3b-instruct
              qwen/qwen3-coder-next
              deepseek/deepseek-v3.2
              deepseek/deepseek-v4-pro
              deepseek/deepseek-v4-flash
              deepseek/deepseek-v4.1-flash
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
     (read-kbd-macro "C-v m d M-v RET k RET"))
    (setq gptel-model eab/gptel-one-shot-model))
  (defun eab/gptel-one-shot-fix-garbage ()
    (interactive)
    (setq eab/gptel-one-shot-model gptel-model)
    (setq gptel-model 'google/gemini-3.5-flash-lite:nitro)
    ;; (setq gptel-model 'openai/gpt-oss-120b:nitro)
    (let ((inhibit-message t))
      (kill-new
       "Убери лишние мусорные символы. Остальной текст повтори в точности.
"))
    (execute-kbd-macro
     (read-kbd-macro "C-v m d M-v RET i RET"))
    (setq gptel-model eab/gptel-one-shot-model))
  (defun eab/gptel-rewrite ()
    "Rewrite the current buffer or region.
This function sets the gptel model to qwen/qwen3-next-80b-a3b-instruct and
calls the gptel-rewrite interactive command."
    (interactive)
    (setq gptel-model 'qwen/qwen3-next-80b-a3b-instruct)
    (call-interactively 'gptel-rewrite))
  (defun eab/gptel-mode ()
    (interactive)
    (call-interactively 'org-mode)
    (call-interactively 'gptel-mode)))

(use-package gptel-agent
  :after (gptel)
  :config
  (add-to-list 'gptel-agent-dirs (eab/config (concat eab-spacemacs-path "agents")))
  (gptel-agent-update))

(use-package gptel-magit
  :after (magit gptel)
  :config
  (setq gptel-magit-model 'qwen/qwen3-coder-next)
  (setq gptel-magit-commit-prompt
        "
You are an expert at writing Git commits. Your job is to write a short
clear commit message that summarizes the changes.

The commit message should be structured as follows:

    <type>(<optional scope>): <description>

    [optional body]

- Commits MUST be prefixed with a type, which consists of one of the
  followings words: build, chore, ci, docs, feat, fix, perf, refactor,
  style, test
- The type feat MUST be used when a commit adds a new feature
- The type fix MUST be used when a commit represents a bug fix
- An optional scope MAY be provided after a type. A scope is a phrase
  describing a section of the codebase enclosed in parenthesis, e.g.,
  fix(parser):
- A description MUST immediately follow the type/scope prefix. The
  description is a short description of the code changes, e.g., fix:
  array parsing issue when multiple spaces were contained in string.
- Try to limit the whole subject line to 60 characters
- Capitalize the subject line
- Do not end the subject line with any punctuation
- Use the imperative mood in the subject line
- Keep the body short and concise (omit it entirely if not useful)
- Strings mustn't be longer 80 symbols, do line breaks if longer.
" )
  (defun eab/gptel-magit-generate-message ()
    "Generate a commit message."
    (interactive)
    (gptel-magit--generate (lambda (message)
                             (with-current-buffer (current-buffer)
                               (save-excursion
                                 (insert message)))))
    (message "magit-gptel: Generating commit message..."))
  (defun gptel-magit--generate (callback)
    "Generate a commit message for current magit repo.
Invokes CALLBACK with the generated message when done."
    (let ((diff (magit-git-output "diff" "--cached" "HEAD^"))
          (gptel-tools nil)
          (gptel-use-tools nil))
      (gptel-magit--request diff
        :system gptel-magit-commit-prompt
        :context nil
        :callback `(lambda (response _info)
                     (let ((msg response))
                       (funcall ,callback msg)))))))

(provide 'eab-config-gptel)
