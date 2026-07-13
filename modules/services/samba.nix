{ config, pkgs, lib, ... }:

{
  ##Mount point on the NAS:#
  fileSystems."/mnt/ronald" = {
    device = "//10.10.10.3/ronald";
    fsType = "cifs";
    options = [ "credentials=/root/.ronald" "x-systemd.automount" "auto" "uid=1001" "gid=100" "file_mode=0700" "dir_mode=0700" ];
  };

  fileSystems."/mnt/debbie" = {
    device = "//10.10.10.3/debbie";
    fsType = "cifs";
    options = [ "credentials=/root/.debbie" "x-systemd.automount" "auto" "uid=1001" "gid=100" "file_mode=0700" "dir_mode=0700" ];
  };

#  fileSystems."/mnt/ps2" = {
#    device = "//10.10.10.3/ps2";
#    fsType = "cifs";
#    options = [ "credentials=/root/.ronald" "x-systemd.automount" "auto" "uid=1000" "gid=100" "file_mode=0700" "dir_mode=0700" ];
#  };

  environment.systemPackages = with pkgs; [
    cifs-utils
  ];
}