#!/bin/bash

function is_linux {
    local os
    os=$(uname)

    echo $os | grep -nqi linux

    if [ $? -ne 0 ]; then
        return 0
    fi

    return 1
}

if [ ( ! -d "$HOME/.config" ) -a is_linux ]; then
    ln -s $HOME/dotfiles/configurations/awesome $HOME/.config/awesome
fi
