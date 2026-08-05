{ config, pkgs, lib, modulesPath, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false;

  home-manager.users.ronald = import ../../home/ronald/server.nix;

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  networking.hostName = "jellyfin";
  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
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
