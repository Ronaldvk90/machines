{ config, pkgs, lib, ... }:

{
services.samba = {
  enable = true;
  security = "user";
  openFirewall = true;
  settings = {
    global = {
      "workgroup" = "bttf.lan";
      "server string" = "doc file server";
      "netbios name" = "doc";
      "security" = "user";
      "hosts allow" = "10.10.10. 10.10.20. 10.10.30. 127.0.0.1 localhost";
      "hosts deny" = "0.0.0.0/0";
      "guest account" = "nobody";
      "map to guest" = "bad user";
    };

    "homes" = {
      "comment" = "User dirs";
      "valid users" = "%S";
      "create mask" = "0700";
      "directory mask" = "0700";
      "browseable" = "no";
      "read only" = "no";
      "veto files" = "/.*/";
    };
  };
};

services.samba-wsdd = {
  enable = true;
  openFirewall = true;
};
}