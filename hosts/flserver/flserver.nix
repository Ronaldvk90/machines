{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    wine
    winetricks
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
      Exec=/home/ronald/firstrun.sh
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
      wine /home/ronald/Desktop/freelancer/SETUP.EXE

      # Ioncross (if present)
      if [ -f "/home/ronald/Desktop/freelancer/IFSO.exe" ]
      then
      wine /home/ronald/Desktop/freelancer/IFSO.exe
      else
      echo -e "\033[0;33mIoncross FLserver Operator not found. You can install it later if you want to. :)\033[0m"
    '';
  };
}