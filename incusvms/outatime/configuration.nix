{ config, pkgs, lib, modulesPath, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false;

  imports = [
    # Include the default incus configuration.
    #"${modulesPath}/virtualisation/incus-virtual-machine.nix"
    "${modulesPath}/virtualisation/lxc-container.nix"
  ];

  home-manager.users.ronald = import ../../home/ronald/server.nix;

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
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