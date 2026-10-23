{ pkgs, ... }:

{
  services.openssh.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "Europe/Amsterdam";
  nixpkgs.config.allowUnfree = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk.enable = true;
  };

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
  services.displayManager.defaultSession = "xfce";

  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    tmux
    cifs-utils
    nfs-utils
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome
    source-han-sans
    bluez
    avahi
    pulseaudio
    zsh
    bash
    gparted
    gsmartcontrol
  ];

  system.stateVersion = "26.05";
}