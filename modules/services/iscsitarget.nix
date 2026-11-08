{ config, pkgs, lib, ... }:

{
  services.target = {
    enable = true;
    config = {
      storage_objects = [
        {
          dev = "/home/ronald/test.img";
          name = "jellyfin_database";
          plugin = "fileio";
          size = 10737418240;
          write_back = true;
          wwn = "96d921a9-e443-4a28-a492-80c1d564662b";
        }
      ];

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
  };

  networking.firewall = {
    allowedTCPPorts = [ 3260 ];
  };
}