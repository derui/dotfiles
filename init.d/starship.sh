#!/bin/sh

if [ ! -f ~/bin/starship ]; then
    curl -fsSL https://starship.rs/install.sh -o /tmp/install.sh
    sh /tmp/install.sh -b ~/bin

    rm -f /tmp/install.sh
fi
