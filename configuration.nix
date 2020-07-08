{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/fs.nix
      ./modules/graphical.nix
      ./modules/email.nix
      ./modules/dev.nix
      ./modules/doc-prep.nix
      ./modules/monitoring.nix
      ./modules/multimedia.nix
      ./modules/virtualization.nix
      ./modules/games.nix
      ./modules/doc.nix
      ./remotefs/tor.nix ./remotefs/huginn.nix
    ];

  boot = {
    cleanTmpDir = true; # Empty /tmp/ at every boot
    enableContainers = true; # https://nixos.org/nixos/manual/index.html#ch-containers
    supportedFilesystems = [ "ntfs" ]; # Allow me to mount NTFS partitions
  };

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
    trustedUsers = [ "@wheel" "karl" ];
    nixPath = [
      "nixpkgs=https://channels.nixos.org/nixos-20.03/nixexprs.tar.xz"
      # "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos" # Default nixpkgs
      "nixos-config=/etc/nixos/configuration.nix"
      "home-manager=https://github.com/rycee/home-manager/archive/master.tar.gz"
      "unstable=https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz"
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
  })];

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
    coreutils
    git wget
    unzip
    gnumake automake cmake
    rxvt_unicode alacritty
    pciutils lsof
    squashfsTools

    zsh zsh-completions zsh-fast-syntax-highlighting zsh-git-prompt oh-my-zsh
    stow
    vim emacs
    home-manager

    tree
    ark
    youtube-dl

    firefox
    torbrowser
    transmission-gtk

    slack discord

    octave sage
    # scilab # Commented out as scilab-4.1.2 is marked as broken.

    transmission
    pwgen

    sddm-kcm
    kdeApplications.kate
    kdeApplications.kompare
    kdeApplications.gwenview
    konversation

    calibre

    openssl
    xdg_utils
    mkpasswd
    pass

    # displaylink
  ];
  environment.shells = [ pkgs.bash pkgs.zsh ];

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
  services.openssh.enable = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.flatpak.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Even though mutableUsers is false, root's password should still be set manually
  # with the prompt that `nixos-install` has after finishing installation.
  users.mutableUsers = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.karl = {
    isNormalUser = true;
    description = "Karl Hallsby";
    extraGroups = [ "wheel"
                    "docker"
                    "libvirtd"
                    "networkmanager"
                    "video"
                  ];
    packages = with pkgs; [ ];
    shell = "${pkgs.zsh}/bin/zsh";
    # hashedPassword found with mkpasswd -m sha-512
    hashedPassword = "$6$SP0uXGjZaunNycZ$B7Yt8sdT26cq3Na0pfoGvE36De7cFdzP63JvbtV6myPglK4.LY1w/jFlbnkH9nCNR7qj8/ZztYTrzQYcUb9Ac1";
  };

  services.emacs = {
    install = true;
    enable = true;
  };

  system = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "20.03"; # Did you read the comment?
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      channel = "https://channels.nixos.org/nixos-unstable/";
    };
  };
}
