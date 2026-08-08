{ config, pkgs, callPackage, ... }: {

  nixpkgs.config.pulseaudio = true;

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
  services.displayManager.defaultSession = "xfce";
}


# { config, pkgs, lib, ... }:

# {
#   services.xserver.enable = true;
#   services.xserver.desktopManager.xfce.enable = true;
# }