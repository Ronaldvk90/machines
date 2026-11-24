{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  networking = {
    hostName = "marty";
    domain = "bttf.lan";
    nameservers = [
      "10.10.10.1"
      "fd42:4242:4242:1::1"
    ];

    defaultGateway = "10.10.10.1";
    defaultGateway6 = "fe80::1";
    networkmanager.enable = false;
    useDHCP = false;
    bridges = {
      "br0" = {
        interfaces = [ "enp3s0" ];
      };
    };
  
    interfaces.br0 = {
      ipv4.addresses = [
      {
        address = "10.10.10.4";
        prefixLength = 24;
      } 
      ];

    ipv6.addresses = [
      {
        address = "fd42:4242:4242:1::4";
        prefixLength = 64;
      }
      ];
    };
  };

  home-manager.users.ronald = import ../../home/ronald/home.nix;

  environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  killall
  playerctl
  cifs-utils
  exfat
  htop
  cdrkit
  bash
  wget
  ntfs3g
  smartmontools
  inetutils
  vulkan-tools
  nmap
  ];

  networking.firewall.enable = false;

  system.stateVersion = "26.05"; # Did you read the comment?

}
