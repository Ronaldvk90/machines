#!/usr/bin/env bash
set -euo pipefail

OUT=./pxe-output

mkdir -p "$OUT"

nix build \
  .#nixosConfigurations.pxeinstaller.config.system.build.kernel \
  --out-link "$OUT/kernel"

nix build \
  .#nixosConfigurations.pxeinstaller.config.system.build.netbootRamdisk \
  --out-link "$OUT/initrd"

nix build \
  .#nixosConfigurations.pxeinstaller.config.system.build.netbootIpxeScript \
  --out-link "$OUT/ipxe"

echo "PXE artifacts:"
ls -lah "$OUT"