{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.hostName = "biff";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;

  ##### Wifi Networks #####
  age.secrets.Ziggo-ap-4d4efe6 = {
    file = ../../secrets/Ziggo-ap-4d4efe6.nmconnection.age;
    path = "/etc/NetworkManager/system-connections/Ziggo-ap-4d4efe6.nmconnection";
  };
  age.secrets.bttf-lan = {
    file = ../../secrets/bttf.lan.nmconnection.age;
    path = "/etc/NetworkManager/system-connections/bttf.lan.nmconnection";
  };

  home-manager.users.ronald = import ../../home/ronald/home.nix;
  
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    killall
    exfat
    htop
    cdrkit
    bash
    git
  ];

  networking.firewall.enable = false;

  system.stateVersion = "26.05"; # Did you read the comment?

}

