{ config, pkgs, lib, ... }:

{
    services.openvpn.servers = {
        thuis = {
            autoStart = false;
            config = '' config config.age.secrets.ronaldOpenvpn.path '';
            #config = config.age.secrets.ronaldOpenvpn.path;
            updateResolvConf = true;
        };
    };

    environment.systemPackages = with pkgs; [
        openvpn
    ];
}