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

  networking.firewall.enable = false;
  system.stateVersion = "26.05";
}