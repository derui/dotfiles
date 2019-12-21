#!/usr/bin/env bash

function main() {
    if [[ ! -x $(which xtitle) ]]; then
        exit 1
    fi

    while read xtit; do
        echo $xtit
    done < <(xtitle -s)
}

main
