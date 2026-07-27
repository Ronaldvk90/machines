{ config, pkgs, lib, ... }:

{
    services.openvpn.servers = {
        thuis = {
            autoStart = false;
            config = "/run/agenix/ronaldOpenvpn";
            updateResolvConf = true;
        };
    };

    environment.systemPackages = with pkgs; [
        openvpn
    ];
}