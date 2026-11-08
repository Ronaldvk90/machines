{ config, pkgs, lib, ... }:

{
  services.target = {
    enable = true;

    config = {
      storage_objects = [
        {
          dev = "/storage/jellyfin";
          name = "jellyfin_database";
          plugin = "fileio";
          size = 15000000000;
          write_back = true;
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
                  ip_address = "[::0]";
                  iser = false;
                  offload = false;
                  port = 3260;
                }
              ];
              
              node_acls = [
                {
                  authentication = -1;
                  node_wwn = "iqn.2026-11.lan.bttf:jellyfindatabase";
                  mapped_luns = [
                    {
                      index = 0;
                      tpg_lun = 0;
                      write_protect = false;
                    }
                  ];
                }
              ];
            }
          ];
          parameters = [
            {
              #AuthMethod = "CHAP,None";
              AuthMethod = "None";
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