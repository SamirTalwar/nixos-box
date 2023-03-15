#!/usr/bin/env bash

set -e

sudo cp *.nix /etc/nixos/
sudo nix-channel --update
sudo nixos-rebuild switch
