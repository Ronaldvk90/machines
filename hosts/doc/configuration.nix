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

############# smbpasswd deployment ###############
  age.secrets.samba-passdb = {
    file = ../../secrets/samba-passdb.tdb.age;
    path = "/var/lib/samba/private/passdb.tdb";
    owner = "root";
    group = "root";
    mode = "0600";
  };
##################################################

############# mount the right home dir ###########
  fileSystems."/home" = {
    device = "storage/home";
    fsType = "zfs";
  };
##################################################

############# Spindown disks afer 15 min #########
services.udev.extraRules = 
  let
    mkRule = as: lib.concatStringsSep ", " as;
    mkRules = rs: lib.concatStringsSep "\n" rs;
  in mkRules ([( mkRule [
    ''ACTION=="add|change"''
    ''SUBSYSTEM=="block"''
    ''KERNEL=="sd[a-z]"''
    ''ATTR{queue/rotational}=="1"''
    ''RUN+="${pkgs.hdparm}/bin/hdparm -S 200 /dev/%k"''
  ])]);
##################################################

  networking.enableIPv6 = false;
  networking.firewall.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?
}