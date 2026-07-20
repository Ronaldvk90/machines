{ config, pkgs, lib, ... }:

{
  ##Mount point on the NAS:#
  fileSystems."/mnt/ronald" = {
    device = "//10.10.10.3/ronald";
    fsType = "cifs";
    options = [ "credentials=/run/agenix/ronaldNasCredentials" "x-systemd.automount" "auto" "uid=1000" "gid=2000" "file_mode=0770" "dir_mode=0770" ];
  };

  fileSystems."/mnt/debbie" = {
    device = "//10.10.10.3/debbie";
    fsType = "cifs";
    options = [ "credentials=/run/agenix/debbieNasCredentials" "x-systemd.automount" "auto" "uid=1000" "gid=2000" "file_mode=0770" "dir_mode=0770" ];
  };

#  fileSystems."/mnt/ps2" = {
#    device = "//10.10.10.3/ps2";
#    fsType = "cifs";
#    options = [ "credentials=/run/agenix/ronaldNasCredentials" "x-systemd.automount" "auto" "uid=1000" "gid=2000" "file_mode=0770" "dir_mode=0770" ];
#  };

  environment.systemPackages = with pkgs; [
    cifs-utils
  ];
}