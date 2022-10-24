(add-to-list 'org-publish-project-alist `("html-fz" :components ("html-fz-base")))
(add-to-list 'org-publish-project-alist
	     `("html-fz-base"
	       :base-directory "/home/eab/git/fz/tasks/sync-jira/fz-wiki/org"
	       :publishing-directory "/home/eab/git/eabmisc/boykov.github.io/fz-infra"
	       :online-suffix ".html"
	       :working-suffix ".org"
	       :section_numbers nil
	       :table-of-contents nil
	       :base-extension "org"
	       :publishing-function org-html-publish-to-html
	       :style-include-default t
	       :author-info nil
	       :creator-info nil))

(add-to-list 'org-publish-project-alist `("html-ldap" :components ("html-ldap-base" "html-ldap-static")))
(add-to-list 'org-publish-project-alist
	     `("html-ldap-base"
	       :base-directory "/home/eab/git/cc/cc-ldap-centos/docs"
	       :publishing-directory "/home/eab/git/eabmisc/boykov.github.io/ldap"
	       :online-suffix ".html"
	       :working-suffix ".org"
	       :section_numbers nil
	       :table-of-contents nil
	       :base-extension "org"
	       :publishing-function org-html-publish-to-html
	       :style-include-default t
	       :author-info nil
	       :creator-info nil))
(add-to-list 'org-publish-project-alist
	     `("html-ldap-static"
	       :base-directory "/home/eab/git/cc/cc-ldap-centos/docs/"
	       :base-extension "png"
	       :publishing-directory "/home/eab/git/eabmisc/boykov.github.io/ldap"
	       :recursive t
	       :publishing-function org-publish-attachment
	       ))

(add-to-list 'org-publish-project-alist `("manual" :components ("manual-base" "manual-static")))
(add-to-list 'org-publish-project-alist
	     `("manual-static"
	       :base-directory "/home/eab/git/eab-auto/org/"
	       :base-extension "png"
	       :publishing-directory "/home/eab/git/eabmisc/boykov.github.io/manual/"
	       :publishing-function org-publish-attachment
	       ))
(add-to-list 'org-publish-project-alist
	     `("manual-base"
	       :base-directory "/home/eab/git/eab-auto/org"
	       :publishing-directory "/home/eab/git/eabmisc/boykov.github.io/manual"
	       :online-suffix ".html"
	       :working-suffix ".org"
	       :section_numbers nil
	       :table-of-contents nil
	       :base-extension "org"
	       :publishing-function org-html-publish-to-html
	       :style-include-default t
	       :author-info nil
	       :creator-info nil))

;; Fix src blocks colors for org-publish-current-file
(if (eab/ondaemon (eab/server-P))
    (setq org-html-htmlize-output-type 'css))

(defun eab/org-publish-current-file ()
  (interactive)
  (let ((org-publish-use-timestamps-flag nil)
	(default-directory (concat (file-truename org-directory) "clock/")))
    (org-publish-file
     (file-truename (buffer-file-name (buffer-base-buffer)))
     nil)
    (shell-command
     (concat eab/ssh-host " <<'END'
sed -i 's/uid=/uid=1/' ~/git/eab-kb/js/pages/index.js
END"))))

(setq org-html-head-include-default-style nil)

(provide 'eab-org-publish)
