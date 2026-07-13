{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "amdgpu" ];

  security.sudo.wheelNeedsPassword = false;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # boot.plymouth.enable = true; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "werkplaats"; # Define your hostname.
  networking.domain = "2switch";

  # Enable networking
  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ronald = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Ronald van Kouwen";
    extraGroups = [ "wheel" "docker" "libvirtd" "dialout" "scanner" "lp" "networkmanager" "video" ];
    packages = with pkgs; [];
  };

  home-manager.users.ronald = import ../../home/ronald/home.nix;

  environment.systemPackages = with pkgs; [
  vim
  killall
  playerctl
  cifs-utils
  htop
  bash
  wget
  ntfs3g
  smartmontools
  inetutils
  dhcpcd
  exfat
  hfsprogs
  ];

  networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?

}
