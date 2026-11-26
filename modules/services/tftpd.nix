{ config, pkgs, lib, ... }:

{
  services.atftpd = {
    enable = true;
    root = "/srv/tftp";
    extraOptions = [ "--verbose" ];
  };

  systemd.tmpfiles.rules = [
    "d /srv/tftp 0755 nobody nogroup -"
  ];

  networking.firewall.allowedUDPPorts = [ 69 ];
}