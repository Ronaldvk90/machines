{ config, pkgs, lib, ... }:

{
  security.pam.services.sshd = {
    googleAuthenticator = {
      enable = true;
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
}