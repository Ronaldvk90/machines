{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "werkplaats";
  networking.domain = "2switch";

  # Enable networking
  networking.networkmanager.enable = true;

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
