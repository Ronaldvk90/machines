{ config, pkgs, lib, ... }:
{
services.nextcloud = {
  enable = true;
  extraApps = {
    inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
  };
  extraAppsEnable = true;
  hostName = "nextcloud";
  config.adminpassFile = config.age.secrets.nextcloudcredentials.path;
  datadir = "/mnt/nextcloud";
  #config.dbtype = "sqlite";

  config = {
    dbtype = "pgsql";
    dbname = "nextcloud";
    dbuser = "nextcloud";
    dbhost = "/run/postgresql";
  };

  settings = {
    # Some sane defaults required to satisfy Nextcloud configuration check
    maintenance_window_start = 1;
    default_phone_region = "NL";
    log_type = "systemd";
    serverid = 0;

    trusted_domains = [
      "nextcloud"
      "nextcloud.bttf.lan"
      ];
    };
  };

services.postgresql = {
  enable = true;
  ensureDatabases = [ "nextcloud" ];
  ensureUsers = [{
    name = "nextcloud";
    ensureDBOwnership = true;
  }];
};

  age.secrets.nextcloudcredentials = {
    file = ../../secrets/nextcloud.credentials.age;
  };
}