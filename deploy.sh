#!/usr/bin/env bash
set -euo pipefail

echo "deploy.sh <machine IP> <machine hostname (uit flake)> <user voor 2FA (ALS aanwezig)>"

HOST="${1:?Target IP}"
MACHINE="${2:?Machine name}"
USER="${3:-}"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/var/lib/agenix"

op read "op://Shared/AgeNix private key/text" > "$tmp/var/lib/agenix/agenix.key"

nix shell nixpkgs#nixos-anywhere -c nixos-anywhere --extra-files "$tmp" --phases kexec,disko,install --flake .#$MACHINE root@"$HOST"

if [[ -n "$USER" ]]; then
ssh -t root@"$HOST" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "cd /mnt && nixos-enter -c 'hostname \"$MACHINE\" && runuser -u \"$USER\" -- google-authenticator'"
fi

ssh -t root@"$HOST" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "reboot"