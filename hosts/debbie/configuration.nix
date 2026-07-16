{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  
  # Ensure base graphics are enabled
  hardware.graphics.enable = true;

  # Enable 32-bit drivers for your system (e.g. for Wine/Steam)
  hardware.graphics.enable32Bit = true;

  networking.hostName = "debbie"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  home-manager.users.debbie = import ../../home/debbie/home.nix;

  environment.systemPackages = with pkgs; [
    vim
    git
    avahi
    ntfs3g
  ];

  system.stateVersion = "26.05"; # Did you read the comment?
}