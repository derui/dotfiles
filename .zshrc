
# Emacs style key binding
bindkey -e

# Emacsから利用するときは、zleを停止する。
[[ $EMACS = t ]] && unsetopt zle

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

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_all_dups

# ディレクトリ名だけで移動できるように
setopt auto_cd

# 自動的にpushdを実行するようになる。cd -[TAB]で移動履歴が出る。
setopt auto_pushd

# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_ignore_dups

# 自動的に末尾のslashを取り除く。
setopt auto_remove_slash

setopt print_eight_bit
# Ctrl+Q や Ctrl+Sによるフロー制御を行わないようにする
setopt no_flow_control

# 改行の無い出力をプロンプトで上書きするのを防ぐ
setopt no_prompt_cr

# glob展開時に大文字小文字を無視
setopt no_case_glob

# 右プロンプトに入力がきたら消す
setopt transient_rprompt

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

bindkey "^V" quoted-insert

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

# 各種設定のまとめ
source ~/.zsh/common.zsh
bindkey "^r" peco-select-history

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
# http://d.hatena.ne.jp/kei_q/20110406/1302091565
function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb 2> /dev/null
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

function peco-src() {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi 
    zle clear-screen
}

zle -N peco-src
bindkey '^S' peco-src

# themeを設定する
# emacsから起動されるときは、余計な情報は表示しないようにする
if [ -z "$EMACS" ]; then
    ZSH_THEME='yonchu'

# Remove any right prompt from display when accepting a command line.
# This may be useful with terminals with other cut/paste methods.
#setopt transient_rprompt

# Certain escape sequences may be recognised in the prompt string.
# e.g. Environmental variables $WINDOW
    setopt prompt_subst

# Certain escape sequences that start with `%' are expanded.
#setopt prompt_percent

    if [ ${UID} -eq 0 ]; then
    # Prompt for "root" user (all red characters).
    # Note: su - or sudo -s を行った場合は環境変数が引き継がれない
        PROMPT="${reset_color}${fg[red]}[%n@%m:%~]%#${reset_color} "
        PROMPT2="${reset_color}${fg[red]}%_>${reset_color} "
        SPROMPT="${reset_color}${fg[red]}%r is correct? [n,y,a,e]:${reset_color} "
    else
    # Prompt for "normal" user.
    # Loading theme
        if [ -f ~/.zsh/themes/"$ZSH_THEME".zsh-theme ]; then
            echo "Loading theme: $ZSH_THEME"
            source ~/.zsh/themes/"$ZSH_THEME".zsh-theme
        else
            echo "Error: could not load the theme '$ZSH_THEME'"
        fi
    fi
# }}}

### Source configuration files {{{
#
# pluginの読み込み
#
    if [ -d ~/.zsh/modules ]; then
        for plugin in ~/.zsh/modules/*.zsh; do
            if [ -f "$plugin" ]; then
                echo "Loading plugin: ${plugin##*/}"
                source "$plugin"
            fi
        done
    fi

fi
