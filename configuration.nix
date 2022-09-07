{ config, pkgs, lib, ... }:
{
  imports =
    [ # ./modules/graphical.nix
      # ./modules/printing.nix
    ];

  # if you have a Raspberry Pi 2 or 3, pick this:
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_4_19;
  hardware.enableRedistributableFirmware = true;

  # A bunch of boot parameters needed for optimal runtime on RPi 3b+
  boot = {
    kernelParams = ["cma=256M"];
    cleanTmpDir = true;
    # NixOS wants to enable GRUB by default
    loader.grub.enable = false;
    loader.raspberryPi = {
      enable = true;
      version = 3;
      uboot.enable = true;
      firmwareConfig = ''
        gpu_mem=256
        force_turbo=1
      '';
    };
  };

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set time zone.
  time.timeZone = "America/Chicago";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    coreutils vim emacs git
    home-manager
    libraspberrypi
    syncthing
  ];

  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
    "/boot/firmware" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "vfat";
      options = [ "nofail" "noauto" ];
    };
  };

  # Preserve space by sacrificing documentation and history
  documentation.nixos.enable = false;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    readOnlyStore = true;
    useSandbox = true; # Explicitly sandbox program when building them
    # When this is set, nix.useSandbox is true, which is useful for nixpkgs Pull Requests.
    trustedUsers = [ "@wheel" "karl" ];
    nixPath = [
      "nixpkgs=https://channels.nixos.org/nixos-${config.system.stateVersion}/nixexprs.tar.xz"
      "nixos-config=/etc/nixos/configuration.nix"
      "home-manager=https://github.com/nix-community/home-manager/archive/release-${config.system.stateVersion}.tar.gz"
      "/nix/var/nix/profiles/per-user/root/channels" ];
  };

  # Configure SSH (server-side) access
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.forwardX11 = true;
  # Configure SSH (client-side) access
  programs.ssh.forwardX11 = true;

  services.znc = {
    enable = true;
    mutable = false; # Make the configuration file for ZNC immutable
    useLegacyConfig = false; # Do not need backwards compatibility.
    openFirewall = true; # ZNC uses TCP port 5000 by default.
    config = {
      # Listener.IPv4 = true;
      LoadModule = [ "adminlog" "webadmin" ];
      User.KarlJoad = {
        Admin = true;
        Nick = "KarlJoad";
        AltNick = "KarlJoad-";
        Pass.password = {
          Method = "sha256";
          Hash = "43df670d4ea6f514dbcb9f0adb74e9e1e770bce1d11207d25d87078064f297b4";
          Salt = "4Gjf8N.,V8xQ-)60zF7-";
        };
        Network.libera = {
          Server = "irc.libera.chat +6697 *password*";
          Chan = { "#nixos" = { }; "#home-manager" = { }; "#emacs" = { };
                   "#systemcrafters" = { }; "#nyxt" = { }; "#guix" = { };
                 };
          Nick = "KarlJoad";
          AltNick = "KarlJoad-";
          LoadModule = [ "nickserv" ];
          JoinDelay = 5; # Avoid joining channels before authenticating.
        };
        Network.oftc = {
          Server = "irc.oftc.net +6697 *password*";
          Chan = { "#buildroot" = { }; "#qemu" = { }; };
          Nick = "KarlJoad";
          AltNick = "KarlJoad-";
          LoadModule = [ "nickserv" ];
          JoinDelay = 5;
        };
      };
    };
  };

  # Setup SyncThing
  services.syncthing = {
    enable = true;
    user = "karl";
    dataDir = "/home/karl/Syncthing";
    configDir = "/home/karl/.config/syncthing";
  };

  # Use 1GB of additional swap memory in order to not run out of memory
  # when installing lots of things while running other things at the same time.
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  # Even though mutableUsers is false, root's password should still be set manually
  # with the prompt that `nixos-install` has after finishing installation.
  users.mutableUsers = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.karl = {
    isNormalUser = true;
    description = "Karl Hallsby";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [ ];
    shell = "${pkgs.zsh}/bin/zsh";
    hashedPassword = "$6$SP0uXGjZaunNycZ$B7Yt8sdT26cq3Na0pfoGvE36De7cFdzP63JvbtV6myPglK4.LY1w/jFlbnkH9nCNR7qj8/ZztYTrzQYcUb9Ac1";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDV72kcxMmp371A3ykTGhXeqP013CTKHJyvH/oDplx2IJvQhOULX+RTSyWLBIDU0UtKMlNyadnUCUkiOEL3VhtrogwEiuZ3FLwHOE3obwzWEE9IBdLe54SkdwMVuNUd+WzjlFEgMjKnfTJLQJsOYA5tbLdeiTCC9FLMr6dN31rMZaCU9ff68yvSpiA4YeGQ0Rr7P1eWDB7CoNbr/7ITq5vhuYc7PMzqU1P+ZHuQRfi3m7IhFEicqzsLcsENanhxuQqk29JO1jXfy44VRmYqvrEnYHE3vRmIi4fffE0zPKax5Jxwmi1AgaQsKlBFZgdM5WVAblO58g1ACqo8jIN2H7NVCqSK8vgxYzGgkKwgpgBBcT2wWgrfxUL9E1GBgf5+Z9xlxO4ZHHCYz6H2rb05Pz6cNIwsGPPpj7WDqAMZJOEBerC944HNROJ0VfH5rHNEUFKbMf+wGM4FWicMdU8KAUloGRPMoB9rHLwx4/M8mNUxaItIx6e6frJtA40jUH5hQIpH9nIxdZ6BR0r/+MDOQ5mBjUTB3Kau7pjBzx9ZhegAFPzOp27LwslxXWeXQmcTHoKybGzSOxNwrFt0VQ5HOMlnpGn9EEJLBdOkVY3SnWF5k0ZOmRCB/iJNVBUHTqJgUuC0hSAgk3M4GIZLCK6lYn/SV8PUqu6cxv6mdoXELF8e6Q== Karl-Desktop"
    ];
  };

  networking = {
    hostName = "Karl-Pi-NixOS";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22    # SSH
                          631   # CUPS Print Server Web GUI
                          5000 # ZNC
                          8384  # SyncThing
                          8080 # ZNC GUI
                        ];
    };
  };
}
