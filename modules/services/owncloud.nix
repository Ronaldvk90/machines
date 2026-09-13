{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers.owncloud = {
   image = "owncloud/server:latest";
   ports = [ "8080:8080" ];
    environment = {
    // Add required database and admin environment variables here
    };
  };
}