{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/fs.nix
      ./modules/graphical.nix
      ./modules/email.nix
      ./modules/doc-prep.nix
      ./modules/monitoring.nix
      ./modules/virtualization.nix
      ./modules/doc.nix
    ];

  boot = {
    cleanTmpDir = true;
    enableContainers = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    trustedUsers = [ "@wheel" "karl" ];
    nixPath = [ "nixpkgs=https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz" "nixos-config=/etc/nixos/configuration.nix" "home-manager=https://github.com/rycee/home-manager/archive/master.tar.gz" "/nix/var/nix/profiles/per-user/root/channels" ];
  };
  systemd.services.nix-gc.unitConfig.ConditionACPower = true; # Only run Nix GC if plugged into wall.

  networking = {
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

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
  time.timeZone = "Europe/Stockholm";

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    coreutils
    git wget
    unzip
    gnumake automake cmake
    zsh zsh-completions zsh-fast-syntax-highlighting zsh-git-prompt oh-my-zsh
    stow
    vim emacs
    home-manager
    spotify
    rxvt_unicode
    octave
    transmission
    pwgen
    sddm-kcm
    # displaylink
    openssl
    xdg_utils
    mkpasswd
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
  services.printing.enable = false;

  services.flatpak.enable = true;

  # Enable sound.
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  users.mutableUsers = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.karl = {
    isNormalUser = true;
    description = "Karl Hallsby";
    extraGroups = [ "wheel"
                    "docker"
                    "libvirtd"
                  ];
    packages = with pkgs; [ firefox ];
    shell = "${pkgs.zsh}/bin/zsh";
    # hashedPassword found with mkpasswd -m sha-512
    hashedPassword = "$6$SP0uXGjZaunNycZ$B7Yt8sdT26cq3Na0pfoGvE36De7cFdzP63JvbtV6myPglK4.LY1w/jFlbnkH9nCNR7qj8/ZztYTrzQYcUb9Ac1";
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable/";
}
