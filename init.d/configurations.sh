#!/bin/bash

is_linux () {
    os=$(uname)

    echo $os | grep -nqi linux

    return $?
}

if [ \( -d "$HOME/.config" \) -a  is_linux ]; then
    mkdir -p $HOME/.config/i3
    rm -f $HOME/.config/i3/config
    ln -s $HOME/dotfiles/i3 $HOME/.config/i3/config

    mkdir -p $HOME/.config/polybar
    rm -f $HOME/.config/polybar/*
    ln -s $HOME/dotfiles/polybar $HOME/.config/polybar/config
    ln -s $HOME/dotfiles/polybar-launch.sh $HOME/.config/polybar/launch.sh

    chmod +x $HOME/dotfiles/polybar-launch.sh
fi
