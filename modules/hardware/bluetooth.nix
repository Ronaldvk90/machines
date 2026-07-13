{ config, pkgs, lib, ... }:

{
  hardware.bluetooth.enable = false;
  hardware.bluetooth.powerOnBoot = false;
}