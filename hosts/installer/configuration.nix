{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    disko
    nfs-utils
    cifs-utils
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.networkmanager.enable = true;
}