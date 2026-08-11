# Declarative layout for a replaceable single system disk.
{ lib, ... }:

{
  disko.devices.disk.main = {
    type = "disk";

    # Deliberately invalid unless the installer supplies --disk main. This
    # makes an incomplete recovery command fail instead of selecting whichever
    # disk happens to be /dev/nvme0n1.
    device = lib.mkDefault "/dev/disk/by-id/REPLACE-ME";

    content = {
      type = "gpt";
      partitions = {
        ESP = {
          # Keep these labels stable: the current hd disk already uses EFI and
          # root, so this same configuration is safe before and after a disk
          # replacement.
          label = "EFI";
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };

        root = {
          label = "root";
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

  # NixOS creates this file automatically when it does not exist yet.
  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];
}
