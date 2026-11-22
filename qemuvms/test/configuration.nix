{ config, pkgs, lib, modulesPath, ... }:

{
  networking.hostName = "test";
  networking.domain = "bttf.lan";
  networking.networkmanager.enable = true;

# networking = {
#   enableIPv6 = true;
#   firewall.enable = false;
#   hostName = "test";
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

  home-manager.users.ronald = import ../../home/ronald/server.nix;

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
  killall
  htop
  smartmontools
  inetutils
  nmap
  ];

  networking.firewall.enable = false;

  system.stateVersion = "26.05";
}