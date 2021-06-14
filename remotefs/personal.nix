{ config, pkgs, ... }:

{
  fileSystems."/mnt/NAS" = {
    device = "192.168.1.5:/mnt/store";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" ];
  };
}
