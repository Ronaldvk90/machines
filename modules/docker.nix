{ config, pkgs, lib, ... }:

{
  virtualisation.docker = {
    enable = true;
    daemon.settings.features.containerd-snapshotter = true;
    logDriver = "json-file";
  };

  environment.systemPackages = with pkgs; [
    docker
    docker-buildx
  ];
}