{ config, pkgs, lib, ... }:

{
  services.zabbixAgent = {
    enable = true;
    server = "IP_VAN_JE_ZABBIX_SERVER";
  };
}