# -*- mode:shell-script -*-

####################
# エイリアスの設定 #
####################
# 補完される前にオリジナルのコマンドまで展開してチェックする。
setopt complete_aliases

# エイリアス群
if [[ "`uname`" = "Linux" ]]; then
    alias ls="ls --color=always"
    alias lsn="ls --color=never"
    alias ll="ls -laF --color | less -R"
else
    alias ls="ls -G"
    alias ll="ls -lGaF | less -R"
fi

alias df="df -h"
alias e="emacsclient"

# 拡張子別の実行
alias -s mp3=mplayer
alias -s mp4=mplayer
alias -s flv=mplayer
alias -s avi=mplayer
