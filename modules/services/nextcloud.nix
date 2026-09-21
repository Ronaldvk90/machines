{ config, pkgs, lib, ... }:
{
services.nextcloud = {
  enable = true;
  hostName = "nextcloud";
  config.adminpassFile = config.age.secrets.nextcloud.credentials.path;
  config.dbtype = "sqlite";
  settings = {
    # Some sane defaults required to satisfy Nextcloud configuration check
    maintenance_window_start = 1;
    default_phone_region = "NL";
    log_type = "systemd";
    serverid = 0;
    };
  };

  age.secrets.nextcloud.credentials = {
    file = ../../secrets/nextcloud.credentials.age;
  };
}