{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  
  # Ensure base graphics are enabled
  hardware.graphics.enable = true;

  # Enable 32-bit drivers for your system (e.g. for Wine/Steam)
  hardware.graphics.enable32Bit = true;

  networking.hostName = "debbie"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable onedrive
  services.onedrive.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."debbie" = {
    isNormalUser = true;
    description = "Debbie Berendsen";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };
  
  home-manager.users.debbie = import ../../home/debbie/home.nix;

  # Enable Avahi MDNS.
  services.avahi.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    avahi
    ntfs3g
    wl-clipboard
  ];

  system.stateVersion = "26.05"; # Did you read the comment?

}
