{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libreoffice-fresh-unwrapped
    texlive.combined.scheme-full
    ispell hunspell
    pygmentex
    python38Packages.pygments # Needed for pygmentize
    python38Packages.pygments-markdown-lexer
    texstudio # Nice GUI for editing TeX stuff.
    gimp inkscape # Image creation and manipulation (Raster and Vector).
    pandoc # Plain-text converter

    # PDF viewers and editor
    okular pdfpc zathura pdftk

    # Graph Creators
    graphviz dot2tex
  ];
}
