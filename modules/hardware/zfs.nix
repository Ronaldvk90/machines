{ config, pkgs, lib, ... }:

{
  boot.zfs.forceImportRoot = false;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "storage" ];

  environment.systemPackages = with pkgs; [
    zfs
  ];
}