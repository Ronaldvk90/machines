{ config, pkgs, lib, modulesPath, ... }:

{
  home-manager.users.ronald = import ../../home/ronald/server.nix;

  networking.hostName = "outatime";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;
 
  networking.firewall.enable = false;
  system.stateVersion = "26.05";
}