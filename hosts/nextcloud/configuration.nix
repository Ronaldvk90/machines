{ config, pkgs, lib, modulesPath, ... }:

{
 home-manager.users.ronald = {
  imports = [
    ../../home/ronald/server.nix
  ];
};

  networking.hostName = "nextcloud";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;

  environment.systemPackages = with pkgs; [
  vim
  cifs-utils
  ];

  age.secrets.ronaldNasCredentials = {
    file = ../../secrets/ronald.nas.credentials.age;
  }; 

  fileSystems."/mnt/nextcloud" = {
    device = "//10.10.10.3/nextcloud";
    fsType = "cifs";
    options = [ "credentials=/run/agenix/ronaldNasCredentials" "x-systemd.automount" "auto" "uid=999" "gid=999" "file_mode=0770" "dir_mode=0770" ];
  };

  # users.groups.cloudper = {
  #   gid = 2000;
  # };

  # users.users.ronald.extraGroups = [
  #   "clouduser"
  # ];

  # users.users.nextcloud.extraGroups = [
  #   "clouduser"
  # ];

  networking.firewall.enable = false;
  system.stateVersion = "26.05";
}