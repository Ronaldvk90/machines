{ config, pkgs, lib, ... }:

{
  services.zabbixAgent = {
    enable = true;
    server = "10.10.10.8";
    openFirewall = true;
    
    settings = {
      AllowKey = "system.run[/run/current-system/sw/bin/zabbix-reboot,*]";
    };
  };

  environment.systemPackages = [
  (pkgs.writeShellScriptBin "zabbix-reboot" ''
    exec ${pkgs.systemd}/bin/systemctl reboot
  '')
  ];

  security.sudo.extraRules = [
    {
      users = [ "zabbix-agent" ];
      commands = [
        {
          command = "${pkgs.systemd}/bin/systemctl reboot";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}