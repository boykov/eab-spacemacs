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
