{ config, pkgs, lib, ... }:

{
  home.username = "fluser";
  home.homeDirectory = "/home/fluser";
  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    nerd-fonts.hack
    wine
    winetricks
    bash
  ];

  home.file."Desktop/READMEFIRST!!!.TXT" = {
    executable = true;
    text = ''
      Please place a folder named freelancer with the extracted freelancer iso in your Desktop folder with optional  IONCROSS FLserver operator named IFSO.exe in it 
      '';
  };
  home.file."Desktop/FLInstaller.desktop" = {
    text = ''
      [Desktop Entry]
      Version=1.0
      Type=Application
      Name=Firstrun
      Comment=Install the Freelancer server
      Exec=/home/fluser/firstrun.sh
      Icon=applications-games
      Path=
      Terminal=true
      StartupNotify=false
    '';
  };

  home.file."firstrun.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      winetricks -q winxp
      winetricks -q vb6run
      winetricks -q riched30
      winetricks -q directplay

      # Freelancer itself.
      wine /home/fluser/Desktop/freelancer/SETUP.EXE

      # Ioncross (if present)
      if [ -f "/home/fluser/Desktop/freelancer/IFSO.exe" ]
      then
      wine /home/fluser/Desktop/freelancer/IFSO.exe
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

  programs.home-manager.enable = true;
}