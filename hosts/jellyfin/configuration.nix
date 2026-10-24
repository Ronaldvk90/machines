{ config, pkgs, lib, modulesPath, ... }:

{
  home-manager.users.ronald = import ../../home/ronald/server.nix;

  networking.hostName = "jellyfin";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;

############### iscsi ######################
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
    options = [ "_netdev" "nofail" ];
  };
##################################################

############# SSH host key deployment ############
  age.secrets."ssh_host_ed25519_key" = {
    file = ./ssh_host_ed25519_key.age;
    path = "/etc/ssh/ssh_host_ed25519_key";
  };

  age.secrets."ssh_host_rsa_key" = {
    file = ./ssh_host_rsa_key.age;
    path = "/etc/ssh/ssh_host_rsa_key";
  };
##################################################

  networking.firewall.enable = false;
  system.stateVersion = "26.05";
}
