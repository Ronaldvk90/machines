{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/ata-CT500MX500SSD1_1906E1E8A9B1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      home = {
        device = "/dev/disk/by-id/nvme-KINGSTON_SNV2S500G_50026B7785A0AC6F";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            home = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
              };
            };
          };
        };
      };
    };
  }:
}