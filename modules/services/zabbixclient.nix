{ config, pkgs, lib, ... }:

let
  zabbixReboot = pkgs.writeShellScriptBin "zabbix-reboot" ''
    exec ${pkgs.systemd}/bin/systemctl reboot
  '';
in
{
  environment.systemPackages = [
    zabbixReboot
  ];

  security.sudo.extraRules = [
    {
      users = [ "zabbix-agent" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/zabbix-reboot";
          options = [ "NOPASSWD" ];
        }

        {
          command = "${pkgs.smartmontools}/bin/smartctl";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  services.zabbixAgent = {
    enable = true;
    server = "10.10.10.8";
    openFirewall = true;

    settings = {
      "Plugins.Smart.Path" = "${pkgs.smartmontools}/bin/smartctl";
      AllowKey = "system.run[sudo /run/current-system/sw/bin/zabbix-reboot,*]";
      UserParameter = "zfs,/run/current-system/sw/bin/zabbix-zfs";
    };
  };
}