{ config, pkgs, lib, ... }:

{
  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "ahci"
    "sd_mod"
    "nvme"
    "xhci_pci"
    "ehci_pci"
    "usbhid"
    "usb_storage"
    "sr_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}