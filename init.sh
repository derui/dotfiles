#!/bin/zsh

autoload -Uz zmv

echo "Start installing dotfiles to $HOME."

current=$(pwd)

zmv -L -s "$(pwd)/dot.(*)" "$HOME/.\$1"

echo "Finish installing dotfiles to $HOME."
