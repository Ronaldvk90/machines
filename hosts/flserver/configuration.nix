{ config, pkgs, lib, modulesPath, ... }:

{
 home-manager.users.ronald = {
  imports = [
    ../../home/ronald/server.nix
    ./flserver.nix
  ];
};

  networking.hostName = "flserver";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;

  environment.systemPackages = with pkgs; [
  vim
  ];

  networking.firewall.enable = false;
  system.stateVersion = "26.05";
}