{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libreoffice-fresh-unwrapped
    texlive.combined.scheme-full
    pygmentex
    python38Packages.pygments # Needed for pygmentize
    python38Packages.pygments-markdown-lexer
    texstudio # Nice GUI for editing TeX stuff.
    gimp inkscape # Image creation and manipulation (Raster and Vector).

    okular zathura pdftk
  ];
}
