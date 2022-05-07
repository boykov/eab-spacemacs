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

(setq org-html-head-extra "
<style type=\"text/css\">
  pre.src:before {
    top: -5px;
  }
</style>
")

(if (eab/ondaemon "serverP")
    (setq org-html-htmlize-output-type 'css))

(provide 'eab-org-publish)
