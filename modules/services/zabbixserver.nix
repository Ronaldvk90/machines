{ config, pkgs, lib, ... }:

{
  
  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "ronaldvk90@bttf.lan";
  # };

  services.zabbixServer = {
    package = pkgs.zabbix74.server;
    enable = true;
  };

  services.zabbixWeb = {
    package = pkgs.zabbix74.web;
    enable = true;
    virtualHost = {
      hostName = "zabbix.bttf.lan";
      frontend = "nginx";
      adminAddr = "webmaster@bttf.lan";
      nginx.virtualHost = {
        forceSSL = true; #
        enableACME = true; #
      };
    };
  };

  services.zabbixAgent = {
    package = pkgs.zabbix74.agent2;
    enable = true;
    server = "127.0.0.1";
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 10050 10051 ];
}