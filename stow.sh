#! /usr/bin/env bash

set -eu

modules=(shell others scripts sway)

case $USER in
"now")
    modules=(work shell)
    ;;
*)
    modules=(home "${modules[@]}")
    ;;
esac

for module in "${modules[@]}"; do
    stow --dotfiles -v "$module"
done
