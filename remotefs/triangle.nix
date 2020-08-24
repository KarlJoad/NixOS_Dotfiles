{ config, pkgs, ... }:

{
  fileSystems."/mnt/Triangle/CourseFiles" = {
    device = "//198.37.25.250/ClassFiles";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.triangleSMBcredentials"];
  };
  fileSystems."/mnt/Triangle/Movies" = {
    device = "//198.37.25.250/Movies";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.triangleSMBcredentials"];
  };
  fileSystems."/mnt/Triangle/Textbooks" = {
    device = "//198.37.25.250/Textbooks";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.triangleSMBcredentials"];
  };
  fileSystems."/mnt/Triangle/TV" = {
    device = "//198.37.25.250/TV";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.triangleSMBcredentials"];
  };
  fileSystems."/mnt/Triangle/MeetingMinutes" = {
    device = "//198.37.25.250/MeetingMinutes";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,vers=default,iocharset=utf8,uid=1000,gid=100,rw,file_mode=0644,dir_mode=0755,nounix,nobrl";
    in ["${automount_opts},credentials=/root/.triangleSMBcredentials"];
  };
}
