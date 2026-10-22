{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    # Include the default incus configuration.
    "${modulesPath}/virtualisation/incus-virtual-machine.nix"
  ];

############### iscsi trial ######################
   boot.kernelModules = [ "iscsi_tcp" ];   # not sure if needed but added just incase
   
   services.openiscsi = {
    enable = true;  # Enable openiscsi daemon
    name = "spermaanus";  # Set **YOUR** iSCSI initiator name not the one that you are trying to connect to. I am pretty sure this can be whatever you want.

    discoverPortal = "10.10.10.3";   # IP of your iscsi server
  };
 
 # Custom systemd service for logging in to a specific iSCSI target, you can name the service whatever youd like
  systemd.services.iscsi-login-lingames = {
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
##################################################

  # boot.supportedFilesystems = [ "nfs" ];
  
  # fileSystems."/mnt/jellyfin" = {
  #   device = "10.10.10.3:storage/jellyfin";
  #   fsType = "nfs4";
  # };

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
