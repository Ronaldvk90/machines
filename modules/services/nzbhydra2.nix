{ config, pkgs, lib, ... }:

{
  services.nzbhydra2 = {
    enable = true;
    # Optional: specify a custom data directory (defaults to /var/lib/nzbhydra2)
    dataDir = "/var/lib/nzbhydra2"; 
  };

  # Open the default NZBHydra2 web interface port in your firewall if accessing remotely
  networking.firewall.allowedTCPPorts = [ 5076 ];
}