#!/usr/bin/env bash

set -euCo pipefail

current_state="init"

echo " "
while read button; do
    case $button in
        1)
            if [[ $current_state == "init" ]]; then
                current_state="suspend"
                echo "Suspend?"
            elif [[ $current_state == "suspend" ]]; then
                current_state="init"
                sudo hibernate-ram
                echo " "
            fi
            ;;
        3)
            if [[ $current_state != "init" ]]; then
                current_state="init"
                echo " "
            fi
            ;;
    esac
done
