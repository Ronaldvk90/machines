```nix
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
              luns = [
                {
                  authentication = 0;
                  index = 0;
                  storage_object = "/backstores/fileio/jellyfin_database";
                }
              ];

              portals = [
                {
                  ip_address = "10.10.10.100";
                  ip_port = 3260;
                }
              ];
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