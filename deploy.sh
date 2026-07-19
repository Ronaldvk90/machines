#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?Target IP}"
MACHINE="${2:?Machine name}"

nix shell nixpkgs#nixos-anywhere -c nixos-anywhere --flake github:ronaldvk90/machines#$MACHINE root@"$HOST"