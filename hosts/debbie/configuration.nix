{ config, pkgs, ... }:

{ 
  # Ensure base graphics are enabled
  hardware.graphics.enable = true;

  # Enable 32-bit drivers for your system (e.g. for Wine/Steam)
  hardware.graphics.enable32Bit = true;

  networking.hostName = "debbie";
  networking.domain = "bttf.lan";
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };
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

  ##### VPN connection #####
  age.secrets.thuis-vpn = {
    file = ../../secrets/debbie.openvpn.credentials.age;
    path = "/etc/NetworkManager/system-connections/thuis.nmconnection";
  };

  home-manager.users.debbie = import ../../home/debbie/home.nix;

  environment.systemPackages = with pkgs; [
    vim
    git
    ntfs3g
  ];

  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  system.stateVersion = "26.05";
}