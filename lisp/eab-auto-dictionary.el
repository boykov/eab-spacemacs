;;; eab-auto-dictionary.el --- eab auto-dictionary extension

;; Copyright (C) 2010-2021 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords: 
;; Requirements: auto-dictionary
;; Status: not intended to be distributed yet

(require 'auto-dictionary)

;; (add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))
;; TODO it checks whole buffer
;; может, надо не менять словари, а просто работать с двумя одновременно?

(setq adict-language-list '(nil "en" "de" "fr" "es" "sv" "sl" "hu" "ro" "pt" "ru"))

(setq adict-dictionary-list   (mapcar 'adict-guess-dictionary-name
          '(nil
            ("en" "english")
            ("de" "deutsch" "german")
            ("fr" "francais" "french")
            ("es" "espa│Яol" "spanish")
            ("sv" "svenska" "swedish")
            ("sl" "slovenian" "slovene")
            ("hu" "magyar" "hungarian")
            ("ro" "rom│Бn│Б" "rom│Бne°Т═Ъte" "romanian")
            ("pt" "portugu│Йs" "portuguese")
	    ("ru" "русский" "russian"))))

(let ((hash  adict-hash))
  (adict-add-word hash 10 "и" "в" "не" "на" "что" "с" "то" "я" "он" "как" "а"
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
		"этих" "говорил" "вместе" "назад"))

(provide 'eab-auto-dictionary)
