{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers.owncloud = {
   image = "owncloud/server:latest";
   ports = [ "8080:8080" ];
    environment = {
      OWNCLOUD_TRUSTED_DOMAINS = "localhost owncloud.bttf.lan";
    };
  };
}