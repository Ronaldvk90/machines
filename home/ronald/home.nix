{ config, pkgs, lib, ... }:

{
#  let
#    flathubApps = [
#     "com.vscodium.codium"
#     "org.gnome.Podcasts"
#    ];
#
#in {
#home.activation.flatpak = lib.hm.dag.entryAfter ["writeBoundary"] ''
#  ${pkgs.flatpak}/bin/flatpak remote-add --user --if-not-exists flathub \
#    https://flathub.org/repo/flathub.flatpakrepo
#
#  ${pkgs.flatpak}/bin/flatpak install --user -y flathub \
#    ${lib.concatStringsSep " " flathubApps}
#'';
  
  home.username = "ronald";
  home.homeDirectory = "/home/ronald";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    gzdoom
    openra
    dosbox
    pcsx2
    steam
    dvdplusrwtools
    cdrtools
    libreoffice
    remmina
    vlc
    signal-desktop
    feh
    sidplayfp
    libsidplayfp
    vice
    acme
    wineWow64Packages.stable
    winetricks
    firefox
    thunderbird
    unzip
    p7zip
    libdvdcss
    filezilla
    file
    remmina
    pavucontrol
    wimlib
    alsa-utils
    audacity
    c64-debugger
    gnome-podcasts
    vscodium
    whatsapp-electron
    rbdoom-3-bfg
    handbrake
    dmg2img
    nerd-fonts.hack
    cider-2
  ];

  home.file = {
    "./Pictures/wallpaper.jpg".source = ./Pictures/wallpaper.jpg;
    ".config/sway/config".source = ./configs/sway/config;
    ".config/sway/config.d/marty".source = ./configs/sway/config.d/marty;
    ".config/sway/config.d/biff".source = ./configs/sway/config.d/biff;
    ".config/sway/config.d/werkplaats".source = ./configs/sway/config.d/werkplaats;
    ".config/foot/foot.ini".source = ./configs/foot/foot.ini;
    ".config/swaybar/swaybar_marty.sh".source = ./configs/swaybar/swaybar_marty.sh;
    ".config/swaybar/swaybar_biff.sh".source = ./configs/swaybar/swaybar_biff.sh;
    ".config/swaybar/swaybar_werkplaats.sh".source = ./configs/swaybar/swaybar_werkplaats.sh;
    ".tmux.conf".source = ./configs/tmux/tmux.conf;
    ".config/pipewire/pipewire.conf.d/zeroconf-discover.conf".source = ./configs/pipewire/zeroconf-discover.conf;
  };

  xdg.configFile."oh-my-posh/easy-term.omp.json".source = ./configs/zsh/easy-term.omp.json;


#  home.activation.InstallHackFonts =
#    lib.hm.dag.entryAfter [ "installPackages" ] ''
#      ${pkgs.oh-my-posh}/bin/oh-my-posh font install Hack
#    '';

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    PODMAN_COMPOSE_WARNING_LOGS = "false";
  };

###########################################
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = "${config.xdg.configHome}/oh-my-posh/easy-term.omp.json";
  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set number relativenumber
      set mouse=a
    '';
    plugins = [
      pkgs.vimPlugins.nvim-tree-lua
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
  initContent = ''
    bindkey "^[[1;3D" backward-word
    bindkey "^[[1;3C" forward-word
    bindkey  "^[[H"   beginning-of-line
    bindkey  "^[[F"   end-of-line

    HISTFILE=~/.zsh_history
    HISTSIZE=10000
    SAVEHIST=10000
    setopt appendhistory
  '';
  };
 
  programs.git = {
    package = pkgs.git;
    enable = true;
    #settings.user.name = "Ronald van Kouwen";
    #settings.user.email = "ronaldvk90@outlook.com";
      settings = {
        user.name = "Ronald van Kouwen";
	user.email = "Ronaldvk90@outlook.com";
	url."git@github.com:".insteadOf = "https://github.com/";
      };
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    secureSocket = false;
    mouse = true;
    clock24 = true;
    historyLimit = 50000;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
  };

  programs.tmate = {
    enable = true;
  };

###############################################
  #nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
