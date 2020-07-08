{ config, pkgs, ... }:

{
  fileSystems."/mnt/Tor/Archive" = {
    device = "//192.168.20.11/Archive";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.homeSMBcredentials"];
  };

  fileSystems."/mnt/Tor/Backups" = {
    device = "//192.168.20.11/Backups";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.homeSMBcredentials"];
  };

  fileSystems."/mnt/Tor/Music" = {
    device = "//192.168.20.11/Music";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.homeSMBcredentials"];
  };

  fileSystems."/mnt/Tor/Photo" = {
    device = "//192.168.20.11/Photo";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.homeSMBcredentials"];
  };

  fileSystems."/mnt/Tor/Software" = {
    device = "//192.168.20.11/Software";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.homeSMBcredentials"];
  };
}
