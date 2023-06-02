# Changelog

### 0.2.3

Untabify all.
Fix `eab/ssh-host-local`.

### 0.2.2

Fix `helm` legacy browsers.
Improve `java-mode-map`.
Fix `init.el` old versions.
Add `eab/org-return`.
Use `eab/ssh-host-local` instead of `eab/ssh-host`.
Untabify `org-mode-map`.

### 0.2.1

Update emacs to `29.0.91`.
Fix spacemacs `defmethod`.
Fix ergoemacs `facemenu-menu`.
Fix flx-isearch `isearch-search-fun-function`.
Rm legacy `help-fns+`, `replace+`.
Fix `toggle-read-only`.

### 0.1.46

Fix `eab/helm-org-agenda-files-headings` with `eab/org-file`.
Switch `serverP`, `cyclos` to tcp.
Add external `serverP` to `eab/renew-agenda-files`.
Add `eab/eval-last-sexp-server-P`.
Fix `emacs-eat` with diminish `WK` again.
Improve `eab/renew-agenda-files` for all tcp.
Rewrite `eab/make-list-paths` via `dired-copy-filename-as-kill`.
Add `eab/helm-org-build-sources` with `nohelm` filter.

### 0.1.45

Add `eab/grep-switch-0`.
Fix org publish paths.
Add `eab/rsync-org-directory`, use it instead of `git pull`.
Add `eab/org-in-src-block-p`, improve `eab/clock-grep`,
`eab/ergoemacs-compact-uncompact-block` with `org-edit-special`.
Add `vacancy` case to `eab/org-publish-current-file`.
Try to switch grep by default: `eab/grep-setup-1` doesn't work.
Fix `eab/smex-limited-commands` with `delete-dups`.
Fix `emacs-eat` bug with diminished which-key unicode symbol.

### 0.1.44

Fix `ergoemacs-fix-arrow-keys` boot order.
Improve `clock.sh`.
Add `/scale`, `html-scale`.

### 0.1.43

Fix `eab/helm-hron-todo`, `eab-spacemacs/init-ergoemacs-mode`.
Improve `eab/helm-org-agenda-files-headings`.
Improve `eab/async-update-gr`.
Improve `eab/helm-hron-todo`.
Add `eab/org-forward-element-parent`.
Fix `:all-sources`, `0 vs 4`.
Rfct.

### 0.1.42

Add `helm-org`, init `eab/helm-hron-todo`,
`eab/helm-org-agenda-files-headings`.
Fix terminal arrow keys with `"M-O"        (make-sparse-keymap)`.
Add `eab/bury-buffer`.
Use `org-mode-fix` for `batch` (`noninteractive`).
Mv `eab-ace.el` to `packages.el`.

### 0.1.41

Fix `Save abbrevs in %s?`.
Rm deprecate `org-drawers`.
Improve `eab/grep-switch` with `string-trim` and negative lookhead.
Fix `emacs-eat` bad blue color.
Disable legacy `ansi-color-names-vector`.
Fix `eab/org-at-paragraph-item-p` empty line case.
Rfct. `eab/renew-agenda-files-1` postload.

### 0.1.40

Rfct. Mv part of `user-config` to `postload`.
Mv `eab/load-desktop`, `eab/test-dotemacs`.
Clear `dbus-launch` prompting, `Xorg` minibuffer.
Disable `eab/check-inet-path`.
Rm `eab/create-template`, use `eab/create-nightly` instead.

### 0.1.39

Fix `eab/org-shift-update-*` with `org-at-clock-log-p`.
Fix `org-align-list-item`.
Use `update-client.js` instead sed in `index.js`.
Disable `shell-history` due to `.bash_history` problem.
Init `eab/ergoemacs-compact-uncompact-block`.
Add `typescript-mode`, `kubernetes`.
Mv `eab/check-csum-day` to postload for serverC.
Rm legacy extra `(eab/ondaemon (eab/server-C))` cases.

Update `org-mode` to `9.6.1`, add previous `9.4.6` as `org-mode-fix`
for `serverC`. Disable `0.1.16` fix.

Rename `serverC` to `server-C`.

### 0.1.38

Add `org-transclusion`.
Fix and update `emacs-eat`.
Fix wrong order `:disabled name` -> `name :disabled`.

### 0.1.37

Update `eat` keymaps
Rm `eepitch-vterm-term`, use `kind` in `eab/run-ansi`, patch format.
Add `key-chord` hooks.

### 0.1.36

