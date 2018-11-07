# -*- mode:shell-script -*-
if [[ -x $(which java-config) ]]; then
  export JAVA_HOME=`java-config -O`
fi

export ANDROID_SDK=$HOME/develop/android/android-sdk-linux
export ANDROID_SDK_HOME=$HOME/develop/android/android-sdk-linux

export GOROOT=$HOME/work/go
export GOPATH=$HOME/develop/ghq
export GHQ_ROOT=$GOPATH/src

path=($HOME/.npm/bin $HOME/.nodebrew/current/bin $GOROOT/bin $GOPATH/bin $ANDROID_SDK/platform-tools $ANDROID_SDK/tools $HOME/local/bin \
    $HOME/.roswell/bin \
    $HOME/.cargo/bin \
    /opt/rust-bin-1.8.0/bin \
    /opt/VirtualBox \
    $HOME/.gem/ruby/2.1.0/bin $HOME/bin /usr/local/bin /usr/local/sbin \
    /usr/sbin /sbin \
    /bin /usr/local/bin /usr/bin \
    /usr/local/X11R6/bin /usr/X11R6/bin)

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export XMODIFIERS="@im=fcitx"
export COLORTERM=rxvt-256unicode

# エディタはすでに開かれているEmacsを利用する。
export GNUCLIENT=-F
export GNUDOITW=-F

if [[ -x $(which emacsclient) ]]; then
    export EDITOR="emacsclient"
else
    export EDITOR="vim"
fi

export NODE_PATH=$HOME/.npm/lib:$PATH
export MANPATH=$HOME/.npm/man:$MANPATH

export FZF_DEFAULT_OPTS='--no-sort --reverse --ansi --border --height 50%'

# Load opam config if it exists
if [[ -f ~/.opam/opam-init/init.zsh ]]; then
    source ~/.opam/opam-init/init.zsh
fi

# Enable cargo with rustup
if [[ -f ~/.cargo/env ]]; then
    source ~/.cargo/env
fi

if [[ -f ~/.virtualenv/bin/activate ]]; then
    source ~/.virtualenv/bin/activate
fi

if [[ -e "$HOME/.zshenv_local" ]]; then
    source $HOME/.zshenv_local
fi
