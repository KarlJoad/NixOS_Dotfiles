{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    manpages
    posix_man_pages
  ];

  documentation = {
    enable = true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;
    man.enable = true;
    nixos.enable = true;
  };
}
