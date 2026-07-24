{ config, pkgs, lib, modulesPath, ... }:

{  
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;

  imports = [
    # Include the default incus configuration.
    "${modulesPath}/virtualisation/incus-virtual-machine.nix"
  ];

  home-manager.users.ronald = import ../../home/ronald/server.nix;

  environment.systemPackages = with pkgs; [
  vim
  killall
  htop
  smartmontools
  inetutils
  nmap
  ];

  networking.firewall.enable = false;

  system.stateVersion = "26.05";
}