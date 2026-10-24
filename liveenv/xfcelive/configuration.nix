{ pkgs, ... }:

{
  programs.wireshark.enable = true;
  users.users.nixos.extraGroups = [ "wireshark" "networkmanager" ];
  virtualisation.incus.agent.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
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

  services.xserver.displayManager.lightdm.enable = false;

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  displayManager.startx.enable = true;
  };

  system.activationScripts.xinitrc.text = ''
    install -Dm755 ${pkgs.writeText "xinitrc" ''
     #!/bin/sh
     exec startxfce4
    ''} /home/nixos/.xinitrc
    chown nixos:users /home/nixos/.xinitrc
  '';

  security.polkit.extraConfig = ''
   polkit.addRule(function(action, subject) {
     if (subject.user == "nixos") {
       return polkit.Result.YES;
     }
   });
  '';

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
    networkmanager
    firefox
  ];

  system.stateVersion = "26.05";
}