#!/usr/bin/env bash
set -euo pipefail

OUT=./live-output

nix build \
  .#nixosConfigurations.livexfce.config.system.build.isoImage \
  --out-link "$OUT/"
