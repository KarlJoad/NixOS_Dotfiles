{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbutils # Additional USB device utilities
    cifs-utils # Utilities for mounting remote SMB/CIFS shares
    cryptsetup # Utilities for opening encrypted items.
  ];
}
