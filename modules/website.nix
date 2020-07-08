{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Personal Website
    jekyll
    bundler
  ];
}
