{ config, pkgs, lib, ... }:

{
  services.zabbixServer = {
    enable = true;
  };

  services.zabbixWeb = {
    enable = true;
    virtualHost = {
      hostName = "zabbix.bttf.lan";
      adminAddr = "webmaster@bttf.lan";
    };
  };

  services.zabbixAgent = {
    enable = true;
    server = "127.0.0.1";
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 10050 10051 ];
}