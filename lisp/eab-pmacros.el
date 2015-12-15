(fset 'reply-last-mail
   [?\C-x ?b ?g ?r ?o ?u return ?\M-< ?g return ?r]) ;;?\M-> ?\C-p  

(fset 'eab/set-work-buffers
   [?\C-x ?1 ?\C-x ?1 ?\C-x ?1 ?\C-x ?b ?r ?u ?n ?. ?m ?p ?l return ?\C-x ?3 ?\C-x ?o ?\C-x ?b ?l ?i ?b ?s ?y ?m ?. ?m ?p ?l return ?\C-x ?o])


(fset 'eab/help-mode-back ;; see help-go-back 
   [?\M-L ?\M-: ?b ?a ?c ?k ?\C-m return]) ;ergo

(fset 'eab/help-mode-forward ;; see help-go-forward
   [?\M-L ?\M-: ?f ?o ?r ?w ?\C-m return])

(;--------------------------- power-macros ---------------------------
 ;---------------------s-n e - global definition----------------------
 ;--------------------------------------------------------------------
	pm-def-macro
	'wrap-clock
	'global [8388718 101]
	""
	"M-k M-C-u M-p RET :CLOCK: M-O M-C-o M-j RET :END: M-: :CLO RET"
 ;--------------------------------------------------------------------
)


(;--------------------------- power-macros ---------------------------
 ;---------------------s-n s - global definition----------------------
 ;--------------------------------------------------------------------
	pm-def-macro
	'split-clock
	'global [8388718 115]
	""
	"M-s C-n M-s M-SPC M-; :end: RET M-k M-h C-x n n s-a RET M-i M-SPC M-J M-k C-u M-a
 shell-command-on-region RET grep SPC CLOCK: RET M-L M-s M-SPC M-i M-X
 M-J M-SPC M-k M-X M-% SPC +CLOCK:.* C-q LFD 2*RET ! M-SPC M-J s-a RET
 M-SPC M-L M-X C-x k RET M-s C-x n w"
 ;--------------------------------------------------------------------
)


(;--------------------------- power-macros ---------------------------
 ;------------------s - specific for org-agenda-mode------------------
 ;--------------------------------------------------------------------
	pm-def-macro
	'schedule-28-1w
	'org-agenda-mode [115]
	""
	"C-c C-s 2014-04-28 RET TAB S-C-k M-; scheduled RET M-p M-j SPC +q DEL
 1w M-s"
 ;--------------------------------------------------------------------
)


(;--------------------------- power-macros ---------------------------
 ;---------------------s-n c - global definition----------------------
 ;--------------------------------------------------------------------
	pm-def-macro
	'insert-clock
	'global [8388718 99]
	"Insert <clock> at -"
	"M-; clock: RET 2*M-l M-SPC 2*M-m M-l M-c C-u C-SPC C-u C-SPC M-l SPC <
 M-v > M-; clock: RET M-; - SPC RET 2*M-j"
 ;--------------------------------------------------------------------
)


(;--------------------------- power-macros ---------------------------
 ;--------------------s-n SPC - global definition---------------------
 ;--------------------------------------------------------------------
	pm-def-macro
	'dash-to-space3
	'global [8388718 32]
	"Replace \"-\" by \" \""
	"M-h M-SPC M-p M-5 - RET SPC RET ! M-h"
 ;--------------------------------------------------------------------
)


(;--------------------------- power-macros ---------------------------
 ;-------------------s-n u - specific for org-mode--------------------
 ;--------------------------------------------------------------------
	pm-def-macro
	'mv-block-to-untitled
	'org-mode [8388718 117]
	""
	"M-SPC M-; clock: RET M-h M-x M-s M-v M-s M-; SPC - RET M-j M-h"
 ;--------------------------------------------------------------------
)


(;--------------------------- power-macros ---------------------------
 ;---------------------s-n p - global definition----------------------
 ;--------------------------------------------------------------------
	pm-def-macro
	'move-props-block
	'global [8388718 112]
	""
	"M-SPC M-; :END: RET M-x M-w M-: :END: RET M-k M-h M-v RET"
 ;--------------------------------------------------------------------
)


(;--------------------------- power-macros ---------------------------
 ;---------------------s-n n - global definition----------------------
 ;--------------------------------------------------------------------
	pm-def-macro
	'star-to-space2
	'global [8388718 110]
	"*** -> -"
	"M-SPC M-m M-5 * RET SPC RET ! M-l - SPC M-k M-h M-i M-SPC M-; - M-j M-c
 M-k M-h 2*M-w M-v M-h"
 ;--------------------------------------------------------------------
)


(;--------------------------- power-macros ---------------------------
 ;---------------------s-n S - global definition----------------------
 ;--------------------------------------------------------------------
	pm-def-macro
	'schedule-28
	'global [8388718 83]
	""
	"C-c C-s 2014-04-28 RET"
 ;--------------------------------------------------------------------
)

