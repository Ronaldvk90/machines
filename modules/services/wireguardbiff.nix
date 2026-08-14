{ config, pkgs, lib, ... }:

{
  networking.wg-quick.interfaces.wg0.configFile = "/run/agenix/wg0";
  systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [ ];
}