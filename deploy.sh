#!/usr/bin/env bash

# Fail on everything. All has to go well for this installerscript to finish.
set -euo pipefail

# Information on usage.
echo "deploy.sh <machine IP> <machine hostname (uit flake)> <user voor 2FA (ALS aanwezig)>"

# Needed (and one not needed) variables.
HOST="${1:?Target IP}"
MACHINE="${2:?Machine name}"
USER="${3:-}"

# Creating the temp folder structure for the agenix key. Deleting it when done for security measures!
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/var/lib/agenix"

# Read the agenix key from 1Password CLI.
op read "op://Shared/AgeNix private key/text" > "$tmp/var/lib/agenix/agenix.key"

# Install the designated machine with nixos-anywhere also copying the agenix key in place.
nix shell nixpkgs#nixos-anywhere -c nixos-anywhere --extra-files "$tmp" --phases kexec,disko,install --flake .#$MACHINE root@"$HOST"

# IF you have a user specified as commandline option, google-authenticator 2FA will be rolled out for that particular user.
if [[ -n "$USER" ]]; then
ssh -t root@"$HOST" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "cd /mnt && nixos-enter -c 'hostname \"$MACHINE\" && runuser -u \"$USER\" -- google-authenticator'"
fi

# Reboot the freshly installed host.
ssh -t root@"$HOST" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q "reboot"