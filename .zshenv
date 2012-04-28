path=($HOME/.npm/bin $HOME/.gem/ruby/1.9.1/bin $HOME/.cabal/bin $HOME/bin /usr/local/bin /usr/local/sbin \
    /usr/sbin /sbin \
    /bin /usr/local/bin /usr/bin \
    /usr/local/X11R6/bin /usr/X11R6/bin)

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export XMODIFIERS="@im=uim"
export SKKSERVER="localhost"
export COLORTERM=rxvt-256unicode
# export TERM=mlterm

# for w3m
export HTTP_HOME="http://duckduckgo.com/"

# エディタはすでに開かれているEmacsを利用する。
export GNUCLIENT=-F
export GNUDOITW=-F
export EDITOR="emacsclient"
export HREF_DATADIR="/usr/local/share/href"

export NODE_PATH=$HOME/.npm/lib:$PATH
export MANPATH=$HOME/.npm/man:$MANPATH

source $HOME/.zshrc
