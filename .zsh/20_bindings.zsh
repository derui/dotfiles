# -*- mode:shell-script -*-

# Emacs style key binding
bindkey -e

# エディタでコマンドラインを編集できる。
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line
bindkey "^V" quoted-insert

# 履歴検索を有効にする。
# C-p 履歴の後方検索
# C-n 履歴の前方検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# pecoで検索する
function my-peco-select-history() {

    local tac
    if [[ $(which tac) > /dev/null ]]; then
        tac="tac"
    else
        tac="tail -r"
    fi

    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}

zle -N my-peco-select-history
bindkey "^r" my-peco-select-history

# 一つ上のディレクトリに上がる
# http://shakenbu.org/yanagi/d/?date=20120301
my-cdup() {
    if [ -z "$BUFFER" ]; then
        echo
        cd ..
        zle reset-prompt
    else
        zle self-insert '^'
    fi
}
zle -N my-cdup
bindkey '\^' my-cdup

# ディレクトリを移動する度にlsを実行する
chpwd() {
    my-ls-abbrev
}

# Enterでそのディレクトリの詳細を出す
# http://d.hatena.ne.jp/kei_q/20110406/1302091565
function my-show-ls-and-git() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    my-ls-abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb 2> /dev/null
    fi
    zle reset-prompt
    return 0
}
zle -N my-show-ls-and-git
bindkey '^m' my-show-ls-and-git

# ghqのソース一覧をpecoで閲覧する
function my-peco-ghq-src() {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}

zle -N my-peco-ghq-src
bindkey '^S' my-peco-ghq-src
