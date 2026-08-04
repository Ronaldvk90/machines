{ config, pkgs, lib, ... }:

{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
      gutenprint
      hplip
      cnijfilter2
    ];
  };

  services.ipp-usb.enable = true;
}