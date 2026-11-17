{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "zabbix-zfs";
  version = "unstable-2026-11-17";

  src = fetchFromGitHub {
    owner = "blind-oracle";
    repo = "zabbix-zfs";
    rev = "master";
    hash = "sha256-XwsPYCbJB+IftsAqeCoK8gg0/uo/Lyf3WbjuMmvL+Oo=";
  };

  installPhase = ''
    mkdir -p $out/bin

    install -m 755 zfs.py $out/bin/zabbix-zfs

    substituteInPlace $out/bin/zabbix-zfs \
      --replace-fail \
        "/sbin/zpool" \
        "/run/current-system/sw/bin/zpool"

    substituteInPlace $out/bin/zabbix-zfs \
      --replace-fail \
        "/sbin/zfs" \
        "/run/current-system/sw/bin/zfs"

    substitute zfs.conf $out/zfs.conf \
      --replace-fail \
        "/etc/zabbix/scripts/zfs.py" \
        "/run/current-system/sw/bin/zabbix-zfs"
  '';
}