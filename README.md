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
For the first installation, you must specify a path for the unstable, home-manager, and nixos-hardware channel to use, so that `<unstable>`, `<home-manager>`, and `nixos-hardware` are defined.

This is achieved with the command below.
```sh
nixos-install -I unstable=https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz \
	-I home-manager=https://https://github.com/nix-community/home-manager/archive/master.tar.gz \
	-I nixos-hardware=https://github.com/NixOS/nixos-hardware/archive/master.tar.gz
```

However, subsequent uses do **NOT** require that the path for those channels be specified, as the `nix.nixPath` configuration option saves those down for us.
