{ config, pkgs, lib, ... }:

{
  services.transmission = {
    enable = true;
    openFirewall = true;
    credentialsFile = "/var/lib/secrets/transmission/settings.json";
    openRPCPort = true;

  settings = {
    rpc-host-whitelist-enable = "true";
    rpc-host-whitelist = "localhost,transmission";
    rpc-bind-address = "0.0.0.0";
    rpc-whitelost-enable = "true";
    rpc-whitelist = "127.0.0.1,10.10.10.*,10.10.20.*";
    };
  };
}