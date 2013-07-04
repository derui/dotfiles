# Emacs style key binding
bindkey -e

# Emacsから利用するときは、zleを停止する。
[[ $EMACS = t ]] && unsetopt zle

setopt transient_rprompt                    # 右プロンプトに入力がきたら消す

# 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

# 履歴検索を有効にする。
# C-p 履歴の後方検索
# C-n 履歴の前方検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^N' history-incremental-pattern-search-froward

# プロンプトのカラー表示を有効
autoload -U colors
colors

export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1

# shellの単語分割を無効にする
unsetopt sh_wordsplit

# --prefix=/usrなどの時にも補完を有効にする。
setopt magic_equal_subst

# 先頭がスペースならヒストリーに追加しない。
setopt hist_ignore_space

# ベルを鳴らさない。
setopt no_beep

# 補完時にヒストリを自動的に展開する。
setopt hist_expand

# ディレクトリ名だけで移動できる。
setopt auto_cd

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_all_dups

# 自動的にpushdを実行するようになる。cd -[TAB]で移動履歴が出る。
setopt auto_pushd

# 自動的に末尾のslashを取り除く。
setopt auto_remove_slash

# エディタでコマンドラインを編集できる。
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line

# 編集中のコマンドの内容を履歴に登録する。
# M-RETなどで実行する。
fake-accept () {
    print -s "$BUFFER"
    print "
[added to history]"
    zle send-break
}
zle -N fake-accept
bindkey "^[m" fake-accept

# 手軽にzshのヘルプ機能に登録できる。
# install-zshhelp ls --help
# のように利用する。
autoload run-help
HELPDIR=~/.zsh/help

install-zshhelp () {
    local dest=$HELPDIR/`basename "$1"`
    "$@" >& $dest
}

bindkey "^Q" quoted-insert

###############################
# zle以外のユーティリティ関数 #
###############################
psgrep () {
    [[ -n "$1" ]] && ps aux | grep $1
}

cabal-haddock () {
    local CABALMODULES=$1
    cabal hscolour $CABALMODULES
    cabal haddock "--haddock-options=--source-base=src/ --source-module=src/%{MODULE
/./-}.html --source-entity=src/%{MODULE/./-}.html#%N" $CABALMODULES
}

##############
# 雑多な設定 #
##############
setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
setopt no_checkjobs          # ログアウト時にバックグラウンドジョブを確認しない
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる

####################
# エイリアスの設定 #
####################
# 補完される前にオリジナルのコマンドまで展開してチェックする。
setopt complete_aliases

# エイリアス群
if [[ "`uname`" = "Linux" ]]; then
    alias ls="ls --color=always"
    alias lsn="ls --color=never"
    alias ll="ls -laF --color | lv -c"
else
    alias ls="ls -G"
    alias ll="ls -lGaF | lv -c"
fi
alias df="df -h"

alias asdf="xmodmap ~/.dvorak"
alias aoeu="xmodmap ~/.qwerty"

# 拡張子別の実行
alias -s mp3=mplayer
alias -s mp4=mplayer
alias -s flv=mplayer
alias -s avi=mplayer

# ゴミ箱が利用できる場合にはrmをゴミ箱として利用できるようにする。
if `which trash-put &>/dev/null` ; then
    alias rm=trash-put
fi

# 各種設定のまとめ
source ~/.zsh/common.zsh

if [[ -z "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    # local shell
    PROMPT="%U%{${fg[green]}%}[%n@%m]%{${reset_color}%}%u(%j) %~
%# "
else
    # remote shell
    PROMPT="%U%{${fg[red]}%}[%n@%m]%{${reset_color}%}%u(%j) %~
%# "
fi

# loading `autojump' if it exists
if [ -e $HOME/local/etc/profile.d/autojump.zsh ]; then
    source $HOME/local/etc/profile.d/autojump.zsh
fi
fpath=($fpath $HOME/local/functions(N))

# zaw
source ${HOME}/.zsh/modules/zaw/zaw.zsh

# ^でcd ..する
# http://shakenbu.org/yanagi/d/?date=20120301
cdup() {
    if [ -z "$BUFFER" ]; then
echo
cd ..
        if type precmd > /dev/null 2>&1; then
precmd
        fi
local precmd_func
        for precmd_func in $precmd_functions; do
            $precmd_func
        done
zle reset-prompt
    else
zle self-insert '^'
    fi
}
zle -N cdup
bindkey '\^' cdup

# ディレクトリを移動する度にlsを実行する
chpwd() {
    ls_abbrev
}
ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-aCF' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-aCFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

# enterでls と git statusを実行するように
function do_enter() {
    zle accept-line
    if [ -z "$BUFFER" ]; then
        echo ''
        ls_abbrev
        if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
            echo -e "\e[0;33m--- git status ---\e[0m"
            git status -sb
        fi
    fi
}
zle -N do_enter
bindkey '^m' do_enter
