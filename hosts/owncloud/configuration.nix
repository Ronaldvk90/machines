{ config, pkgs, lib, modulesPath, ... }:

{
 home-manager.users.ronald = {
  imports = [
    ../../home/ronald/server.nix
  ];
};

  networking.hostName = "owncloud";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;

  environment.systemPackages = with pkgs; [
  vim
  cifs-utils
  ];

  age.secrets.delenaNasCredentials = {
    file = ../../secrets/delena.nas.credentials.age;
  }; 

  fileSystems."/mnt/delena" = {
    device = "//10.10.10.3/delena";
    fsType = "cifs";
    options = [ "credentials=/run/agenix/delenaNasCredentials" "x-systemd.automount" "auto" "uid=1000" "gid=2000" "file_mode=0070" "dir_mode=0070" ];
  };

  users.groups.cloudper = {
    gid = 2000;
  };

  users.users.ronald.extraGroups = [
    "clouduser"
  ];

  # users.users.owncloud.extraGroups = [
  #   "clouduser"
  # ];

  networking.firewall.enable = false;
  system.stateVersion = "26.05";
}