#!/usr/bin/env bash

printf "[info ] Start installing dotfiles to $HOME.\n"

current=$(pwd)

configs=(alacritty fish hypr mako nvim sway tmux waybar git xkb starship.toml)

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

if [[ (( -e $HOME/.bash_profile )) || (( -L $HOME/.bash_profile ))]]; then
    printf "[warn ] Already extsts $f as Symbolic link.\n"
else
    ln -s $current/bash_profile $HOME/.bash_profile
fi

if [[ (( -e $HOME/.profile )) || (( -L $HOME/.profile ))]]; then
    printf "[warn ] Already extsts profile as Symbolic link.\n"
else
    ln -s $current/profile $HOME/.profile
fi
