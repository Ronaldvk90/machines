# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nix.settings.system-features = [
    "benchmark"
    "big-parallel"
    "kvm"
    "nixos-test"
    "gccarch-armv7-a"
  ];
  
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
  };

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    };
  
  # kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    environment = {
      WAYLAND_DISPLAY="wayland-1";
      DISPLAY = ":0";
    }; 
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  services.displayManager.sddm = {
    enable = true;
  
    wayland = {
      enable = true;
      };
  };

  programs.zsh.enable = true;
  virtualisation.podman = {
    enable = true;
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings.features.containerd-snapshotter = true;
    logDriver = "json-file";
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  security.sudo.wheelNeedsPassword = false;
  
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.cnijfilter2 ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  hardware.bluetooth.enable = false; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.binfmt = {
    emulatedSystems = [ "aarch64-linux" "armv7l-linux" ];
    preferStaticEmulators = true;
  };

  # boot.plymouth.enable = true; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "marty"; # Define your hostname.
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.bridges = {
    "br0" = {
      interfaces = [ "enp3s0" ];
    };
  };
  networking.interfaces.br0.ipv4.addresses = [ {
    address = "10.10.10.4";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "10.10.10.1";
  networking.nameservers = ["10.10.10.1"];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      font-awesome
      source-han-sans
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };
 
  security.pam.services.swaylock = {};
  security.pam.loginLimits = [
  { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
  ];

 
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
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
  grim # screenshot functionality
  slurp # screenshot functionality
  wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
  mako # notification system developed by swaywm maintainer
  avahi
  killall
  playerctl
  cifs-utils
  exfat
  htop
  pulseaudio
  nemo
  cdrkit
  bash
  wget
  gparted
  gsmartcontrol
  xsane
  qemu
  docker
  docker-buildx
  ntfs3g
  smartmontools
  inetutils
  dhcpcd
  xauth
  openvpn
  virt-manager
  virt-viewer
  spice
  spice-gtk
  spice-protocol
  usbredir
  vulkan-tools
  nmap
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ 2302 2303 2304 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
