#!/usr/bin/env bash
set -euo pipefail

HOST="${1:?Target IP}"
MACHINE="${2:?Machine name}"

if [[ -z "$KEY" ]]; then
    echo "No key supplied!"
    exit 1
fi

nix shell nixpkgs#nixos-anywhere -c nixos-anywhere --flake github:ronaldvk90/machines#$MACHINE root@"$HOST"

HOST=10.10.10.222
printf "%s" "waiting for host to come up..."
while ! ping -c 1 -n -w 1 $HOST &> /dev/null
do
    printf "%c" "."
done
 echo "Paste age private key, then press CTRL+D:"
ssh ronald@"$HOST" '
  sudo install -d -m 700 /var/lib/agenix &&
  sudo install -m 600 /dev/stdin /var/lib/agenix/agenix.key
'