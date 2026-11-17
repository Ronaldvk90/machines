{ config, pkgs, lib, modulesPath, ... }:

{  
  # networking = {
  #   enableIPv6 = false;
  #   firewall.enable = false;
  #   hostName = "test";
  #   domain = "bttf.lan";
  #   dhcpcd.enable = false;
  #   useDHCP = false;
  #   useHostResolvConf = false;
  # };

  # systemd.network = {
  #   enable = true;
  #   networks."50-enp5s0" = {
  #     matchConfig.Name = "enp5s0";
  #     address = [ "10.10.10.xx/24" ];
  #     networkConfig = {
  #       Gateway = "10.10.10.1";
  #       DNS = [ "10.10.10.1" ];
  #     };
      
  #     linkConfig = {
  #       RequiredForOnline = "routable";
  #       MACAddress = "xx:xx:xx:xx:xx:xx";
  #     };
  #   };
  # };
  
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  
  imports = [
    # Include the default incus configuration.
    "${modulesPath}/virtualisation/incus-virtual-machine.nix"
  ];

  home-manager.users.ronald = import ../../home/ronald/server.nix;

  environment.systemPackages = with pkgs; [
  vim
  killall
  htop
  smartmontools
  inetutils
  nmap
  ];

  system.stateVersion = "26.05";
}