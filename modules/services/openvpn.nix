{ config, pkgs, lib, ... }:

{
    services.openvpn.servers = {
        thuis = {
            autoStart = false;
            config = '' config /run/agenix/ronaldOpenvpn '';
            updateResolvConf = true;
        };
    };

    environment.systemPackages = with pkgs; [
        openvpn
    ];

  # age.secrets.ronaldOpenvpn = {
  #   file = ../../secrets/ronald.openvpn.credentials.age;
  # };

  # age.secrets.debbieOpenvpn = {
  #   file = ../../secrets/debbie.openvpn.credentials.age;
  # };
}