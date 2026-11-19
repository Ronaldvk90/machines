{ config, pkgs, lib, ... }:

{
  security.pki.certificateFiles = [
    ./bttf-ca.crt
  ];
}