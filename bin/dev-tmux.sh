#!/bin/bash

# in tmux session or not
if [[ ! -z "$TMUX" ]]; then
    exit 1
elif tmux has-session > /dev/null 2>&1 && [[ $(tmux list-sessions | wc -l) -ge 1 ]] ; then
    tmux attach
else
    tmux new-session -s "main" -d \; \
         new-window -n 'top' 'bpytop' \; \
         new-window -n 'dev' -c "~/develop/ghq/github.com/derui" \; \
         attach
fi
