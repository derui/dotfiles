export JAVA_HOME=/usr/lib/jvm/oracle-jdk-bin-1.7/
export ANDROID_SDK=$HOME/develop/android/android-sdk-linux
export ANDROID_SDK_HOME=$HOME/develop/android/android-sdk-linux

export GOROOT=$HOME/work/go
export GOPATH=$HOME/develop/go-workspace

OCAML_PATH=$(dirname `which ocamlc`)

path=($HOME/bin/Sencha/Cmd/5.0.0.160 $HOME/.cask/bin $GOROOT/bin $GOPATH/bin $OCAML_PATH $ANDROID_SDK/platform-tools $ANDROID_SDK/tools $HOME/perl/bin $HOME/local/bin $HOME/.npm/bin \
    /opt/VirtualBox \
    $HOME/.gem/ruby/2.0.0/bin $HOME/.cabal/bin $HOME/bin /usr/local/bin /usr/local/sbin \
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

export PERL_CPANM_OPT="--local-lib=~/perl"
export PERL5LIB="$HOME/perl/lib/perl5:$PERL5LIB"

if [[ -x `which opam` ]]; then
    # $MANPATH is overwrited by opam config..., so it back up and restore.
    PREV_MANPATH=$MANPATH
    eval `opam config env --root $HOME/.opam`
    export MANPATH=$MANPATH:$PREV_MANPATH
fi

source $HOME/.zshrc