Add `eab/hron-update-current-time`, `eab/org-shift-update-2` with
`eab/org-shift-counter`.
Add `emacs-eat` and init keymaps.

### 0.1.35

Use `search-forward-regexp` empty or few spaces line and
`eechannel-send` in `eab/eepitch-paragraph`.
Add `org-align-list-item`.
Rfct `eab/wrap-eepitch-this`: do not use `eepitch-line`.
Add `C-M-,` keybinding for `eab/pm-write-last-kbd-macro`.
Fix extra `chronos` gr update.
Up to 2023 year.
Fix wrong syntax `:disabled t` -> `:disabled`.
Add keybindings for copy/paste `rectangle`.
Add `transient` map to `eab/hron-todo`.

### 0.1.34

Add `mark-timeline` and fix `eab/hron-todo`.
Improve `eab/gotify-status` with `websocket-openp` check.
Rename to `eab/gotify-websocket`.
Add `eab/check-gr-command`.
Reimplement `eab/eepitch-paragraph`.
Add `org-mark-paragraph`.

### 0.1.33

Add `disabled` features.
Add `eab/async-update-gr` to `eab/gr-status`.
Add `eab/gr-buffer`.
Add `racket-mode`.
Rfct and move `eab-auto-dictionary` to `packages.el`.
Delete `erc`.
Fix wrong remote tramp `default-directory` in `eab/sh-over-bash`.

### 0.1.32

Rfct.
Replace `if not` with `if` or `unless`.
Replace `progn` with `when`.
Fix `eab/hron-todo-bulk-hour 0` case.

### 0.1.31

Fix `eab/search-word` macro: use `arg` instead of `word`.
Rm `gnugol` related.
Use `eab/ssh-host-local` for `eab/gr-command`.
Fix sort `multi-character tab $:` on remote tramp.
Add `eab/update-gr-status-on-idle`.
Improve `eab/hron-todo` with `eab/org-parse-current-time` and `eab/hron-set-current`.

### 0.1.30

Fix ssh remote command extra greeting message.
Fix `default-input-method` after `set-input-method`.
Try to fix `keepass.sh` with `2>/dev/null`, see auto.
Disable `flx-ido-mode`.
Fix `eab/org-ql-view-refresh` position: replace `point` with `line/column`.

### 0.1.29

Fix `eab/eval-last-sexp-serverN` message.
Don't comment `eab/gotify-token` check.
Add `ido-better-flex`.
Use `(set-input-method nil)` for `C-l C-k`.
Add `insert-showhide` pm macro.

TODO serverC eab/gotify-token is defined unstable.

### 0.1.28

Fix `magit-libgit` missed package.
Improve `showhide` snippet.
Add `insert-paper-link` pmacro.
Add `eab/browse-paper-at-point`.
Add `csum-hours`, `csum-file-hours`, `eab/org-parse-current-time`.

### 0.1.27

Convert `eab/total-minutes` to defun.
Fix extra no-cache `eab/org-publish-current-file` parameter.
Set `serverP` remote `eab/org-publish-directory`.
Add MVP `index.js` to `eab/org-publish-current-file`,
use `next.js` app in `eab/open-heading-browser`.
Move `org-html-style-default` to `org-html-themes`.
Fix `org-level-*` font size.
Add `eab/browse-paper`.

### 0.1.26

Fix `org-html-section` ID, `dired-async-create-files` patch.
Add `eab/org-ql-query-buffer`, `eab/org-ql-select-md5`,
`eab/org-ql-select-hash` and `eab/update-query-on-idle`.
Improve `eab/org-ql-switch`.
Add `eab/org-publish-current-file`, `org-directory` true path.

### 0.1.25

Fix `org-clocktable-write-default` for fz month reports.
Improve `eab/patch-this-code`: add `:native`, `:lexical` and `rpairs`.
Convert functions from `eab-org-extension` to patched.
Add `eab-lisp` with "Let Over Lambda" `dlambda`.

### 0.1.24

Rfct `org-directory`. Set `/home/eab/pnt/jaguar/git/org/` for `serverC`.

### 0.1.23

Fix `eab/paper-link` nil case.
Improve `org-html-statistics-cookie`.
Add `revert-all-buffers`, replace `auto-revert-buffers` by it.

### 0.1.22

Add `eab/ssh-host-local` for `ssh cyclos/chronos`.
Add serverC tcp socket.
Use `serverC-use-tcp` for all `server-eval-at` serverC.
Fix `source-directory`.

