#! /usr/bin/env bash

set -eu

sudo cp configuration.nix /etc/nixos/configuration.nix
sudo cp pkgs.nix /etc/nixos/pkgs.nix
sudo cp "hardware/$(hostname).nix" /etc/nixos/hardware-configuration.nix

if [[ -z $1 ]]; then
	nixos-rebuild --help
else
	# shellcheck disable=2048,2086
	sudo nixos-rebuild $*
fi
