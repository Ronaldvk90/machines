{ config, lib, pkgs, ... }:

{
  networking.hostName = "flserver";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;

  home-manager.users.ronald = import ./wine.nix;
  
  environment.systemPackages = with pkgs; [
    vim
    wget
    killall
    exfat
    htop
  ];

  networking.firewall.enable = false;

  system.stateVersion = "26.05";
}

