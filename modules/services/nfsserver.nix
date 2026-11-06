{ config, pkgs, lib, ... }:

{
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /home    10.10.10.0/24(insecure,rw,sync,no_subtree_check)
    # /home    10.10.20.0/24(insecure,rw,sync,no_subtree_check)
    # /home    10.10.30.0/24(insecure,rw,sync,no_subtree_check)
  '';
}