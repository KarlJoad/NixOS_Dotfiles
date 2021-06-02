{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      <nixos-hardware/lenovo/thinkpad/t460s>
    ];

  boot = {
    loader = {
      grub = {
        enable = false;
        # Define on which hard drive you want to install Grub.
        device = "nodev"; # or "nodev" for efi only
        configurationLimit = 20; # Only keep the last 20 generations.
      };
      # generationsDir.enable = true;
      timeout = 10;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      systemd-boot = {
        enable = true;
        configurationLimit = 20; # Only keep the last 20 generations.
        consoleMode = "keep";
        editor = false;
        memtest86.enable = true;
      };
    };

    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7ed069ee-9dec-42e4-a1df-59b410f259d7";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7732-B943";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/7180a2c1-dae4-4dc3-95ad-2d8a77811520"; }
    ];

  # Disable the touchpad while typing on the keyboard.
  services.xserver.libinput.touchpad.disableWhileTyping = true;

  networking = {
    hostName = "Karl-Nixos";
    # wireless.enable = true;
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    # Interface-wide useDHCP will be deprecated, so per-interface useDHCP is used.
    # Use only the options below OR networkmanager, but not both.
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = false;
      wlp4s0.useDHCP = false;
    };
  };

  hardware.bluetooth.enable = true;
  # hardware.pulseaudio.extraModules = [ pkgs.pulseaudio-modules-bt ];
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  services.blueman.enable = false;

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
