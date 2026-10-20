{ config, pkgs, lib, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    dataDir = "/mnt/jellyfin";
  };

  users.groups.media = {
    gid = 2000;
  };
  
  users.users.ronald.extraGroups = [
    "media"
  ];

  users.users.jellyfin.extraGroups = [
    "media"
  ];
}