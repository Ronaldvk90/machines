{ config, pkgs, lib, ... }:

{
  networking.wg-thuis.interfaces = {
    wg0 = {
      address = [
        "10.10.30.3/32"
      ];

      # use dnscrypt, or proxy dns as described above
      dns = [ "10.10.10.1" ];
      privateKeyFile = config.age.secrets.biff.wireguard.path;
      peers = [
        {
          # bt wg conf
          publicKey = "arFhdxErrGtwkc/hOAStxi8+KgDHX3yjNcJKfrvwFDg=";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "178.224.208.28:51820";
        }
      ];
    };
  };
}