#!/bin/bash

is_linux () {
    os=$(uname)

    echo $os | grep -nqi linux

    return $?
}

if [ is_linux ]; then
    mkdir -p $HOME/.config/i3
    rm -f $HOME/.config/i3/config
    ln -s $HOME/dotfiles/i3 $HOME/.config/i3/config

    mkdir -p $HOME/.config/polybar
    rm -f $HOME/.config/polybar/*
    ln -s $HOME/dotfiles/polybar $HOME/.config/polybar/config
    ln -s $HOME/dotfiles/polybar-launch.sh $HOME/.config/polybar/launch.sh

    chmod +x $HOME/dotfiles/polybar-launch.sh

    rm -rf $HOME/.config/fish

    ln -s $HOME/dotfiles/fish $HOME/.config/fish
fi

# bootstrap for virtualenv of python3 and powerline
if [[ ! -d ~/.virtualenv && -x `which python3` ]]; then
    python3 -m venv ~/.virtualenv

    bash -c "~/.virtualenv/bin/activate; pip install powerline-status"
    rm -rf $HOME/.config/powerline
    mkdir -p $HOME/.config/powerline

    ln -s $HOME/dotfiles/powerline.config.json $HOME/.config/powerline/config.json

fi
