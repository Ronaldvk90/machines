{ config, pkgs, lib, ... }:

{
  services.sabnzbd = {
    enable = true;
    user = "sabnzbd";
    group = "media";
    openFirewall = true; # Open de firewall-poorten voor de webinterface
    # settings = { ... }; # Optionele declaratieve instellingen
  };
}