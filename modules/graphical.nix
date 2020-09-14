{config, pkgs, ...}:

{
  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    layout = "us";

    # Enable touchpad support.
    libinput.enable = true;

    # Use the SDDM graphical login Display Manager
    displayManager = {
      sddm.enable = false;
      lightdm.enable = true;
    };
    # Enable the KDE Desktop Environment
    desktopManager = {
      plasma5.enable = true;
      wallpaper = {
        combineScreens = false;
        mode = "center";
        # The file ~/.background-image is used as a background image.
        # "center": Center the image on the background. If it is too small, it will be surrounded by a black border.
        # "fill": Like scale, but preserves aspect ratio by zooming the image until it fits. Either a horizontal or a vertical part of the image will be cut off.
        # "max": Like fill, but scale the image to the maximum size that fits the screen with black borders on one side.
        # "scale": Fit the file into the background without repeating it, cutting off stuff or using borders. But the aspect ratio is not preserved either.
        # "tile": Tile (repeat) the image in case it is too small for the screen.
      };
    };
    # Enable the xmonad and i3 Tiling window managers.
    windowManager = {
      xmonad.enable = false;
      i3.enable = false;
    };
  };

  # Needed for GTK/GNOME3 programs to write to their database files.
  programs.dconf.enable = true;
}
