ssh -t chronos "
   docker run --rm -it  \
     -v /home/eab/claude:/home/eab/claude \
     -v /home/eab/.claude:/home/eab/.claude \
     -v /home/eab/.claude-code-router:/home/eab/.claude-code-router \
     -v /mnt/fox/git/eab-spacemacs:/home/eab/claude/eab-spacemacs \
     -v /mnt/fox/git/eab-system/.git/modules/eab-spacemacs:/home/eab/claude/.git/modules/eab-spacemacs \
     hub.eab.su/lib/utils:0.0.3 claude $*
"
