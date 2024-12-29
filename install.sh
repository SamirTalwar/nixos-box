#!/usr/bin/env bash

set -e
set -u

if [[ $# -ne 1 ]]; then
  echo >&2 "Usage: ${0} HOSTNAME"
  exit 2
fi

HOSTNAME="$1"
LOCAL_FILE="machines/${HOSTNAME}.nix"

if [[ ! -f "$LOCAL_FILE" ]]; then
  echo >&2 "No configuration for host: ${HOSTNAME}"
  exit 1
fi

sudo cp -v configuration.nix lix.nix /etc/nixos/
sudo cp -v "machines/${HOSTNAME}.nix" /etc/nixos/local.nix
sudo nix-channel --update
sudo nixos-rebuild switch
