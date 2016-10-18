#!/bin/zsh

autoload -Uz zmv

printf "[$fg[blue]info$reset_color ] Start installing dotfiles to $HOME."

current=$(pwd)

zmv -L -s "$(pwd)/dot.(*)" "$HOME/.\$1"

if [[ ! $? ]]; then
    printf "[$fg[red]error$reset_color] $fg_bold[red] Failed to install dotfiles. Please see above messages.$reset_color\n"
else
    printf "[$fg[blue]info$reset_color ] Finish installing dotfiles to $HOME."
fi

ln -s $current/bin $HOME/bin

for i in $(ls ./init/**/*.sh); do
    printf "[$fg[blue]info$reset_color ] Execute $i ..."
    sh ./$i
done
