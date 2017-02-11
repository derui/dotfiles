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

add-zsh-hook preexec left_down_prompt_preexec
function zle-keymap-select zle-line-init zle-line-finish {
    case $KEYMAP in
        main|viins)
            PROMPT_MODE="%{$fg[cyan]%}I%{$reset_color%}"
            ;;
        vicmd)
            PROMPT_MODE="%{$fg[white]%}N%{$reset_color%}"
            ;;
        vivis|vivli)
            PROMPT_MODE="%{$fg[yellow]%}V%{$reset_color%}"
            ;;
        virep)
            PROMPT_MODE="%{$fg[red]%}R%{$reset_color%}"
            ;;
    esac
    build_prompts
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

function build_left_prompt() {
    echo -n "[$PROMPT_MODE] < "
}

# Right PROMPT
function build_right_prompt() {
    if has '__git_ps1'; then
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWSTASHSTATE=1
        export GIT_PS1_SHOWUNTRACKEDFILES=1
        export GIT_PS1_SHOWUPSTREAM="auto"
        export GIT_PS1_DESCRIBE_STYLE="branch"
        export GIT_PS1_SHOWCOLORHINTS=0
        local gitps
        gitps=`echo $(__git_ps1 "(%s)")|sed -e s/%/%%/|sed -e s/%%%/%%/|sed -e 's/\\$/\\\\$/'`
        echo -n "%{${fg[red]}%}${gitps}%{${reset_color}%}"
        echo -n "${p_buffer_stack}"
    fi
}

# Build whole prompt
function build_prompts() {
    PROMPT=$(build_left_prompt)
    RPROMPT=$(build_right_prompt)
}

# make prompts each side first
build_prompts

build_additional_prompts() {
    local preprompt_left="[%(?.%{${fg[green]}%}.%{${fg[red]}%})${HOST}%{${reset_color}%}] %{${fg[blue]}%}%~%{${reset_color}%}"
    local preprompt_right=""
    local invisible='%([BSUbfksu]|([FK]|){*})'
    local leftwidth=${#${(S%%)preprompt_left//$~invisible/}}
    local rightwidth=${#${(S%%)preprompt_right//$~invisible/}}
    local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth) % $COLUMNS))
    print -P $'\n'"$preprompt_left${(l:$num_filler_spaces:)}$preprompt_right"
}
add-zsh-hook precmd build_additional_prompts

# Other PROMPT
#
SPROMPT="%{${fg[red]}%}Did you mean?: %R -> %r [nyae]? %{${reset_color}%}"
