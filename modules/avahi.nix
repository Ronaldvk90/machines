{ config, pkgs, lib, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  environment.systemPackages = with pkgs; [
    avahi
  ];
}