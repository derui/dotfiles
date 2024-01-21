#!/bin/bash

is_linux () {
    os=$(uname)

    echo $os | grep -nqi linux

    return $?
}

if [ is_linux ]; then
    mkdir -p $HOME/.local/share/applications
    rm -f $HOME/.local/share/applications/temp-emacsclient.desktop
    ln -s $HOME/dotfiles/init.d/applications/temp-emacsclient.desktop $HOME/.local/share/applications/temp-emacsclient.desktop
fi
