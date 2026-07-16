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

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
}