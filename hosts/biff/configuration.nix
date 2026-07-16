{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
  };

  networking.hostName = "biff"; # Define your hostname.
  networking.networkmanager.enable = true;

  home-manager.users.ronald = import ../../home/ronald/home.nix;
  
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    killall
    exfat
    htop
    cdrkit
    bash
    git
  ];

  networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?

}

