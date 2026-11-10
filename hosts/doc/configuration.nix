{ config, pkgs, ... }:

{  
  networking.hostName = "doc";
  networking.hostId = "e10601fd";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;
  home-manager.users.ronald = import ../../home/ronald/server.nix;

  environment.systemPackages = with pkgs; [
  vim
  killall
  htop
  smartmontools
  inetutils
  nmap
  ];
  
############# SSH host key deployment ############
  age.secrets."ssh_host_ed25519_key" = {
    file = ./ssh_host_ed25519_key.age;
    path = "/etc/ssh/ssh_host_ed25519_key";
  };

  age.secrets."ssh_host_rsa_key" = {
    file = ./ssh_host_rsa_key.age;
    path = "/etc/ssh/ssh_host_rsa_key";
  };
##################################################

############# mount the right home dir. ##########
  fileSystems."/home" = {
    device = "storage/home";
    fsType = "zfs";
  };
##################################################

  networking.enableIPv6 = false;
  networking.firewall.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?
}