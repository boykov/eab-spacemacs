(pm-def-macro
 'insert-clock
 'global "nc"
 "Insert <clock> at -"
 "C-l C-k M-; clock: RET 2*M-l M-SPC 2*M-m M-l M-c C-u C-SPC C-u C-SPC M-l SPC <
 M-v > M-; clock: RET M-; - SPC RET 2*M-j")

(pm-def-macro
 'dash-to-space3
 'global "n "
 "Replace \"-\" by \" \""
 "M-h M-SPC M-p M-5 - RET SPC RET ! M-h")

(pm-def-macro
 'delete-end-clock
 'global "nd"
 "delete block between :END: and next :CLOCK:"
 "ESC : :end RET ESC SPC ESC ; :cloc RET ESC k ESC h ESC X")

(pm-def-macro
 'org-note-align
 'global "na"
 "align org - <..> note"
 "C-l RET C-l L ESC ; > SPC")

(pm-def-macro
 'insert-paper-link
 nil nil
 ""
 "C-l C-k M-m M-n M-SPC M-m M-c M-n [[papers: M-m ][ M-v ]]")

(pm-def-macro
 'insert-showhide
 nil nil
 ""
 "RET M-i RET - SPC C-l C-k C-k hfpyjt SPC C-k hid TAB M-k M-h M-SPC M-C-o
 M-i r 2*SPC RET")

(pm-def-macro
 'mark-timeline
 nil nil
 ""
 "M-J C-l C-k M-; :timeline: RET m")


(pm-def-macro
 'org-align-list-item
 nil nil
 ""
 "C-M-S-u M-j M-h M-SPC M-; - RET M-j M-c M-p M-l M-SPC C-M-S-o r M-v 2*SPC
 RET M-SPC M-h M-X M-i 2*C-w")

(pm-def-macro
 'replace-dash
 nil nil
 ""
 "
 M-U
 M-SPC M-O M-5 C-x 8 <return> 2013 2*RET --- RET ! M-O M-U"
)

(pm-def-macro
 'replace-hid
 nil nil
 ""
 "C-l C-k M-SPC M-p M-X - SPC C-k hfpyjt SPC C-k hid TAB M-l M-SPC M-; end_sh RET
 M-h M-i r 2*SPC RET M-k M-h M-SPC 2*M-k M-X")

(pm-def-macro
 'replace-abstract
 nil nil
 ""
 "C-l C-k M-; _abstr RET M-h RET M-SPC M-k M-X M-; _abs RET M-h M-SPC M-k M-X M-w
 C-l L")

(pm-def-macro
 'narrow-note
 'global "nn"
 ""
 "C-l C-k C-SPC M-: - SPC <2026 RET M-h C-x n n M-L")
