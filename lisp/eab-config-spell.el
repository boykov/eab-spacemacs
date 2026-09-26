;;; eab-config-spell.el --- eab-config spell configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package ispell
  :config
  (setq ispell-dictionary "english"))

(use-package flyspell
  :after (ispell)
  :config
  (eab/add-hook flyspell-mode-hook eab/flyspell-hook
    (general-define-key
     :keymaps 'flyspell-mode-map
     "C-k"        'toggle-input-method))
  (autoload 'tex-mode-flyspell-verify "flyspell" "" t)
  (setq flyspell-default-dictionary "english")
  (defun eab/flyspell-buffer (arg)
    (interactive "P")
    (let ((ispell-local-dictionary (if arg "en" "ru")))
      (flyspell-buffer)))
  (autoload 'flyspell-auto-correct-previous-word "flyspell" "Auto correct the first mispelled" t)
  (autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
  (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t))

(use-package auto-dictionary
  :config
  ;; (add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))
  ;; (flyspell-delete-all-overlays)
  (add-to-list 'adict-language-list "ru" 't)
  (add-to-list 'adict-dictionary-list
               `("ru" . ,(adict-guess-dictionary-name '("ru"))) 't)
  (let ((hash adict-hash))
    (adict-add-word hash 19 "и" "в" "не" "на" "что" "с" "то" "я" "он" "как" "а"
                    "по" "к" "его" "все" "из" "за" "это" "у" "же" "от" "но" "было" "так"
                    "бы" "о" "еще" "меня" "был" "только" "она" "уже" "ее" "мне" "сказал" "ты"
                    "для" "мы" "они" "до" "их" "когда" "или" "ему" "ни" "вы" "даже" "под"
                    "него" "если" "чтобы" "вот" "чем" "где" "себя" "была" "нас" "время"
                    "ли" "быть" "раз" "может" "есть" "со" "были" "там" "нет" "очень"
                    "кто" "без" "тут" "во" "будет" "тоже" "этого" "надо" "себе"
                    "да" "ничего" "при" "тебя" "них" "этом" "того" "можно" "этот"
                    "потом" "человек" "вас" "сейчас" "один" "здесь" "теперь" "тебе"
                    "через" "больше" "всех" "лет" "том" "после" "сам" "нибудь" "ним"
                    "просто" "вдруг" "над" "потому" "ведь" "вам" "дело" "тогда"
                    "спросил" "жизни" "два" "чего" "который" "тем" "нам" "перед"
                    "глаза" "всего" "уж" "им" "своей" "несколько" "день" "всегда"
                    "какой" "ей" "более" "такой" "тот" "этой" "нее" "которые"
                    "ней" "эти" "стал" "жизнь" "сразу" "мог" "совсем" "свою" "об"
                    "почему" "пока" "конечно" "люди" "года" "человека" "куда" "почти"
                    "руки" "людей" "хотя" "три" "снова" "хорошо" "знаю" "много" "сказать"
                    "будто" "лишь" "голову" "про" "сказала" "всем" "между" "говорит"
                    "никогда" "опять" "свои" "другой" "мой" "своих" "эту" "такое" "знал"
                    "своего" "таки" "собой" "дома" "времени" "чуть" "свой" "лучше" "именно"
                    "друг" "лицо" "руку" "вообще" "свое" "которой" "никто" "кого"
                    "этих" "говорил" "вместе" "назад")))