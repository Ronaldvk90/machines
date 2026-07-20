{ config, pkgs, ... }:

{  
  networking.hostName = "strickland";
  networking.hostId = "e46ea564";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.bridges = {
    "br0" = {
      interfaces = [ "eno1" ];
    };
  };
  networking.interfaces.br0.ipv4.addresses = [ {
    address = "10.10.10.2";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "10.10.10.1";
  networking.nameservers = ["10.10.10.1"];

  home-manager.users.ronald = import ../../home/ronald/server.nix;

  environment.systemPackages = with pkgs; [
  vim
  killall
  htop
  smartmontools
  inetutils
  nmap
  ];

  networking.firewall.enable = false;

  system.stateVersion = "26.05"; # Did you read the comment?
}
