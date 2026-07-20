#!/usr/bin/env bash
set -euo pipefail

OUT=./iso-output

nix build \
  .#nixosConfigurations.isoinstaller.config.system.build.isoImage \
  --out-link "$OUT/"
