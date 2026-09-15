;;; eab-config-gptel-magit.el --- eab-config gptel magit configure -*- lexical-binding: t -*-
;;
;; Copyright (C) 2010-2026 Evgeny Boykov
;;
;; Author: artscan@list.ru
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(use-package gptel-magit
  :after (magit gptel)
  :config
  (setq gptel-magit-model 'qwen/qwen3-coder-next)
  (setq gptel-magit-commit-prompt
        "
You are an expert at writing Git commits. Your job is to write a short
clear commit message that summarizes the changes.

The commit message should be structured as follows:

    <type>(<optional scope>): <description>

    [optional body]

- Commits MUST be prefixed with a type, which consists of one of the
  followings words: build, chore, ci, docs, feat, fix, perf, refactor,
  style, test
- The type feat MUST be used when a commit adds a new feature
- The type fix MUST be used when a commit represents a bug fix
- An optional scope MAY be provided after a type. A scope is a phrase
  describing a section of the codebase enclosed in parenthesis, e.g.,
  fix(parser):
- A description MUST immediately follow the type/scope prefix. The
  description is a short description of the code changes, e.g., fix:
  array parsing issue when multiple spaces were contained in string.
- Try to limit the whole subject line to 60 characters
- Capitalize the subject line
- Do not end the subject line with any punctuation
- Use the imperative mood in the subject line
- Keep the body short and concise (omit it entirely if not useful)
- Strings mustn't be longer 80 symbols, do line breaks if longer.
" )
  (defun eab/gptel-magit-generate-message ()
    "Generate a commit message."
    (interactive)
    (gptel-magit--generate (lambda (message)
                             (with-current-buffer (current-buffer)
                               (save-excursion
                                 (insert message)))))
    (message "magit-gptel: Generating commit message..."))
  (defun gptel-magit--generate (callback)
    "Generate a commit message for current magit repo.
Invokes CALLBACK with the generated message when done."
    (let ((diff (magit-git-output "diff" "--cached" "HEAD^"))
          (gptel-tools nil)
          (gptel-use-tools nil))
      (gptel-magit--request diff
        :system gptel-magit-commit-prompt
        :context nil
        :callback `(lambda (response _info)
                     (let ((msg response))
                       (funcall ,callback msg)))))))