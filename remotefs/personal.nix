{ config, pkgs, ... }:

{
  fileSystems."/mnt/NAS" = {
    device = "//karl-nas.raven/Store";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.personalSMBcredentials"];
  };
}
