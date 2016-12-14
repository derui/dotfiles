#!/bin/zsh

autoload -Uz zmv

printf "[$fg[blue]info$reset_color ] Start installing dotfiles to $HOME.\n"

current=$(pwd)

zmv -L -s "${current}/dot.(*)" "$HOME/.\$1"

if [[ ! $? ]]; then
    printf "[$fg[red]error$reset_color] $fg_bold[red] Failed to install dotfiles. Please see above messages.$reset_color\n"
else
    printf "[$FG[blue]info$reset_color ] Finish installing dotfiles to $HOME.\n"
fi

if [[ ! -L "${HOME}/bin" ]]; then
    ln -s $current/bin $HOME/bin
fi

for i in $(ls $current/init.d/**/*.sh); do
    printf "[$fg[blue]info$reset_color ] Execute $i ...\n"
    sh $i
done
