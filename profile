#!/bin/bash
# -*- mode: sh -*-
#
export GOPATH=$HOME/develop/ghq

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# environment variables for X11/wayland
export XMODIFIERS="@im=fcitx"
# export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"

# Avoid blank screen of AWT-based application on Wayland
export _JAVA_AWT_WM_NONREPARENTING=1

if [ ! -d "$XDG_RUNTIME_DIR" ]; then
    mkdir -p $XDG_RUNTIME_DIR
    chmod 0700 $XDG_RUNTIME_DIR
fi

# use openjdk in gentoo
if [ -d "/usr/lib64/openjdk-11" ]; then
    export JAVA_HOME=/usr/lib64/openjdk-11
elif [ -x java-config ]; then
    export JAVA_HOME=`java-config -O`
fi

if [ -x dbus-daemon ]; then
    dbus-daemon --session --address=unix:path=$XDG_RUNTIME_DIR/bus
fi

export PATH=$HOME/.local/bin:$HOME/.volta/bin:$JAVA_HOME/bin:$HOME/.npm/bin:$HOME/.asdf/bin:$HOME/.asdf/shims:$GOPATH/bin:$HOME/.roswell/bin:$HOME/.cargo/bin:/opt/VirtualBox:$HOME/bin:$PATH

if [ -f "$HOME/.opam/opam-init/init.sh" ]; then
    . $HOME/.opam/opam-init/init.sh
fi

if [ -f "$HOME/.secrets/bash" ]; then
    source $HOME/.secrets/bash
fi

# WSL_DISTRO_NAMEにDistributionの名前が入っているので、これが設定されていたらWSLの内部と判断する
if [ "$WSL_DISTRO_NAME" != "" ]; then
    #cd '/mnt/c/Program Files/VcXsrv'

    #export DISPLAY=127.0.0.1:0.0
    #WSLENV=DISPLAY ./xhost.exe + $(ip -4 a show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

    #export DISPLAY=$(awk '/^nameserver/ {print $2; exit}' /etc/resolv.conf):0.0
    export LIBGL_ALWAYS_INDIRECT=1
fi

export WLR_DRM_NO_MODIFIERS=1
