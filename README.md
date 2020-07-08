# System-wide NixOS Configurations
This repository holds system-wide configurations made for several Hosts that I use.

Host-specific information and settings is placed in the corresponding file in `hosts/`.
**To use that particular host's configuration, you *MUST* make a symbolic link `ln -s ./hosts/<desired-system>.nix ./hardware-configuration.nix` outside the `hosts/` directory.**
Namely, you should end up with a `tree` output that looks similar to this:
```
├── configuration.nix
├── .git
│ ├── ...
├── .gitignore
├── hardware-configuration.nix -> ./hosts/thinkpad-T460S.nix
├── hosts
│ ├── thinkpad-T460S.nix
│ └── vm.nix
├── modules
│ ├── email.nix
│ └── graphical.nix
└── README.md
```

# To Install
For the first installation, you must specify a path for the unstable channel to use, so that `<unstable>` is defined for the overlay.

This is achieved with the command below.
```sh
nixos-install -I unstable=https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz
```
