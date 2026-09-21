{ config, pkgs, lib, ... }:
{
services.nextcloud = {
  enable = true;
  hostName = "nextcloud";
  #config.adminpassFile = "/etc/nextcloud-admin-pass";
  config.dbtype = "sqlite";
  settings = {
    # Some sane defaults required to satisfy Nextcloud configuration check
    maintenance_window_start = 1;
    default_phone_region = "NL";
    log_type = "systemd";
    serverid = 0;
    };
  };
}