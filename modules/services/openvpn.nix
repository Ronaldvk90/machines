{ config, pkgs, lib, ... }:

{
    services.openvpn.servers = {
        thuis = {
            autoStart = false;
            config = builtins.readFile /run/agenix/thuis.ovpn;
        };
    };

    environment.systemPackages = with pkgs; [
        openvpn
    ];
}