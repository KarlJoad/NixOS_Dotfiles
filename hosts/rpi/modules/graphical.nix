{config, pkgs, ...}:

{
  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    videoDrivers = [ "modesetting" ];
    layout = "us";

    # Touchpad support.
    libinput.enable = false;

    # Graphical login Display Manager
    displayManager = {
      sddm.enable = false;
      lightdm.enable = true;
    };
    # Enable the xmonad and i3 Tiling window managers.
    windowManager = {
      openbox.enable = true;
      xmonad.enable = false;
      i3.enable = false;
    };
  };
}
