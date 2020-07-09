# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20; # Only keep the last 20 generations.
        consoleMode = "keep";
        editor = false;
        memtest86.enable = true;
      };
    };

    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e9cfae6e-91e4-47dc-a018-4b111f13d8f3";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B92A-E549";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/fae28b9f-66b7-48f3-9217-1b3275894290"; }
    ];

  networking = {
    hostName = "Karl-Desktop";
    networkmanager.enable = true;
    # Interface-wide useDHCP will be deprecated, so per-interface useDHCP is used.
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true;
    };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nouveau" ]; # "nvidia" ]; # "nvidiaLegacy390" "intel" ];
    defaultDepth = 24;
    serverLayoutSection = ''
      # Screen 0 "Screen-nouveau[0]"
      # Screen "Screen0"
      Screen "Screen1" RightOf "Screen-nouveau[0]"
      # Screen "Screen1" RightOf "Screen0"
      InputDevice "Mouse0" "CorePointer"
      InputDevice "Keyboard0" "CoreKeyboard"
      # Enable Xinerama to combine separate screens to a single one.
      Option "Xinerama" "Off"
    '';
    moduleSection = ''
      Load "glx"
    '';
    monitorSection = ''
      # LG MP59HT Monitor
      VendorName     "Unknown"
      ModelName      "LG Electronics MP59HT"
    '';
    deviceSection = ''
      # GTX1080 Card
      BusID "PCI:1:0:0"
    '';
    screenSection = ''
      Monitor        "multihead1"
      DefaultDepth    24
      Option         "Stereo" "0"
      Option         "Primary" "true"
      SubSection "Display"
        Modes   "1920x1080"
        Virtual 1920 1080
      EndSubSection

      # Option         "nvidiaXineramaInfoOrder" "DFP-0"
      # Option         "metamodes" "nvidia-auto-select +0+0"
      # Option         "SLI" "Off"
      # Option         "MultiGPU" "Off"
      # Option         "BaseMosaic" "Off"
    '';
    xrandrHeads = [ # Provides `Section "Monitor"` portions of the config.
      { output = "DVI-D-1";
        primary = true;
        monitorConfig = ''
          VendorName     "Unknown"
          ModelName      "LG Electronics MP59HT"
          Modeline       "1920x1080"
          Option       "DPMS" "true"
        '';
      }
      # { output = "DVI-I-1-1";
      #   primary = false;
      #   monitorConfig = ''
      #     VendorName     "Unknown"
      #     ModelName      "HP x20LED"
      #     HorizSync       24.0 - 83.0
      #     VertRefresh     50.0 - 76.0
      #     Option         "DPMS"
      #   '';
      #  }
    ];
    config = ''
      Section "Device"
        Identifier   "GTX980Ti"
        Driver       "nouveau"
        BusID        "PCI:2:0:0"
        Option       "Monitor-right" "multihead2"
      EndSection

      Section "Screen"
        Identifier   "Screen1"
        Device       "GTX980Ti"
        Monitor      "Monitor1"
        SubSection "Display"
          Modes   "1600x900"
          Virtual 1600 900
        EndSubSection
      EndSection

      Section "Monitor"
        Identifier   "Monitor1"
        VendorName   "HP"
        ModelName    "X20LED"
        Modeline     "1600x900"
        Option       "DPMS" "true"
      EndSection

      Section "InputDevice"
        Identifier   "Mouse0"
        Driver       "mouse"
        Option       "Protocol" "auto"
        Option       "Device" "/dev/input/mice"
        Option       "Emulate3Buttons" "no"
        Option       "ZAxisMapping" "4 5 6 7"
      EndSection

      Section "InputDevice"
        Identifier   "Keyboard0"
        Driver       "kbd"
      EndSection
    '';
# # END OF KARL CONFIGURATION
# ###########################
    exportConfiguration = true; # Change to false when done
  };

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
