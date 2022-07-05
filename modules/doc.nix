{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    man-pages
    posix_man_pages
    linux-manual # man(9) pages for kernel-internal functions
    w3m # For showing nixos-help in terminal
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
