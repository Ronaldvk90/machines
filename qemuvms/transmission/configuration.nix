{ config, pkgs, lib, modulesPath, ... }:

{
  home-manager.users.ronald = import ../../home/ronald/server.nix;

  networking = {
    enableIPv6 = true;
    firewall.enable = false;
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-enp5s0" = {
      matchConfig.Name = "enp5s0";
      address = [
        "10.10.10.10/24"
        "fd42:4242:4242:1::10"  
      ];

      networkConfig = {
        Gateway = [
          "10.10.10.1"
          "fd42:4242:4242:1::1"
        ];

        DNS = [
          "10.10.10.1"
          "fd42:4242:4242:1::1"
        ];
      };
      
      linkConfig = {
        RequiredForOnline = "routable";
        MACAddress = "10:66:6a:91:76:a0";
      };
    };
  };

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

  system.stateVersion = "26.05";
}