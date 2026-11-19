{ config, pkgs, lib, ... }:

{  
  services.zabbixServer = {
    package = pkgs.zabbix74.server;
    enable = true;
  };

  # services.zabbixWeb = {
  #   package = pkgs.zabbix74.web;
  #   frontend = "nginx";
  #   enable = true;

  #   virtualHost = {
  #     hostName = "zabbix.bttf.lan";
  #     adminAddr = "webmaster@bttf.lan";

  #     nginx.virtualHost = {
  #       forceSSL = true;
  #       sslCertificate = config.age.secrets."zabbix_bttf_lan_crt".path;
  #       sslCertificateKey = config.age.secrets."zabbix_bttf_lan_key".path;
  #     };
  #   };
  # };
  services.zabbixWeb = {
    package = pkgs.zabbix74.web;
    frontend = "nginx";
    enable = true;
    hostName = "zabbix.bttf.lan";

    nginx.virtualHost = {
      forceSSL = true;
      sslCertificate = config.age.secrets."zabbix_bttf_lan_crt".path;
      sslCertificateKey = config.age.secrets."zabbix_bttf_lan_key".path;
    };
  };

  services.zabbixAgent = {
    package = pkgs.zabbix74.agent2;
    enable = true;
    server = "127.0.0.1";
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 10050 10051 ];
}