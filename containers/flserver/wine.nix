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
    # "/home/ronald/.local/state/nix/profile/share/applications/Firstrun.desktop".source = ./Firstrun.desktop;
    "/etc/profiles/per-user/ronald/share/applications/Firstrun.desktop".source = ./Firstrun.desktop;
  };

  home.file."Desktop/READMEFIRST!!!.TXT" = {
    executable = true;
    text = ''
      Please place a folder named freelancer with the extracted freelancer iso in your Desktop folder with optional  IONCROSS FLserver operator named IFSO.exe in it 
      '';
  };
  
  home.file."Desktop/FreelancerInstaller" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      winetricks -q winxp
      winetricks -q vb6run
      winetricks -q riched30
      winetricks -q directplay

      # Freelancer itself.
      wine /home/ronald/Desktop/freelancer/SETUP.EXE

      # Ioncross (if present)
      if [ -f "/home/ronald/Desktop/freelancer/IFSO.exe" ]
      then
      wine /home/ronald/Desktop/freelancer/IFSO.exe
      else
      echo -e "\033[0;33mIoncross FLserver Operator not found. You can install it later if you want to. :)\033[0m"
    '';
  };

  xdg.configFile."oh-my-posh/easy-term.omp.json".source = ./easy-term.omp.json;

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