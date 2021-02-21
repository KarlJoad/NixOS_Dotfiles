# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 20; # Only keep the last 20 generations.
        consoleMode = "keep";
        editor = false;
        memtest86.enable = true;
      };
    };
  };

  networking = {
    hostName = "Karl-Desktop";
    networkmanager.enable = true;
    # Interface-wide useDHCP will be deprecated, so per-interface useDHCP is used.
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true;
    };
  };

  # Allow for my desktop to be reachable using the XRDP protocol
  services.xrdp.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "nouveau" ]; # "nvidiaLegacy390" "intel" ];
    config = lib.mkForce "";
    # defaultDepth = 24;
    # verbose = 7;
    # serverLayoutSection = ''
    #   Screen "Screen1" # RightOf "Screen-nvidia[0]"
    #   InputDevice "Mouse0" "CorePointer"
    #   InputDevice "Keyboard0" "CoreKeyboard"

    #   # Enable Xinerama to combine separate screens to a single one.
    #   Option "Xinerama" "On"
    # '';
    # monitorSection = ''
    #   # LG MP59HT Monitor
    #   VendorName      "Unknown"
    #   ModelName       "LG Electronics MP59HT"
    #   HorizSync       30.0 - 85.0
    #   VertRefresh     40.0 - 75.0
    #   Option          "DPMS"
    # '';
    # deviceSection = ''
    #   # GTX1080 Card
    #   VendorName      "NVIDIA Corporation"
    #   BoardName       "GeForce GTX 1080"
    #   BusID           "PCI:1:0:0"
    # '';
    # screenSection = ''
    #   DefaultDepth    24
    #   Option         "Stereo" "0"
    #   # Option         "nvidiaXineramaInfo" "True"
    #   # Option         "nvidiaXineramaInfoOrder" "DFP-0"
    #   Option         "metamodes" "nvidia-auto-select +0+0"
    #   Option         "SLI" "Off"
    #   Option         "MultiGPU" "Off"
    #   Option         "BaseMosaic" "Off"
    #   SubSection     "Display"
    #       Depth       24
    #   EndSubSection
    # '';
    # config = ''
    #   Section "InputDevice"
    #     Identifier    "Mouse0"
    #     Driver        "mouse"
    #     Option        "Protocol" "auto"
    #     Option        "Device" "/dev/input/mice"
    #     Option        "Emulate3Buttons" "no"
    #     Option        "ZAxisMapping" "4 5 6 7"
    #   EndSection

    #   Section "InputDevice"
    #     Identifier   "Keyboard0"
    #     Driver       "kbd"
    #   EndSection

    #   Section "Device"
    #     Identifier      "GTX980Ti"
    #     Driver          "nvidia"
    #     VendorName      "NVIDIA Corporation"
    #     BoardName       "GeForce GTX 980 Ti"
    #     BusID           "PCI:2:0:0"
    #   EndSection

    #   Section "Screen"
    #     Identifier     "Screen1"
    #     Device         "GTX980Ti"
    #     Monitor        "Monitor1"
    #     DefaultDepth   24
    #     # Option         "nvidiaXineramaInfo" "True"
    #     Option         "metamodes" "nvidia-auto-select +0+0 {AllowGSYNC=Off}"
    #     Option         "SLI" "Off"
    #     Option         "MultiGPU" "Off"
    #     Option         "BaseMosaic" "Off"
    #     SubSection     "Display"
    #         Depth       24
    #     EndSubSection
    #   EndSection

    #   Section "Monitor"
    #     Identifier      "Monitor1"
    #     VendorName      "HP"
    #     ModelName       "X20LED"
    #     HorizSync       0.0 - 0.0
    #     VertRefresh     0.0
    #     Option          "DPMS"
    #     Option          "RightOf" "Monitor[0]"
    #   EndSection
    # '';
    exportConfiguration = true; # Show xserver settings in xorg.conf file in /etc/X11/
  };

  hardware = {
    opengl.enable = true; # Enable OpenGL.
    # Update microcode. Address "Firmware Bug" startup messages.
    cpu.intel.updateMicrocode = true;
  };

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
