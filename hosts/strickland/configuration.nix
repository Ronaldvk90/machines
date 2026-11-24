{ config, pkgs, ... }:

{
  networking = {
    hostName = "strickland";
    hostId = "e46ea564";
    domain = "bttf.lan";
    nameservers = [
      "10.10.10.1"
      "fd42:4242:4242:1::1"
    ];
    defaultGateway = "10.10.10.1";
    defaultGateway6 = "fe80::1";
  };

  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.bridges = {
    "br0" = {
      interfaces = [ "eno1" ];
    };
  };
  
  networking.interfaces.br0 = {
    ipv4.addresses = [
      {
        address = "10.10.10.2";
        prefixLength = 24;
      } 
    ];

    ipv6.addresses = [
      {
        address = "fd42:4242:4242:1::2";
        prefixLength = 64;
      }
    ];
  };

  home-manager.users.ronald = import ../../home/ronald/server.nix;

  environment.systemPackages = with pkgs; [
  (pkgs.callPackage ../../packages/zabbix-zfs.nix {})
  storcli
  vim
  killall
  htop
  smartmontools
  inetutils
  nmap
  ];
  hardware.openrazer.enable = true;
  
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

  networking.enableIPv6 = true;
  networking.firewall.enable = false;

  system.stateVersion = "26.05"; # Did you read the comment?
}
