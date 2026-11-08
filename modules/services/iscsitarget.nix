{ config, pkgs, lib, ... }:

{
  services.target = {
    enable = true;

    #targets = {
    #  "iqn.2026-11.lan.bttf:doc" = {
    #    # hier komt de target-configuratie
    #  };
    };
  };
}