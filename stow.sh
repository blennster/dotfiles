#! /usr/bin/env bash

set -eu

modules=(shell others scripts sway)

case $USER in
    "s7000033439")
        stow -v work
        ;;
    *)
        stow -v home
        ;;
esac

for module in "${modules[@]}"; do
    stow -v "$module"
done

