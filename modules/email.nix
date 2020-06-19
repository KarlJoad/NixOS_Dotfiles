{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    msmtp # For sending mail using SMTP
    isync # Project name. Binary is mbsync
    # unstable.mu
    (import (fetchTarball "channel:nixos-unstable") {config = config.nixpkgs.config;}).mu
    # This one-liner is only used until NixOS bumps the version of mu to 1.4.x
    # The config = ... Ensures changes made to packages in the standard nixpkgs carry through
  ];
}
