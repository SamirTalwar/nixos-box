#!/usr/bin/env bash

set -e

sudo cp *.nix /etc/nixos/
sudo nixos-rebuild switch
