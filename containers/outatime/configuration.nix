{ pkgs, modulesPath, ... }:

{
  imports = [
    # Include the default incus configuration.
    "${modulesPath}/virtualisation/lxc-container.nix"
  ];
  
  console.enable = true;
  boot.isContainer = true;
  nix.settings.sandbox = false;

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
    networks."50-eth0" = {
      matchConfig.Name = "wth0";
      address = [
        "10.10.10.11/24"
        "fd42:4242:4242:1::11"  
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
        MACAddress = "10:66:6a:56:c5:4e";
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