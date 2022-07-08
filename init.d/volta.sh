#!/bin/bash

if [[ ! -f ~/bin/volta ]]; then
    curl https://get.volta.sh | bash -s -- --skip-setup
fi
