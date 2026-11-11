{ config, pkgs, lib, ... }:

{
  boot.zfs.forceImportRoot = false;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "storage" ];

  environment.systemPackages = with pkgs; [
    zfs
  ];

  services.zfs.trim.enable = true;
  
  age.secrets.msmtp = {
    file = "../../secrets/msmtp.age";
  };

  # for zed enableMail, enable sendmailSetuidWrapper
  services.mail.sendmailSetuidWrapper.enable = true;

  programs.msmtp = {
    enable = true;
    setSendmail = true;
    defaults = {
      aliases = "/etc/aliases";
      port = 587;
      auth = "plain";
      tls = "on";
      tls_starttls = "on";
    };
    accounts = {
      default = {
        host = "smtp-mail.outlook.com";
        passwordeval = "cat ${config.age.secrets.msmtp.path}";
        user = "ronaldvk90@outlook.com";
        from = "ronaldvk90@outlook.com";
      };
    };
  };
}