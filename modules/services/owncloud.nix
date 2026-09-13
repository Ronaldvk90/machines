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

 fileSystems."/mnt/delena" = {
   device = "//10.10.10.3/delena";
   fsType = "cifs";
   options = [ "credentials=/run/agenix/delenaNasCredentials" "x-systemd.automount" "auto" "uid=1000" "gid=3000" "file_mode=0070" "dir_mode=0070" ];
 };

  users.groups.cloudper = {
    gid = 3000;
  };

  users.users.ronald.extraGroups = [
    "cloudper"
  ];

  users.users.owncloud.extraGroups = [
    "cloudper"
  ];
}