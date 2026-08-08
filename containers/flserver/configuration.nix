{ config, lib, pkgs, ... }:

{
  networking.hostName = "flserver";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;

  home-manager.users.ronald = import ./wine.nix;
  
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    killall
    exfat
    htop
  ];

  networking.firewall.enable = false;

  system.stateVersion = "26.05"; # Did you read the comment?

}

