# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  security.sudo.wheelNeedsPassword = false;
  
#  xdg.portal = {
#    enable = true;
#    wlr.enable = true;
#    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
#    config.common.default = "*";
#  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Bootloader.
  boot.binfmt = {
    emulatedSystems = [ "aarch64-linux" "armv7l-linux" ];
    preferStaticEmulators = true;
  };

  # boot.plymouth.enable = true; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "werkplaats"; # Define your hostname.
  networking.domain = "2switch";
  networking.extraHosts = "178.224.211.198 thuis";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";
 
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ronald = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Ronald van Kouwen";
    extraGroups = [ "wheel" "docker" "libvirtd" "dialout" "scanner" "lp" "networkmanager" "video" ];
    packages = with pkgs; [];
  };

  home-manager.users.ronald = import ../../home/ronald/home.nix;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  avahi
  killall
  playerctl
  cifs-utils
  htop
  pulseaudio
  nemo
  bash
  wget
  ntfs3g
  smartmontools
  inetutils
  dhcpcd
  exfat
  hfsprogs
  ];

  networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?

}
