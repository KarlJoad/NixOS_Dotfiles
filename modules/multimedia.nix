{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Music players
    spotify amarok clementine
    # Music tagger/Metadata Insertion tool
    picard
    # Video players
    plex-media-player vlc
  ];
}
