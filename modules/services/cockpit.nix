{ config, pkgs, lib, ... }:

{
  services.cockpit = {
    enable = true;
    port = 9090;
    openFirewall = true;
    plugins = [
      pkgs.cockpit-files
      #pkgs.cockpit-zfs
    ];
    settings = {
      WebService = {
        Origins = lib.mkForce "http://localhost:9090 https://localhost:9090";
      };
    };
  };
}