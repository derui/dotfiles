#!/bin/bash

is_linux () {
    os=$(uname)

    echo $os | grep -nqi linux

    return $?
}

if [ \( -d "$HOME/.config" \) \( ! -L "$HOME/.config/awesome" \) -a is_linux ]; then
    ln -s $HOME/dotfiles/configurations/awesome $HOME/.config/awesome
fi
