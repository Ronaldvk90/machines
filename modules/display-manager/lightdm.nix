{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm = {
  enable = true;

  # Setting gtk as the greeter
  greeters.gtk.enable = true;

  # Example of having background as a particular color
  # background = "#ffa07a";

  # Example of the default image background (must be an absolute path)
  # background = pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath;
  };
}