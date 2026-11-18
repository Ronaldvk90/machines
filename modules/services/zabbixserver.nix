{ config, pkgs, lib, ... }:

{
  #services.phpfpm.pools.zabbix.phpPackage = pkgs.php83;

  services.zabbixServer = {
    package = pkgs.zabbix74.server;
    enable = true;
  };

  services.zabbixWeb = {
    package = pkgs.zabbix74.web;
    enable = true;
    virtualHost = {
      hostName = "zabbix.bttf.lan";
      adminAddr = "webmaster@bttf.lan";
    };
  };

  services.zabbixAgent = {
    package = pkgs.zabbix74.agent2;
    enable = true;
    server = "127.0.0.1";
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 10050 10051 ];
}