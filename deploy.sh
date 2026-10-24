#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?Target IP}"
MACHINE="${2:?Machine name}"
USER="${3:?2FA user}"

tmp=$(mktemp -d)                                                                                                
mkdir -p "$tmp/var/lib/agenix"

op read "op://Shared/AgeNix private key/text" > "$tmp/var/lib/agenix/agenix.key"

nix shell nixpkgs#nixos-anywhere -c nixos-anywhere --extra-files "$tmp" --phases kexec,disko,install --flake github:ronaldvk90/machines#$MACHINE root@"$HOST"
#ssh root@"$HOST" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "cd /mnt && nixos-enter --command 'su - $USER -c google-authenticator'"
ssh -t root@"$HOST" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "cd /mnt && nixos-enter -c 'runuser -u \"$USER\" -- google-authenticator'"
ssh -t root@"$HOST" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "sudo reboot"