### 0.1.21

Use `keepass.sh`.
Add `diff-hl`.

### 0.1.20

Use `s-k` binding for ubuntu 22.04 layout changing.
Add `batch-publish` sleep delay.

### 0.1.19

Add `cyclos` daemon.

### 0.1.18

Add `prettier`.

### 0.1.17

Add `highlight-indentation`.

### 0.1.16

Add `julia-mode`.
Fix `ergoemacs-compact-uncompact-block` for `org-mode`.

### 0.1.15

Fix `eab/patch-this-code` with `overriding-terminal-local-map`.
Rfct. rm extra git/auto entries.

### 0.1.14

Mv `wg` to `eab-system`.
Fix `daemons` :init.

### 0.1.13

Fix missed `magit-status`.
Add `daemons`.
Add `eab/ssh-host`.
Add `eab/gotify` message empty arguments and `finished`.

How to override DISPLAY? See `browse-url` example `(copy-sequence
process-environment)` and `(setenv "DISPLAY" ..)` or just do `sudo sed
-i "s/\$DISPLAY/:0/" /usr/local/bin/browser-remote` manually.

### 0.1.12

Fix `system-time-locale`: serverC `english` vs `russian` published timestamps.
Fix `magit` package wrong initialization.
Fix `eab/open-corresponding-html`.

### 0.1.11

Force `eab/org-ql-view-refresh` on `switch-to-buffer`.
Add `eab/org-ql-*` funcs.
Add `magit-insert-modules`.

### 0.1.10

Fix wrong `bad csum` event.
Fix `eab/send-csum-all` dependency from `serverP`.
Add `microcyclos` emacs `serverP` type.

### 0.1.9

Add `(eab/server-*)` functions.
Disabe `git stash` in `eab/batch-publish`.
Update `ergoemacs-mode`, fix `ergoemacs-move-cursor-next-pane`.
Fix `serverC` org files in `fundamental-mode`.
Rm legacy `html-nightly`.

### 0.1.8

Fix `eab/wg-create-workgroup`.
Improve `eab/delete-nightly`.

Disable `pnt/jaguar/` fixing.

### 0.1.7

Fix `~/bin/gr`.
Add `transient-history-file`, `recentf`, `custom` to `setq-put`.
Always `desktop-save`.

Update `eab-workgroups2`:
* Start from `blank` workgroup
* Move `:` to link names
* Use `file` or `directory` for targets

Use `org-chronos` for `serverP`.
Fix workgroup paths `~/pnt/jaguar/git` -> `~/git`.

Fix `eab/batch-publish` for "first-running" case.

### 0.1.6

Add `file-directory-p` check for `eab/create-workgroups`.

### 0.1.5

Do not remove timestamps in `nightly`.
Mv `template plot` to `nightly`.
Add optional `fast` parameter for `eab/batch-publish`.
Rfct. `if progn` -> `when`.

### 0.1.4

Add "Source Code Pro" font, set `height`.
Add `fix-esup.patch`.
Add `batch-publish` hotkey.
Add `eab/gr-ready?`.
Init `eab/helm-find-file-or-marked` wrapper.
Use `plocate`.

### 0.1.3

Mv `pre.src:before` to `org-html-themes`.
Fix `clocksum-28` org-mode again: add missed `yasnippet`, `org`.
Fix `smart-compile` annoying `Makefile`.
Fix `eab/wg-switch-to-workgroup-history`:

    Error in post-command-hook (ido-exhibit): (void-variable ido-directory-nonreadable)

### 0.1.2

Update `eab-avy`.
Add `eab/websocket` for `eab/gotify-status` (use gotify instead of `sauron`).
Add `eab/xdg-open`. Fix `eab/helm-select-action`.
Fix `magit-section-visibility-indicator`.
Refactor `eab/gr-status`, add config commands.

Delete:

* sauron
* twittering-mode
* eab-twit
* eab-sudo
* eab-lexical

### 0.1.1

Switch to `master` branch.
Fix missed `eab-dired`: disable `:defer` for `eab-tramp`.

### 0.0.30

Mv `spacemacs` to `eab-spacemacs/local/`.
Fix `clocksum-28` org-mode.
Rm legacy `eab-org-mode`, `Makefile`.
Add `eab-spacemacs-path` in `eab-spacemacs/local/spacemacs/init.el`.
Add `eab/load-desktop`.
Update `readme`.

### 0.0.29

