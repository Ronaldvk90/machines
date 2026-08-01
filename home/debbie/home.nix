{ config, pkgs, lib, ... }:

{
  home.username = "debbie";
  home.homeDirectory = "/home/debbie";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    steam
    libreoffice
    vlc
    signal-desktop
    google-chrome
    whatsapp-electron
    thunderbird
    pulseaudio
    teams-for-linux
  ];

  ##### Enable KDE connect #####
  services.kdeconnect.enable = true;
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  home.file = {
    ".config/pipewire/pipewire.conf.d/zeroconf-discover.conf".source = ./configs/pipewire/zeroconf-discover.conf;
  };

  #nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
