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

    mkdir -p $HOME/.config/sway
    rm -f $HOME/.config/sway/config
    ln -s $HOME/dotfiles/sway $HOME/.config/sway/config

    rm -f $HOME/.config/i3blocks
    ln -s $HOME/dotfiles/i3blocks $HOME/.config/i3blocks
    chmod a+x $HOME/dotfiles/i3blocks/scripts/*

    rm -f $HOME/.config/i3status
    ln -s $HOME/dotfiles/i3status $HOME/.config/i3status

    mkdir -p $HOME/.config/alacritty/
    rm -f $HOME/.config/alacritty/*
    ln -s $HOME/dotfiles/alacritty.yml $HOME/.config/alacritty/alacritty.yml

    mkdir -p $HOME/.config/kitty/
    rm -f $HOME/.config/kitty/*
    ln -s $HOME/dotfiles/kitty.conf $HOME/.config/kitty/kitty.conf

    mkdir -p $HOME/.config/picom/
    rm -f $HOME/.config/picom/picom.conf
    ln -s $HOME/dotfiles/picom.conf $HOME/.config/picom/picom.conf

    mkdir -p $HOME/.config/mako/
    rm -f $HOME/.config/mako/config
    ln -s $HOME/dotfiles/mako $HOME/.config/mako/config

    mkdir -p $HOME/.config/
    rm -f $HOME/.config/starship.toml
    ln -s $HOME/dotfiles/starship.toml $HOME/.config/starship.toml

    mkdir -p $HOME/.config/waybar
    rm -f $HOME/.config/waybar/config
    ln -s $HOME/dotfiles/waybar $HOME/.config/waybar/config
    rm -f $HOME/.config/waybar/style.css
    ln -s $HOME/dotfiles/waybar.style.css $HOME/.config/waybar/style.css

    mkdir -p $HOME/.config/wezterm/
    rm -f $HOME/.config/wezterm/*
    ln -s $HOME/dotfiles/wezterm.lua $HOME/.config/wezterm/wezterm.lua

    mkdir -p $HOME/.config/hypr/
    rm -f $HOME/.config/hypr/*
    ln -s $HOME/dotfiles/hyprland.conf $HOME/.config/hypr/hyprland.conf
fi

rm -rf $HOME/.config/fish
ln -s $HOME/dotfiles/fish $HOME/.config/fish

# bootstrap for virtualenv of python3 and powerline
if [[ ! -d ~/.virtualenv && -x `which python3` ]]; then
    python3 -m venv ~/.virtualenv
fi
