{ config, pkgs, lib, ... }:

{
    services.openvpn.servers = {
        thuis = {
            autoStart = false;
            config = /run/agenix/thuis.ovpn;
        };
    };

    environment.systemPackages = with pkgs; [
        openvpn
    ];
}