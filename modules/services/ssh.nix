{ config, pkgs, lib, ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PubkeyAuthentication = true;

      PermitRootLogin = "no";

      AllowUsers = [ "ronald" ];

      X11Forwarding = true;
      AllowTcpForwarding = false;
      AllowAgentForwarding = false;

      LoginGraceTime = "20s";
      MaxAuthTries = 3;

      PerSourcePenalties =
       "crash:3600s authfail:3600s max:86400s";
    };
  };
}