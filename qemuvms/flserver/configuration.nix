{ config, pkgs, lib, modulesPath, ... }:

{
 home-manager.users.ronald = {
  imports = [
    ../../home/ronald/server.nix
    ./flserver.nix
  ];
};

  networking.hostName = "flserver";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.package = pkgs.openresolv;
  networking.firewall.enable = false;

# networking = {
#   enableIPv6 = false;
#   firewall.enable = false;
#   hostName = "flserver";
#   domain = "bttf.lan";
#   dhcpcd.enable = false;
#   useDHCP = false;
#   useHostResolvConf = false;
# };

# systemd.network = {
#   enable = true;
#   networks."50-enp5s0" = {
#     matchConfig.Name = "enp5s0";
#     address = [ "10.10.10.xx/24" ];
#     networkConfig = {
#       Gateway = "10.10.10.1";
#       DNS = [ "10.10.10.1" ];
#     };
      
#     linkConfig = {
#       RequiredForOnline = "routable";
#       MACAddress = "xx:xx:xx:xx:xx:xx";
#     };
#   };
# };

############# SSH host key deployment ############
  age.secrets."ssh_host_ed25519_key" = {
    file = ./ssh_host_ed25519_key.age;
    path = "/etc/ssh/ssh_host_ed25519_key";
  };

  age.secrets."ssh_host_rsa_key" = {
    file = ./ssh_host_rsa_key.age;
    path = "/etc/ssh/ssh_host_rsa_key";
  };
##################################################

  environment.systemPackages = with pkgs; [
  vim
  ];
  networking.enableIPv6 = false;
  system.stateVersion = "26.05";
}