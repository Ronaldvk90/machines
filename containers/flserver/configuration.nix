{ config, pkgs, ... }:

{
  networking.hostName = "flserver";

  services.xrdp.enable = true;

  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  users.users.ronald = {
    isNormalUser = true;
    initialPassword = "";
  };

  environment.systemPackages = with pkgs; [
    wine
    winetricks
  ];

  system.stateVersion = "26.05";
}