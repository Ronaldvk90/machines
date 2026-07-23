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

      # Nodig voor de TOTP challenge
      KbdInteractiveAuthentication = true;

      PubkeyAuthentication = true;

      # Zorgt ervoor dat PAM daadwerkelijk onderdeel
      # is van de SSH authentication flow.
      UsePAM = true;

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