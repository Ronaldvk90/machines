{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    google-authenticator
  ];
  
  services = {
    openssh = {
      enable = true;
      settings ={
        PasswordAuthentication = true;
        PermitRootLogin = "no";
        KbdInteractiveAuthentication = true;
        };
      };
  };

  programs.ssh = {
  extraConfig = ''
    ChallengeResponseAuthentication yes
    UsePAM yes
    '';
  };
  
  security.pam = {
    services.sshd.googleAuthenticator.enable = true;
  };
}