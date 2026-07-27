{ config, pkgs, ... }:

{
  systemd.services.openvpn-thuis = {
    description = "OpenVPN thuis";

    after = [
      "network-online.target"
    ];

    wants = [
      "network-online.target"
    ];

    serviceConfig = {
      ExecStart = "${pkgs.openvpn}/bin/openvpn --config ${config.age.secrets.ronaldOpenvpn.path}";
      Restart = "on-failure";
    };
  };

  environment.systemPackages = with pkgs; [
    openvpn
  ];
}