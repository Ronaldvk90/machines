{ config, pkgs, lib, ... }:

{
  services.target = {
    enable = true;

    #targets = {
    #  "iqn.2026-11.lan.bttf:doc" = {
    #    # hier komt de target-configuratie
    #  };
    };
  services.target.config = {
    storage_objects = [
      {
        name = "jellyfin_database";
        plugin = "fileio";
        dev = "/home/ronald/test.img";
    }
  ];

  targets = [
    {
      fabric = "iscsi";
      wwn = "iqn.2026-11.lan.bttf:doc";

    }
  ];
};
  networking.firewall = {
    allowedTCPPorts = [ 3260 ];
  };
}