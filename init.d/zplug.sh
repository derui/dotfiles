#!/bin/sh

# Clone zplug into $HOME/.zplug
if [ ! -d "$HOME/.zplug" ]; then
    git clone https://github.com/zplug/zplug $HOME/.zplug
fi
