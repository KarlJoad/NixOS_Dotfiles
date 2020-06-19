{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libreoffice-fresh-unwrapped
    texlive.combined.scheme-full
    texstudio # Nice GUI for editing TeX stuff.
    gimp inkscape # Image creation and manipulation (Raster and Vector).

    okular zathura pdftk
  ];
}
