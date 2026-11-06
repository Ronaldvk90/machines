{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  fileSystems."/mnt/ronald" = {
    device = "10.10.10.3:/home/ronald";
    fsType = "nfs4";
  };

  fileSystems."/mnt/debbie" = {
    device = "10.10.10.3:/home/debbie";
    fsType = "nfs4";
  };
}