{ config, pkgs, lib, ... }:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  services.ipp-usb.enable = true;
}