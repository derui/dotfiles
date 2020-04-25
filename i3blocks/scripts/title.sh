#!/usr/bin/env bash

function main() {
    if [[ ! -x $(which xtitle) ]]; then
        exit 1
    fi

    local current_title=""
    while read xtit; do
        if [[ "$current_title" != "$xtit" ]]; then
            echo $xtit
            current_title=$xtit
        fi
    done < <(xtitle -s)
}

main
