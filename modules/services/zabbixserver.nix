{ config, pkgs, lib, ... }:

{
  #services.phpfpm.pools.zabbix.phpPackage = pkgs.php83;

  services.zabbix74.server = {
    enable = true;
  };

  services.zabbix74.Web = {
    enable = true;
    virtualHost = {
      hostName = "zabbix.bttf.lan";
      adminAddr = "webmaster@bttf.lan";
    };
  };

  services.zabbix.agent2 = {
    enable = true;
    server = "127.0.0.1";
  };
  
  networking.firewall.allowedTCPPorts = [ 80 443 10050 10051 ];
}