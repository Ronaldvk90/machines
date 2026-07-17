{ pkgs, ... }:

{
  fileSystems."/nix" = {
    device = "/dev/disk/by-label/NIXSTORE";
    fsType = "ext4";
    neededForBoot = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    tmux
    disko
    cifs-utils
    nfs-utils
  ];

  system.stateVersion = "26.05";
}