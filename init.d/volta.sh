#!/bin/bash

if [[ ! -f ~/bin/volta ]]; then
    curl https://get.volta.sh | bash -s -- --skip-setup
    ln -s ~/.volta/bin/volta ~/bin/volta
    ln -s ~/.volta/bin/volta-shim ~/bin/volta-shim
    ln -s ~/.volta/bin/volta-migrate ~/bin/volta-migrate
fi
