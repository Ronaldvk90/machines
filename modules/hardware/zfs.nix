{ config, pkgs, lib, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "storage" ];

  environment.systemPackages = with pkgs; [
    zfs
  ];
}