Disable `eab/yasnippets-path`, `eab-gnus`, `python-mode`, `org-redmine`.
Disable `25`, `26.1` emacs version check.
Refactoring `eab/singularity`, `eab-auto-complete`, `eab/create-workgroups`.
Add lexical binding for `eab-auto-complete`, `eab-gnus`.
Apply `use-package` with `:init` instead of `require`.
Add emacs daemon restart hotkey.

### 0.0.28

Add `eab/emacs-service-alist`, fix `eab/history-dir`.
Add `systemctl restart` + `desktop-save` for instances.
Enable `desktop-read`.
Fix `define-obsolete-function-alias` for `bbdb`.
Fix `eab/wg-create-workgroup`: check already existed group and add all
groups to history.
Fix `yas-org-very-safe-expand`.

### 0.0.27

Add `neveragenda` tag.
Rm legacy unused `eab/save-W`, `eab/update-agenda`, `org-agenda-custom-commands`.
Mv settings to `:init` for `eab-org-agenda`.
Fix `sign` in `eab/org-clock`.
Improve `eab/org-ql-*-query` buffer names.
Ripgrep: add `-M` limit.
Fix `eab/find-grep`, `eab/clock-grep` `eab/grep` cursor positions.
Add `esup` package.
Add `eab/org-ql-view-refresh` without buffer renaming.

### 0.0.26

Set `source-directory`.
Improve `eab/grep-sort` add `LC_ALL=C`, `eab/grep-clock-left`.
Add `eab/gotify-status`.
Refactoring `org-publish-project-alist` using `add-to-list`.
Fix `org-agenda-buffer-name` again: extra `defadvice` for
`eab/fix-agenda-buffer-name`.

### 0.0.25

Improve `eab/grep`:
 
* refactoring `eab/grep`: add various vars and defun;
* implement `rg` over `git ls-files` with `xargs`;

Improve `eab/grep-switch`, `eab-misc/git-wip`.
Fix and improve `eab/with-git-toplevel`: enable directory without git.
Patch `workgroups2` and `org-sql`: use `eval-and-compile` for `defconst`.
Disable `org-crypt-use-before-save-magic`.
Ignore `*.elc`.

### 0.0.24

Rename `Custom_ID` by `Custom_BIB`.
Add `eab/gotify`.
Setup `svg` publishing for `src dot`: patch `org-html--format-image`.

### 0.0.23

Disable `org-roam`, `sauron-fx-mplayer`.
Use `locate`, `test-dotemacs`, `gr status` over `ssh`.
Init `org-html--format-image` from `ox-html.el`.

### 0.0.22

Convert hardcoded var `eab/wg-update-list` to defun `eab/wg-update-list-1`.
Move `eab/wg-path` to `~/git/org`.
Fix `eab/wg-create-workgroup`: path and `wg-save-session` for predefined wg configs.
Improve keybinds `eab/wg-switch-to-workgroup`.
Add `eab/first-emacsclient`.
Disable `indent-tabs-mode` for org.

### 0.0.21

Move `eab/update-agenda`.
Rm `NOTCH`. Use `html` checkbox.
Add `sho` yas, `org-special-block-extras`.
Fix `M-g` keybind.

### 0.0.20

Add `wvxvw/export-rel-url` for `rel:` org link-type. Add `csum-file-percent`.
Disable `gnus`, `eab/secrets-path` loading, `eab/check-smtp`.
For `eab/batch-publish` add `git pull` before remote csum.
Move `boykov.github.io`.
Disable `org-static`, leave `html-base` only.
Reimplement eab-org-protocol `eab/open-heading-browser` defun.

### 0.0.19

Fix `org-agenda-buffer-name` again (add switch-to-buffer).
Disable extra `solarized-light` theme.
Up to 2022 year. Add `browser-remote`.
Fix `bbdb` define-obsolete functions and update `dired+` (and roll
back `dired-buffers-for-dir` after) up to version `2021.10.03` for
emacs 28.0.90.


### 0.0.18

Fix `papers:`, `org-babel-temporary-directory`.
Fix `forge`, `bug-reference-auto-setup-functions`.
Fix `set-input-method` accidentally pressed hotkey.
Fix `org-ql-search` `org-link-parameters`, `org-agenda-buffer-name`.
Add `abs`, `csum-percent`, `eab/org-ql-O-query`. Use `so-long`.

### 0.0.17

