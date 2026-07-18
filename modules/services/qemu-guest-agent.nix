{ config, pkgs, lib, ... }:

{
  # Qemu guest agent
  services.qemuGuest.enable = true;
}