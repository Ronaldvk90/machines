{ config, pkgs, lib, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ronald = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Ronald van Kouwen";
    extraGroups = [ "wheel" "docker" "libvirtd" "dialout" "scanner" "lp" "networkmanager" "video" "incus-admin" ];
  };

  users.users.ronald.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFydz8KQpnXaXFtUijJdQtub7XyUB0rQSZEA2eAuXqsP"
  ];
}