#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?Target IP}"
MACHINE="${2:?Machine name}"

nix shell nixpkgs#nixos-anywhere -c nixos-anywhere --phases kexec,disko,install --flake github:ronaldvk90/machines#$MACHINE root@"$HOST"