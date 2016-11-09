(use-package eab-kbd)

(global-set-key (kbd "C-d") nil)
(general-define-key
 :prefix "C-d"
 "q" 'eab/nocommand
 "a" 'eab/compile-helm
 "d" 'projectile-compile-project
 "s" 'smart-compile
 "l" `(,(ilam (TeX-command "LaTeX" 'TeX-master-file)) :which-key "")
 "b" `(,(ilam (TeX-command "BibTeX" 'TeX-master-file)) :which-key "")
 "L" `(,(ilam (TeX-command "LaTeX" 'TeX-master-file)) :which-key "")
 "v" `(,(ilam (eab/switch-wmctrl-window "main.pdf")) :which-key "")
 ;; "b" `(,(ilam (eab/switch-wmctrl-window "BoykovEA_5.pdf")) :which-key "")
 "p" 'eab/ido-wmctrl-pdf
 "c" `(,(ilam (execute-kbd-macro (read-kbd-macro "C-d d ESC SPC ESC h ESC X make SPC clear RET"))) :which-key "")
 "t" `(,(ilam (execute-kbd-macro (read-kbd-macro "C-d d ESC SPC ESC h ESC X make SPC test RET"))) :which-key "")
 "2" `(,(ilam (execute-kbd-macro (read-kbd-macro "C-d d ESC SPC ESC h ESC X make SPC test2 RET"))) :which-key ""))
(setq eab/compile-map (lookup-key global-map (kbd "C-d")))

(global-set-key (kbd "C-e") nil)
(general-define-key
 :prefix "C-e"
 "b" 'maplev-cmaple-send-buffer
 "t" 'eab/switch-eepitch-target
 "a" `(,(ilam (eepitch-ansi-term "1")) :which-key "")
 "1" `(,(ilam (eepitch-ansi-term "1")) :which-key "")
 "2" `(,(ilam (eepitch-ansi-term "2")) :which-key "")
 "3" `(,(ilam (eepitch-ansi-term "3")) :which-key "")
 "4" `(,(ilam (eepitch-ansi-term "4")) :which-key "")
 "5" `(,(ilam (eepitch-ansi-term "5")) :which-key "")
 "6" `(,(ilam (eepitch-ansi-term "6")) :which-key "")
 "7" `(,(ilam (eepitch-ansi-term "7")) :which-key "")
 "8" `(,(ilam (eepitch-ansi-term "8")) :which-key "")
 "9" `(,(ilam (eepitch-ansi-term "9")) :which-key "")
 "c" 'eab/switch-compile
 "x" 'nil
 "h" 'eab/switch-help
 "z" 'undo-tree-visualize
 "s" 'eab/switch-async
 "p" 'eepitch-python
 "P" 'eepitch-php
 "i" 'eepitch-ipython
 "m" 'eab/switch-message
 "k" `(,(ilam (eepitch-kill)) :which-key "")
 "M" 'eepitch-maxima
 "@" 'eepitch-maple
 "f" 'eepitch-shell-cluster
 "o" 'proced
 "-" 'eepitch-sage-python
 "g" 'eab/switch-grep
 "G" 'eab/kill-last-grep
 "l" 'helm-locate
 "C" 'docker-containers
 "I" 'docker-images)
(setq eab/one-key-map (lookup-key global-map (kbd "C-e")))
