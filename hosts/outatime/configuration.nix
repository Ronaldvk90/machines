{ config, pkgs, lib, modulesPath, ... }:

{
  home-manager.users.ronald = import ../../home/ronald/server.nix;

  networking.hostName = "outatime";
  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-ens18" = {
      matchConfig.Name = "ens18";
      address = [ "10.10.10.11/24" ];
      networkConfig = {
        Gateway = "10.10.10.1";
        DNS = [ "10.10.10.1" ];
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };
  
  networking.enableIPv6 = false;
  networking.firewall.enable = false;
  system.stateVersion = "26.05";
}