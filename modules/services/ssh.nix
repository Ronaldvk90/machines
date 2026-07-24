{ config, pkgs, lib, ... }:

{
  security.pam.services.sshd = {
    googleAuthenticator.enable = true;

    rules.auth = {
      google_authenticator = {
        order = 11000;
        control = "required";
        modulePath =
          "${pkgs.google-authenticator}/lib/security/pam_google_authenticator.so";
      };
    };
  };

  services.openssh = {
    enable = true;
    openFirewall = true;

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = true;
      PubkeyAuthentication = true;
      UsePAM = true;

      AuthenticationMethods = "publickey,keyboard-interactive";

      PermitRootLogin = "no";
      AllowUsers = [ "ronald" ];

      X11Forwarding = false;
      AllowTcpForwarding = false;
      AllowAgentForwarding = false;

      LoginGraceTime = "20s";
      MaxAuthTries = 3;

      PerSourcePenalties =
        "crash:3600s authfail:3600s max:86400s";
    };
  };

  environment.systemPackages = with pkgs; [
    google-authenticator
  ];
}