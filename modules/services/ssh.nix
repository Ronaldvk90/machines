{ config, pkgs, lib, ... }:

{
  packages = with pkgs; [
    google-authenticator
  ];
  
  services = {
    openssh = {
      enable = true;
      settings ={
        PasswordAuthentication = true;
        PermitRootLogin = "no";
        KbdInteractiveAuthentication = true;
        ChallengeResponseAuthentication = true;
        };
      };
  };
  
  security.pam = {
    services.sshd.googleAuthenticator.enable = true;
  };
}