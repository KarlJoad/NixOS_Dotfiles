{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthing
    # Commented out because 0.9.4.4 is marked as broken
    # syncthing-gtk # GUI client for syncthing application
  ];

  # Setup SyncThing
  services.syncthing = {
    enable = true;
    user = "karl";
    dataDir = "/home/karl/Syncthing";
    configDir = "/home/karl/.config/syncthing";
  };
}
