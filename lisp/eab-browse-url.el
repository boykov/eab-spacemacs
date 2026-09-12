;;; eab-browse-url.el --- eab browse-url configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package browse-url
  :config
  (setq browse-url-browser-function (quote eab/browse-url))
  (setq browse-url-firefox-program "/usr/local/bin/browser-remote")
  (defun eab/eaf-open-browser (url)
    (call-process-shell-command
     (concat "
ssh chronos docker exec -u 1000:1000 \
  -e HOME=/config \
  -e DBUS_SESSION_BUS_ADDRESS=unix:path=/tmp/dbus.base \
   firefox firefox --profile /config/profile " url)  nil 0)
    (if (get-buffer "Firefox")
        (switch-to-buffer-other-window "Firefox")
      (progn
        (eaf-open-browser "https://eaf-browser.eab.su"))))
  (defun eab/eaf-browser-paste-clip ()
    (interactive)
    (with-temp-file "/tmp/clip.txt"
      (insert (current-kill 0)))
    (call-process-shell-command
     "scp /tmp/clip.txt chronos:/docker/appdata/ff-tmp/clip.txt" nil 0)
    (call-process-shell-command
     (concat "
bash -c \"ssh chronos\" <<EOF
 docker exec firefox sh -c \"cat /tmp/clip.txt | xclip -selection clipboard; \
 sleep 0.1; xdotool key ctrl+v \"
EOF")
     nil 0))
  (defun eab/eaf-browser-ctrl-f ()
    (interactive)
    (call-process-shell-command
     (concat "
ssh chronos docker exec \
   firefox xdotool key ctrl+f")  nil 0))
  (defun eab/eaf-browser-ctrl-t ()
    (interactive)
    (call-process-shell-command
     (concat "
ssh chronos docker exec \
   firefox xdotool key ctrl+t")  nil 0))
  (defun eab/browse-url (url &optional arg)
    (interactive)
    (cond
     ((equal current-prefix-arg 2)
      (eaf-open-browser-other-window url))
     ((equal current-prefix-arg '(4))
      (browse-url-firefox url))
     ((not current-prefix-arg)
      (eab/eaf-open-browser url)
      )))
  (defun eab/browse-url0 (url &optional arg)
    (interactive)
    (if current-prefix-arg
        (browse-url-firefox url)
      (eab/eaf-open-browser url)))
  (defun google (phrase)
    "Search Google for a given phrase.
Prompts the user to enter a search query, defaulting to PHRASE if provided.
Opens the Google search results page for the entered query in the default web browser."
    (eab/browse-url0
     (concat
      "https://www.google.com/search?q="
      (url-hexify-string
       (read-string (if phrase
                        (format "Google (%s): " phrase)
                      "Google: ") nil nil phrase)))))
  (defun google-region ()
    (interactive)
    (let ((str (buffer-substring (region-beginning) (region-end))))
      (call-interactively 'mc/keyboard-quit)
      (google str))))
