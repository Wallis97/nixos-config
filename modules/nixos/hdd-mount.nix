{ ... }:
let
  mountPoint = "/home/vallii/hdd";
in
{
  fileSystems.${mountPoint} = {
    device = "/dev/disk/by-uuid/F438E74838E70906";
    fsType = "ntfs";
    options = [
      "nofail"
    ];
  };
}
