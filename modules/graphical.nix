{config, pkgs, ...}:

{
  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    layout = "us";

    # Enable touchpad support.
    libinput.enable = true;

    # Use the SDDM graphical login Display Manager
    displayManager = {
      sddm.enable = true;
    };
    # Enable the KDE Desktop Environment
    desktopManager = {
      plasma5.enable = true;
    };
    # Enable the xmonad and i3 Tiling window managers.
    windowManager = {
      xmonad.enable = false;
      i3.enable = false;
    };
  };
}
