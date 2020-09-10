{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthing
    syncthing-gtk # GUI client for syncthing application
  ];

  # Setup SyncThing
  services.syncthing = {
    enable = true;
    user = "karl";
    dataDir = "/home/karl/Syncthing";
    configDir = "/home/karl/.config/syncthing";
  };
}
