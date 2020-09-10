{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthing
    # xen
  ];

  # Setup SyncThing
  services.syncthing = {
    enable = true;
    user = "karl";
    dataDir = "/home/karl/Syncthing";
    configDir = "/home/karl/.config/syncthing";
  };
}
