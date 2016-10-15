# -*- mode:shell-script -*-

# プロンプトのカラー表示を有効
autoload -U colors
colors

export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1

# プロンプト設定
# PROMPT
#
terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
left_down_prompt_preexec() {
    print -rn -- $terminfo[el]
}

PROMPT="%{$terminfo_down_sc$PROMPT_2$terminfo[rc]%}[%(?.%{${fg[green]}%}.%{${fg[red]}%})${HOST}%{${reset_color}%}]%# "

# Right PROMPT
#

r-prompt() {
    if has '__git_ps1'; then
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWSTASHSTATE=1
        export GIT_PS1_SHOWUNTRACKEDFILES=1
        export GIT_PS1_SHOWUPSTREAM="auto"
        export GIT_PS1_DESCRIBE_STYLE="branch"
        export GIT_PS1_SHOWCOLORHINTS=0
        local gitps
        gitps=`echo $(__git_ps1 "(%s)")|sed -e s/%/%%/|sed -e s/%%%/%%/|sed -e 's/\\$/\\\\$/'`
        RPROMPT="%{${fg[red]}%}${gitps}%{${reset_color}%}"
        RPROMPT+=" at %{${fg[blue]}%}[%~]%{${reset_color}%}"
        RPROMPT+="${p_buffer_stack}"
    else
        RPROMPT="[%{$fg[blue]%}%~%{$reset_color%}]"
    fi
}
add-zsh-hook precmd r-prompt

# Other PROMPT
#
SPROMPT="%{${fg[red]}%}Did you mean?: %R -> %r [nyae]? %{${reset_color}%}"
