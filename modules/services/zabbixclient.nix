{ config, pkgs, lib, ... }:

{
  services.zabbixAgent = {
    enable = true;
    server = "10.10.10.8";
    openFirewall = true;
    
    extraConfig = ''
      AllowKey=system.run[reboot,*]
    '';
  };
}