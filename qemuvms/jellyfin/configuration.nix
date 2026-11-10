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
    name = "iqn.2026-11.lan.bttf:jellyfindatabase";
    discoverPortal = "10.10.10.3";
  };
 
  systemd.services.iscsi-login-jellyfin = {
    description = "Login to iSCSI target jellyin database";
    after = [ "network.target" "iscsid.service" ];
    wants = [ "iscsid.service" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.openiscsi}/bin/iscsiadm -m discovery -t sendtargets -p 10.10.10.112";
      ExecStart = "${pkgs.openiscsi}/bin/iscsiadm -m node -T iqn.2026-11.lan.bttf:doc  -p 10.10.10.112 --login";
      ExecStop = "${pkgs.openiscsi}/bin/iscsiadm -m node -T iqn.2026-11.lan.bttf:doc  -p 10.10.10.112 --logout";
      Restart = "on-failure";
      RemainAfterExit = true;
    };
    wantedBy = [ "multi-user.target" ];
  };

  fileSystems."/mnt/jellyfin" = {
    device = "/dev/disk/by-uuid/2ba9661a-2576-4c96-aaab-569471e66135";
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
