# -*- mode:shell-script -*-

# Emacs style key binding
bindkey -v

bindkey -M viins 'jj' vi-cmd-mode

# Add emacs-like keyvind to viins mode
bindkey -M viins '^F'    forward-char
bindkey -M viins '^B'    backward-char
bindkey -M viins '^P'    up-line-or-history
bindkey -M viins '^N'    down-line-or-history
bindkey -M viins '^A'    beginning-of-line
bindkey -M viins '^E'    end-of-line
bindkey -M viins '^K'    kill-line
bindkey -M viins '^Y'    yank
bindkey -M viins '^W'    backward-kill-word
bindkey -M viins '^U'    backward-kill-line
bindkey -M viins '^H'    backward-delete-char
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^G'    send-break
bindkey -M viins '^D'    delete-char-or-list

bindkey -M vicmd '^A'    beginning-of-line
bindkey -M vicmd '^E'    end-of-line
bindkey -M vicmd '^K'    kill-line
bindkey -M vicmd '^Y'    yank
bindkey -M vicmd '^W'    backward-kill-word
bindkey -M vicmd '^U'    backward-kill-line
bindkey -M vicmd '/'     vi-history-search-forward
bindkey -M vicmd '?' vi-history-search-backward

bindkey -M vicmd 'gg' beginning-of-line
bindkey -M vicmd 'G' end-of-line

# エディタでコマンドラインを編集できる。
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd "^O" edit-command-line
bindkey -M viins "^V" quoted-insert

# 履歴検索を有効にする。
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

bindkey -M vicmd 'j' history-substring-search-up
bindkey -M vicmd 'k' history-substring-search-down

autoload -U modify-current-argument
# Surround a forward word by single quote
_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey -M viins '^Q' _quote-previous-word-in-single

# Surround a forward word by double quote
_quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey -M viins '^Xq' _quote-previous-word-in-double

# pecoで検索する
function _peco-select-history() {

    BUFFER=$(history -nr 1 | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}

zle -N _peco-select-history
bindkey "^r" _peco-select-history

# 一つ上のディレクトリに上がる
# http://shakenbu.org/yanagi/d/?date=20120301
_cdup() {
    if [ -z "$BUFFER" ]; then
        echo
        cd ..
        zle reset-prompt
    else
        zle self-insert '^'
    fi
}
zle -N _cdup
bindkey '\^' _cdup

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
