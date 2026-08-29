{ config, pkgs, lib, ... }:

{
  # 1. Install the tools package containing eeprog
  environment.systemPackages = with pkgs; [
    i2c-tools
  ];

  # 2. Force the kernel to load the i2c-dev driver at boot
  boot.kernelModules = [ "i2c-dev" ];
}