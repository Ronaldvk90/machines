#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?Target IP}"
MACHINE="${2:?Machine name}"

op item get "AgeNix private key" --vault "Shared" --field "text" > "$tmp/var/lib/agenix/agenix.key"

nix shell nixpkgs#nixos-anywhere -c nixos-anywhere --extra-files "$tmp" --phases kexec,disko,install --flake github:ronaldvk90/machines#$MACHINE root@"$HOST"

