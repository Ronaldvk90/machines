{ config, pkgs, lib, ... }:

{
  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [
    qemu
    spice
  ];

}
