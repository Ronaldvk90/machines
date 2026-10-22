{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    # Include the default incus configuration.
    "${modulesPath}/virtualisation/incus-virtual-machine.nix"
  ];

############### iscsi trial ######################
   boot.kernelModules = [ "iscsi_tcp" ];
   
   services.openiscsi = {
    enable = true;
    name = "jellyfindatabase";
    discoverPortal = "10.10.10.3";
  };
 
  systemd.services.iscsi-login-jellyfin = {
    description = "Login to iSCSI target jellyin database";
    after = [ "network.target" "iscsid.service" ];
    wants = [ "iscsid.service" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.openiscsi}/bin/iscsiadm -m discovery -t sendtargets -p 10.10.10.3";
      ExecStart = "${pkgs.openiscsi}/bin/iscsiadm -m node -T iqn.1994-11.com.netgear:doc:d161c130:nas -p 10.10.10.3 --login";
      ExecStop = "${pkgs.openiscsi}/bin/iscsiadm -m node -T iqn.1994-11.com.netgear:doc:d161c130:nas -p 10.10.10.3 --logout";
      Restart = "on-failure";
      RemainAfterExit = true;
    };
    wantedBy = [ "multi-user.target" ];
  };

  fileSystems."/mnt/jellyfin" = {
    device = "/dev/disk/by-uuid/f1b5e69f-74ef-428d-9d03-8157834e642d";
    fsType = "ext4";
    options = [ "_netdev" "nofail" "umask=000" ];
  };
##################################################

  home-manager.users.ronald = import ../../home/ronald/server.nix;

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-enp5s0" = {
      matchConfig.Name = "enp5s0";
      address = [ "10.10.10.17/24" ];
      networkConfig = {
        Gateway = "10.10.10.1";
        DNS = [ "10.10.10.1" ];
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  networking.enableIPv6 = false;
  system.stateVersion = "26.05";
}
