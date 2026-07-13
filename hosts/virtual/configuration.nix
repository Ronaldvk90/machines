{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "virtual"; # Define your hostname.
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ronald = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Ronald van Kouwen";
    extraGroups = [ "wheel" "docker" "libvirtd" "dialout" "scanner" "lp" "networkmanager" "video" ];
  };

  environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  git
  killall
  htop
  wget
  inetutils
  ];

  networking.firewall.enable = false;

  system.stateVersion = "26.05"; # Did you read the comment?
}
