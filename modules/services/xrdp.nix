{ config, pkgs, lib, ... }:

{
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startxfce4";
  services.xrdp.audio.enable = true;
}