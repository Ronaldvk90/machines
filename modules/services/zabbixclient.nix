{ config, pkgs, lib, ... }:

{
  services.zabbixAgent = {
    enable = true;
    ServerActive = "10.10.10.8";
  };

  networking.firewall.allowedTCPPorts = [ 10050 10051 ];
}