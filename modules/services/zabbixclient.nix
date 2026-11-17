{ config, pkgs, lib, ... }:

{
  services.zabbixAgent = {
    enable = true;
    serverActive = "10.10.10.8";
    openFirewall = true;
  };
}