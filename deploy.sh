#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?Target hostname/IP}"

nix shell nixpkgs#nixos-anywhere -c \
  nixos-anywhere \
    --flake github:ronaldvk90/machines#strickland \
    root@"$HOST"