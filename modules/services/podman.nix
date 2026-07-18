{ config, pkgs, lib, ... }:

{
  # Podman Sysctl ports line
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 0;

  virtualisation.podman = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}