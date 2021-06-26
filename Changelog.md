# Changelog

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
Delete legacy `org` package (rename `org-bbdb` to `ol-bbdb`) and `org-clock-time%` function, its fixed in org-mode already.
Activate `eab/wg-save` on `desktop-save-hook` and `save-some-buffers` 15 sec idle for `serverP`.
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