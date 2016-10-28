;; DONE Директория не должна быть та же!
(setq org-publish-project-alist
      `(("html-base"
	 :base-directory ,(concat org-directory "archive/")
	 :exclude "timeline.org"
	 :publishing-directory ,(concat eab/org-publish-directory "archive/")
	 :base-url ,(concat eab/org-publish-directory-file "archive/")
	 :working-directory ,(concat eab/org-publish-directory "archive/")
	 :online-suffix ".html"
	 :working-suffix ".org"
	 ;; :recursive t
	 :with-drawers ("CLOCK")
	 :section_numbers nil
	 :table-of-contents nil
	 :base-extension "org"
	 :publishing-function org-html-publish-to-html
	 :auto-sitemap t                ; Generate sitemap.org automagically...
	 :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
	 :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.

	 :style-include-default t
	 :author-info nil
	 :creator-info nil)
	("html-clock"
	 :base-directory ,(concat org-directory "clock/")
	 :exclude "timeline.org"
	 :publishing-directory ,(concat eab/org-publish-directory "clock/")
	 :base-url ,(concat eab/org-publish-directory-file "clock/")
	 :working-directory ,(concat eab/org-publish-directory "clock/")
	 :online-suffix ".html"
	 :working-suffix ".org"
	 :recursive t
	 :with-drawers ("CLOCK")
	 :section_numbers nil
	 :table-of-contents nil
	 :base-extension "org"
	 :publishing-function org-html-publish-to-html
	 :auto-sitemap nil                ; Generate sitemap.org automagically...
	 :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
	 :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.

	 :style-include-default t
	 :author-info nil
	 :creator-info nil)
	("html-nightly"
	 :base-directory ,(concat org-directory "gen/nightly/")
	 :publishing-directory ,(concat eab/org-publish-directory "gen/nightly/")
	 :base-url ,(concat eab/org-publish-directory-file "gen/nightly/")
	 :working-directory ,(concat eab/org-publish-directory "gen/nightly/")
	 :online-suffix ".html"
	 :working-suffix ".org"
	 :recursive t
	 :with-drawers ("CLOCK")
	 :section_numbers nil
	 :table-of-contents nil
	 :base-extension "org"
	 :publishing-function org-html-publish-to-html
	 :auto-sitemap t                ; Generate sitemap.org automagically...
	 :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
	 :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
	 :style-include-default t
	 :author-info nil
	 :creator-info nil)
	("html-gen"
	 :base-directory ,(concat org-directory "gen/")
	 :publishing-directory ,(concat eab/org-publish-directory "gen/")
	 :base-url ,(concat eab/org-publish-directory-file "gen/")
	 :working-directory ,(concat eab/org-publish-directory "gen/")
	 :online-suffix ".html"
	 :working-suffix ".org"
	 ;; :recursive t
	 :with-drawers ("CLOCK")
	 :section_numbers nil
	 :table-of-contents nil
	 :base-extension "org"
	 :publishing-function org-html-publish-to-html
	 :auto-sitemap t                ; Generate sitemap.org automagically...
	 :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
	 :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
	 :style-include-default t
	 :author-info nil
	 :creator-info nil)
	;; ("html-code"
	;;  :base-directory ,(concat org-directory "pubcode/")
	;;  :publishing-directory ,(concat eab/org-publish-directory "pubcode/")"
	;;  :base-url ,(concat eab/org-publish-directory-file "pubcode/")
	;;  :working-directory ,(concat eab/org-publish-directory "pubcode/")
	;;  :online-suffix ".html"
	;;  :working-suffix ".org"
	;;  :section_numbers nil
	;;  :table-of-contents nil
	;;  :base-extension "org"
	;;  :publishing-function org-html-publish-to-html
	;;  :auto-sitemap t                ; Generate sitemap.org automagically...
	;;  :sitemap-filename "sitemap-code.org"  ; ... call it sitemap.org (it's the default)...
	;;  :sitemap-title "Sitemap Code"         ; ... with title 'Sitemap'.
	;;  :style-include-default t
	;;  :author-info nil
	;;  :creator-info nil)
	("org-static"
	 :base-directory ,(concat org-directory "css/")
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	 :publishing-directory ,(concat eab/org-publish-directory "css")
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
;; TODO path: org-directory vs archive
	;; ("pdf"
	;;  :base-directory ,org-directory
	;;  :publishing-directory ,eab/org-publish-directory
	;;  :working-directory ,eab/org-publish-directory
	;;  :recursive t
	;;  :section_numbers nil
	;;  :table-of-contents nil
	;;  :base-extension "org"
	;;  :publishing-function org-latex-publish-to-pdf
	;;  :author-info nil
	;;  :creator-info nil)
	("html" :components ("html-base" "org-static"))
	("html-ldap-static"
	 :base-directory "/home/eab/git/cc/cc-ldap-centos/docs/"
	 :base-extension "png"
	 :publishing-directory "/home/eab/git/cc/boykov.github.io/ldap"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	("html-ldap-base"
	 :base-directory "/home/eab/git/cc/cc-ldap-centos/docs"
	 :publishing-directory "/home/eab/git/cc/boykov.github.io/ldap"
	 ;; :base-url ,(concat eab/org-publish-directory-file "archive/")
	 ;; :working-directory ,(concat eab/org-publish-directory "archive/")
	 :online-suffix ".html"
	 :working-suffix ".org"
	 ;; :recursive t
	 :section_numbers nil
	 :table-of-contents nil
	 :base-extension "org"
	 :publishing-function org-html-publish-to-html

	 :style-include-default t
	 :author-info nil
	 :creator-info nil)
	("html-ldap" :components ("html-ldap-base" "html-ldap-static"))))

(setq org-html-head-extra "
<style type=\"text/css\">
  pre.src:before {
    top: -5px;
  }
</style>
")

(provide 'eab-org-publish)
