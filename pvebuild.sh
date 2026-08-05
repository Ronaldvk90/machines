#!/usr/bin/env bash
set -euo pipefail

OUT=./pve-output

nix build .#nixos-pve-lxc --out-link "$OUT/"