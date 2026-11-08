{ config, pkgs, lib, ... }:

{
  services.target = {
    enable = true;
    config = {
      storage_objects = [
        {
          name = "jellyfin_database";
          plugin = "fileio";
          dev = "/home/ronald/test.img";
        }
      ];
    };

  targets = [
    {
      fabric = "iscsi";
      wwn = "iqn.2026-11.lan.bttf:doc";
      tpgs = [
        {
        }
      ];
    }
  ];
  };

  networking.firewall = {
    allowedTCPPorts = [ 3260 ];
  };
}