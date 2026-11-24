{ config, pkgs, ... }:

{
  networking = {
    hostName = "strickland";
    hostId = "e46ea564";
    domain = "bttf.lan";
    nameservers = ["10.10.10.1"];
  };

  systemd.network = {
    netdevs = {
      "20-br0" = {
        netdevConfig = {
          Kind = "bridge";
          Name = "br0";
        };
      };
    };
  };

  networks = {
    "30-eno1" = {
      matchConfig.Name = "eno1";
      networkConfig = {
        Bridge = "br0";
      };

      linkConfig.RequiredForOnline = "enslaved";
    };

    "40-br0" = {
      matchConfig.Name = "br0";
      networkConfig.IPv6AcceptRA = true;
      address = [
        "10.10.10.2/24"
        "fd42:4242:4242:1::2/64"
      ];
      
      routes = [
        #{ Gateway = "fe80::1"; }
        { Gateway = "10.10.10.1"; }
      ];

      linkConfig = {
        RequiredForOnline = "routable";
      };
    };
  };

  # networking.networkmanager.enable = false;
  # networking.useDHCP = false;
  # networking.bridges = {
  #   "br0" = {
  #     interfaces = [ "eno1" ];
  #   };
  # };
  # networking.interfaces.br0.ipv4.addresses = [ {
  #   address = "10.10.10.2";
  #   prefixLength = 24;
  # } ];
  # networking.defaultGateway = "10.10.10.1";
  # networking.nameservers = ["10.10.10.1"];

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
