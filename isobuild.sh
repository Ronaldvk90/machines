#!/usr/bin/env bash
set -euo pipefail

OUT=./iso-output

mkdir -p "$OUT"

nix build \
  .#nixosConfigurations.isoinstaller.config.system.build.isoImage \
  --out-link "$OUT/"