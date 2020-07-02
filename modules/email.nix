{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    msmtp # For sending mail using SMTP
    isync # Project name. Binary is mbsync
    unstable.mu # mu indexes maildir stores and allows for searching
    # (import (fetchTarball "channel:nixos-unstable") {config = config.nixpkgs.config;}).mu
    # (import <unstable> {config = cofnig.nixpkgs.config;}).mu
  ];
}
