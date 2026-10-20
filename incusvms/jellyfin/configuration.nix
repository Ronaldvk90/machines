{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [
    # Include the default incus configuration.
    "${modulesPath}/virtualisation/incus-virtual-machine.nix"
  ];
  
  boot.supportedFilesystems = [ "nfs" ];
  
  fileSystems."/mnt/jellyfin" = {
    device = "10.10.10.3:storage/jellyfin";
    fsType = "nfs4";
  };

  # fileSystems."/mnt/jellyfin" = {
  #   device = "//10.10.10.3/jellyfin";
  #   fsType = "cifs";
  #   options = [ "credentials=/run/agenix/ronaldNasCredentials" "x-systemd.automount" "auto" "uid=996" "gid=995" "file_mode=0770" "dir_mode=0770" ];
  # };

  home-manager.users.ronald = import ../../home/ronald/server.nix;

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-enp5s0" = {
      matchConfig.Name = "enp5s0";
      address = [ "10.10.10.17/24" ];
      networkConfig = {
        Gateway = "10.10.10.1";
        DNS = [ "10.10.10.1" ];
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  networking.enableIPv6 = false;
  system.stateVersion = "26.05";
}
