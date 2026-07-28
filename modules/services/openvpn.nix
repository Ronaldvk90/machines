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
}