Fix `rg` + `git ls-files`: add `--max-depth 0`.
Add `helm tramp .bash_history` examples.
Commit eab org-ql.
Add `pin` org snippet (`yas-reload-all`).
Rm legacy `mercury`, `jupiter` org publish projects.
Fix `eab/wg-switch-to-workgroup-history-1` (ido-context-switch-command) again:
dynamic binding (`defvar`) for `ido-choice-list`.

### 0.0.16

Native compile `workgroup2`, `eab-workgroups2` (add lexical).
Disable `eab/org-agenda-to-appt`. Add `eab-test.el`.
Improve `org-ql-search` keybindings.
Disable `eab/org-agenda-to-appt`.
Add `ob-tmux`. Update projectile and improve keybindings.
Fix `eab/wg-switch-to-workgroup-history-1` (ido-context-switch-command).

### 0.0.15

Add `org-ql` and related. Fix `clock/timeline-time-arch.org`.
Add `org-ql-search` keybinding.

### 0.0.14

Replace `org-plus-contrib` by local `org-mode`. Delete `org-checklist`.
Fix `ox-extra`.

### 0.0.13

Add `git pull` before remote csum. Fix eab-emacs 25 for `magit`.
Fix gpg (see .gnupg/gpg.conf).
Start `lisp/eab-lexical.el`.

### 0.0.12

Bypass `org-roam` for emacs25. Improve `vc-annotate`.

### 0.0.11

Reorder. Merge `eab-ui-minimal`, `eab-postload-minimal` into `eab-ui`, `eab-postload`.

### 0.0.10

Move `eab-miniframe`. Reorder.

Built-in location:

* gnus
* tramp
* outline
* compile
* window
* desktop
* server
* grep
* ido
* dired
* ace

Fix `ido-completing-read-silent`, `cl-assert` test.

### 0.0.9

Move `eab-misc`. Extract `eab-tramp`. Delete `eab-depend-minimal`.
Increase `which-key-idle-delay`.

### 0.0.8

Update:

* magit
* libgit
* forge

Fix ~Compiled in Emacs version 28.0.50~ magit for emacs 25.
Merge `eab-find-func` into `eab-workflow`.

Move:

* power-macros

### 0.0.7

Fix term-mode `input-method-function`.
Add `M-r` term-raw-map backward pitch.
Add `cl-assert` statement.
Restore `org-clock-time%` function.

Move:

* god-mod
* dictionary
* auto-dictionary
* auto-complete + ac-dabbrev with `:after`
* org-agenda-property
* ebib
* keyfreq
* achievements
* key-chord
* edit-list

Do not load full ergoemacs-mode.
Try `:after` for org-link-minor-mode.

Disable:

* org-grep (see eab/clock-grep)

### 0.0.6

Cleanup server list. Remove unused ea2b, ghost.
Finally remove `serverN`, use `serverC` instead.
Delete legacy `org` package (rename `org-bbdb` to `ol-bbdb`)
and `org-clock-time%` function, its fixed in org-mode already.
Activate `eab/wg-save` on `desktop-save-hook` 
and `save-some-buffers` 15 sec idle for `serverP`.
Fix `projectile-known-projects-file`.
Fix `org-link-minor-mode` order.
Reorder bbdb, other packages, eab-misc.
Delete legacy keepass, w3m.

### 0.0.5

Reorder. Disable:

* logstash-conf
* csv-mode
* ldap-mode
* php-mode

Move `eab/patch-this-code` to beginning (config.el). 

### 0.0.4

Reorder:

* twittering-mode + eab-twit
* workgroup2 + eab-workgroups2
* etags-select, etags-table + eab-tags
* eev-current + eab-eepitch
* helm, helm-descbinds, helm-helm-commands + eab-helm
* smex + eab-smex

Disable:

* eab-sudo

### 0.0.3

Reorder, disable unused: 

* eab/insert-greek
* ignoramus
* pallet
* cask
* kv
* fakir
* elnode
* creole
* minimap
* jira
* deferred
* bm
* browse-kill-ring
* db
* python-environment
* fuzzy
* fuzzy-match
* jedi
* jedi-core
* epc
* concurrent
* ctable
* shut-up
* take-off
* web-server
* websocket
* connection
* xml-rpc
* web
* pcache
* noflet
* ibuffer-vc
* el-x
* package-build
* fancy-narrow
* link
* popup

### 0.0.2

Delete:

* eab-packages
* el-get

Reorder git-related packages.

### 0.0.1

Delete dependencies:

* pymacs
* anything
* wmctrl
* eab-send-string
* eab/ido-firefox-urls
* moz