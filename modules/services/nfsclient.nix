{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  fileSystems."/mnt/ronald" = {
    device = "10.10.10.112:/home/ronald";
    fsType = "nfs4";
    options = [ "x-systemd.automount" ];
  };

  fileSystems."/mnt/debbie" = {
    device = "10.10.10.112:/home/debbie";
    fsType = "nfs4";
    options = [ "x-systemd.automount" ];
  };
}