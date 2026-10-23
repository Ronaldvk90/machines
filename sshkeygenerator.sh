#!/usr/bin/env bash
set -euo pipefail

mkdir -p newkeys
ssh-keygen -t ed25519 -f "./newkeys/ssh_host_ed25519_key" -N ""
ssh-keygen -t rsa -b 4096 -f "./newkeys/ssh_host_rsa_key" -N ""