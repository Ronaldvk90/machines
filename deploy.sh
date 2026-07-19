#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?Target IP}"
MACHINE="${2:?Machine name}"

nix shell nixpkgs#nixos-anywhere -c nixos-anywhere --phases kexec,disko,install --flake github:ronaldvk90/machines#$MACHINE root@"$HOST"

echo "Paste your age key, finish with CTRL-D:"
ssh root@"$HOST" 'sudo install -m 600 /dev/stdin /mnt/var/lib/agenix/agenix.key'