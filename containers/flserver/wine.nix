{ config, pkgs, lib, ... }:

{
  home.username = "ronald";
  home.homeDirectory = "/home/ronald";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    nerd-fonts.hack
    wine
    winetricks
    bash
  ];

  home.file = {
    "/home/ronald/firstrun.sh".source = ./firstrun.sh;
    # "/home/ronald/.local/share/applications/Firstrun.desktop".source = ./Firstrun.desktop;
    "/home/ronald/.local/state/nix/profile/share/applications/Firstrun.desktop".source = ./Firstrun.desktop;
  };

  # home.activation.winetricks = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   export WINEPREFIX="$HOME/.wine"

  #   ${pkgs.winetricks}/bin/winetricks -q winxp
  #   ${pkgs.winetricks}/bin/winetricks -q vb6run
  #   ${pkgs.winetricks}/bin/winetricks -q riched30
  #   ${pkgs.winetricks}/bin/winetricks -q directplay
  # '';
  
  # xdg.enable = true;
  # xdg.dataHome = "/home/ronald/.local/share";
  xdg.configFile."oh-my-posh/easy-term.omp.json".source = ./easy-term.omp.json;

  # xdg.desktopEntries.Firstrun = {
  #   name = "Freelancer";
  #   comment = "Install the Freelancer server";
  #   exec = "/home/ronald/firstrun.sh";
  #   icon = "applications-games";
  #   terminal = true;
  #   categories = [ "Game" ];
  # };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = "${config.xdg.configHome}/oh-my-posh/easy-term.omp.json";
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
      settings = {
        user.name = "Ronald van Kouwen";
	      user.email = "Ronaldvk90@outlook.com";
      };
  };

  programs.home-manager.enable = true;
}