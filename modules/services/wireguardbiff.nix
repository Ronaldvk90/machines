{ config, pkgs, lib, ... }:

{
networking.wg-quick.interfaces.wg0.configFile = "/run/agenix/wg0";
}