#! /usr/bin/env bash

sudo cp configuration.nix /etc/nixos/configuration.nix
sudo cp "hardware/$(hostname).nix" /etc/nixos/hardware-configuration.nix

if [[ -z $1 ]]; then
  sudo nixos-rebuild switch
else
  sudo nixos-rebuild build
  echo "apply this generation with nixos-rebuild boot"
fi
