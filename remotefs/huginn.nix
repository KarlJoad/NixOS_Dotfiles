{ config, pkgs, ... }:

{
  fileSystems."/mnt/Huginn/TV" = {
    device = "//192.168.20.10/TV";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.homeSMBcredentials"];
  };

  fileSystems."/mnt/Huginn/Movies" = {
    device = "//192.168.20.10/Movies";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.homeSMBcredentials"];
  };

  fileSystems."/mnt/Huginn/Processed" = {
    device = "//192.168.20.10/Processed";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.homeSMBcredentials"];
  };

  fileSystems."/mnt/Huginn/Recording" = {
    device = "//192.168.20.10/Recording";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.homeSMBcredentials"];
  };
}
