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

    mkdir -p $HOME/.config/dunst
    ln -s $HOME/dotfiles/dunstrc $HOME/.config/dunst/dunstrc

    rm -rf $HOME/.config/fish

    ln -s $HOME/dotfiles/fish $HOME/.config/fish

    mkdir -p $HOME/.config/alacritty/
    rm -f $HOME/.config/alacritty/*
    ln -s $HOME/dotfiles/alacritty.yml $HOME/.config/alacritty/alacritty.yml
fi

# bootstrap for virtualenv of python3 and powerline
if [[ ! -d ~/.virtualenv && -x `which python3` ]]; then
    python3 -m venv ~/.virtualenv
fi

bash -c "source ~/.virtualenv/bin/activate; pip install powerline-status"
rm -rf $HOME/.config/powerline

if [[ ! -L $HOME/.config/powerline ]]; then
    ln -s $HOME/dotfiles/powerline $HOME/.config/powerline
fi
