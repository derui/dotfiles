#!/bin/bash

is_linux () {
    os=$(uname)

    echo $os | grep -nqi linux

    return $?
}

if [ is_linux ]; then
    mkdir -p $HOME/.config/share/applications
    rm -f $HOME/.config/share/applications/temp-emacsclient.desktop
    ln -s $HOME/dotfiles/init.d/applications/temp-emacsclient.desktop $HOME/.config/share/applications/temp-emacsclient.desktop
fi
