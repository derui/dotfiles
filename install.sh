#!/usr/bin/env bash

printf "[info ] Start installing dotfiles to $HOME.\n"

current=$(pwd)

configs=(alacritty fish hypr mako nvim sway tmux waybar git starship.toml)

for f in ${configs[@]}; do
    if [[ (( -e $XDG_CONFIG_HOME/$f )) || (( -L $XDG_CONFIG_HOME/$f ))]]; then
        printf "[warn ] Already extsts $f as Symbolic link.\n"
    else
        ln -s $current/config/$f $XDG_CONFIG_HOME/$f
    fi
done

if [[ (( -e $HOME/.npmrc )) || (( -L $HOME/.npmrc ))]]; then
    printf "[warn ] Already extsts $f as Symbolic link.\n"
else
    ln -s $current/npmrc $HOME/.npmrc
fi

if [[ (( -e $HOME/.ideavimrc )) || (( -L $HOME/.ideavimrc ))]]; then
    printf "[warn ] Already extsts $f as Symbolic link.\n"
else
    ln -s $current/ideavimrc $HOME/.ideavimrc
fi
