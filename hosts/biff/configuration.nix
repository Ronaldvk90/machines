{ config, lib, pkgs, ... }:

{

  hardware.graphics = {
    enable = true;
  };

  boot.plymouth.enable = true; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "biff"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ronald = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Ronald van Kouwen";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "dialout" "scanner" "lp" ];
  };

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

