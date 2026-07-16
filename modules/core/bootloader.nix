{ config, pkgs, lib, ... }:

{
  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "ahci"
    "sd_mod"
    "nvme"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}