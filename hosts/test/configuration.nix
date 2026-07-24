{ config, pkgs, ... }:

{  
  networking.hostName = "test";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;

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

  system.stateVersion = "26.05";
}