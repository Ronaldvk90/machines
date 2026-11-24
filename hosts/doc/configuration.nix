{ config, pkgs, lib, ... }:

{
  networking = {
    hostName = "doc";
    hostId = "e10601fd";
    domain = "bttf.lan";
    nameservers = [
      "10.10.10.1"
      "fd42:4242:4242:1::1"
    ];
    defaultGateway = "10.10.10.1";
    defaultGateway6 = "fe80::1";
    networkmanager.enable = false;
    useDHCP = false;
    interfaces.enp1s0 = {
      ipv4.addresses = [
        {
          address = "10.10.10.3";
          prefixLength = 24;
        } 
      ];

      ipv6.addresses = [
        {
          address = "fd42:4242:4242:1::3";
          prefixLength = 64;
        }
      ];
    };
  };

  home-manager.users.ronald = import ../../home/ronald/server.nix;

  environment.systemPackages = with pkgs; [
  (pkgs.callPackage ../../packages/zabbix-zfs.nix {})
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
    ''RUN+="${pkgs.hdparm}/bin/hdparm -B 90 -S 41 /dev/%k"''
  ])]);
##################################################

  networking.enableIPv6 = true;
  networking.firewall.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?
}