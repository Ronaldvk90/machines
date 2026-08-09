{ config, lib, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fluser = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "fluser";
    extraGroups = [ "wheel" ];
  };

  users.users.fluser.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFydz8KQpnXaXFtUijJdQtub7XyUB0rQSZEA2eAuXqsP"
  ];

  networking.hostName = "flserver";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;

  home-manager.users.fluser = import ./wine.nix;
  
  environment.systemPackages = with pkgs; [
    shadow
    vim
    wget
    killall
    exfat
    htop
  ];

  networking.firewall.enable = false;
  system.stateVersion = "26.05";
}

