{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./host.nix
      <home-manager/nixos>
      ./modules/fs.nix
      ./modules/graphical.nix
      ./modules/email.nix
      ./modules/dev.nix
      ./modules/website.nix
      ./modules/sync.nix
      ./modules/doc-prep.nix
      ./modules/monitoring.nix
      ./modules/multimedia.nix
      ./modules/virtualization.nix
      ./modules/games.nix
      ./modules/doc.nix
      ./modules/zoom.nix
      ./modules/kdeconnect.nix
      # ./remotefs/tor.nix ./remotefs/huginn.nix
      ./remotefs/triangle.nix
      ./remotefs/personal.nix
    ];

  boot = {
    cleanTmpDir = true; # Empty /tmp/ at every boot
    enableContainers = true; # https://nixos.org/nixos/manual/index.html#ch-containers
    supportedFilesystems = [ "ntfs" ]; # Allow me to mount NTFS partitions
    binfmt.emulatedSystems = [ "aarch64-linux" ]; # Cross-compile for aarch64 using QEMU
  };

  nix = {
    readOnlyStore = true; # Make /nix/store a read-only bind-mount
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    autoOptimiseStore = true;
    # checkConfig = true;
    useSandbox = true; # Explicitly sandbox program when building them
    # When this is set, nix.useSandbox is true, which is useful for nixpkgs Pull Requests.
    trustedUsers = [ "@wheel" "karl" ];
    nixPath = [
      "nixpkgs=https://channels.nixos.org/nixos-${config.system.stateVersion}/nixexprs.tar.xz"
      # "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos" # Default nixpkgs
      "nixos-config=/etc/nixos/configuration.nix"
      "home-manager=https://github.com/nix-community/home-manager/archive/release-${config.system.stateVersion}.tar.gz"
      "unstable=https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz"
      "nixos-hardware=https://github.com/NixOS/nixos-hardware/archive/master.tar.gz"
      "/nix/var/nix/profiles/per-user/root/channels" ];
  };

  # This overlay extends the definition of nixpkgs, so that when we use the scoping
  # tool `with pkgs;' by default, we take packages from the stable channel. If we
  # want something from the unstable channel, we just preface the package with
  # unstable. For example:
  # pkgs.mu => v1.2.x
  # pkgs.unstable.mu => v 1.4.y
  nixpkgs.overlays = [(self: super: {
    unstable = import <unstable> {
      # pass the nixpkgs config to the unstable alias
      # The config = ... Ensures changes made to packages in the standard nixpkgs
      # carry through.
      config = config.nixpkgs.config;
    };

    emacs = super.emacs.override { withXwidgets = true; };
  })];

  nixpkgs.config.permittedInsecurePackages = [
    "go-1.14.15"
  ];

  # Only run these Nix store services if plugged into wall.
  systemd.services = {
    nix-gc.unitConfig.ConditionACPower = true;
    nix-optimise.unitConfig.ConditionACPower = true;
  };

  networking = {
    # Global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future.
    useDHCP = false;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    coreutils moreutils
    git wget
    unzip
    gnumake automake cmake
    rxvt_unicode alacritty
    pciutils lsof
    squashfsTools
    inetutils

    pinentry gnupg

    # Some Nix tools
    nix-index

    zsh zsh-completions zsh-fast-syntax-highlighting zsh-git-prompt oh-my-zsh
    stow
    vim
    emacs
    home-manager

    tree
    ark
    yt-dlp #  Replacement for youtube-dl that is MUCH faster
    remmina

    firefox
    nyxt
    xclip xsel # Programs that nyxt needs to interact with the clipboard
    # torbrowser
    transmission-gtk

    slack discord
    element-desktop

    octaveFull
    # sage # Commented out as sage is marked as broken.
    # scilab # Commented out as scilab-4.1.2 is marked as broken.

    transmission
    pwgen
    openconnect # For IIT VPN

    sddm-kcm

    plasma-pa
    kate
    kompare
    gwenview
    konversation

    calibre

    openssl
    xdg_utils
    mkpasswd
    pass

    # displaylink
    alsaUtils
    pavucontrol
  ];
  environment.shells = [ pkgs.bash pkgs.zsh pkgs.fish ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;
  # Allow my SSH to receive and forward X11 sessions
  programs.ssh.forwardX11 = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    27017 # MongoDB
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ gutenprint gutenprintBin
                                           brlaser brgenml1lpr brgenml1cupswrapper ];

  services.flatpak.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Automatically trim SSDs
  services.fstrim.enable = true;

  # Even though mutableUsers is false, root's password should still be set manually
  # with the prompt that `nixos-install` has after finishing installation.
  users.mutableUsers = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.karl = {
    isNormalUser = true;
    description = "Karl Hallsby";
    extraGroups = [ "wheel"
                    "dialout"
                    "docker"
                    "kvm"
                    "libvirtd"
                    "networkmanager"
                    "video"
                    "plugdev" # For keyboard configuration
                  ];
    packages = with pkgs; [ ];
    shell = "${pkgs.zsh}/bin/zsh";
    # hashedPassword found with mkpasswd -m sha-512
    hashedPassword = "$6$SP0uXGjZaunNycZ$B7Yt8sdT26cq3Na0pfoGvE36De7cFdzP63JvbtV6myPglK4.LY1w/jFlbnkH9nCNR7qj8/ZztYTrzQYcUb9Ac1";
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  services.emacs = {
    install = true; # Whether to create the emacs server user service
    enable = true; # Whether to start the emacs server user service
  };

  # Should really be in /etc/udev/rules.d/50-wally.rules
  services.udev.extraRules = ''
    # Teensy rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

    # STM32 rules for the Moonlander and Planck EZ
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
    MODE:="0666", \
    SYMLINK+="stm32_dfu"
  '';

  system = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "22.11"; # Did you read the comment?
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      channel = "https://channels.nixos.org/nixos-unstable/";
    };
  };
}
