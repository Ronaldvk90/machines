{ config, pkgs, lib, ... }:

{
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startxfce4";
}