#! /usr/bin/env bash

set -eu

modules=(shell scripts)

case $USER in
"now")
    modules=(work "${modules[@]}" macos)
    ;;
*)
    modules=(home "${modules[@]}" others sway)
    ;;
esac

for module in "${modules[@]}"; do
    stow --dotfiles -v "$module"
done
