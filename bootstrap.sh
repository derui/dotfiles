#!/bin/bash

printf "[info ] Start installing dotfiles to $HOME.\n"

current=$(pwd)

for f in $(find "${current}" -name "*.dot"); do
    f_=$HOME/${f##*/}
    f_=${f_%.dot}

    if [[ (( -e $f_ )) || (( -L $f_ )) ]]; then
        printf "[warn ] Already extsts $f as Symbolic link.\n"
    else
        ln -s $f $f_
    fi
done

if [[ ! $? ]]; then
    printf "[error] Failed to install dotfiles. Please see above messages.\n"
else
    printf "[info ] Finish installing dotfiles to $HOME.\n"
fi

if [[ ! -L "${HOME}/bin" ]]; then
    ln -s $current/bin $HOME/bin
fi

for i in $(find "$current/init.d" -name "*.sh"); do
    printf "[info ] Execute $i ...\n"
    sh $i
done
