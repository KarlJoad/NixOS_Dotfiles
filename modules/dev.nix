{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    # Text editors
    vscode vim emacs
    # IDEs
    jetbrains.pycharm-community
    eclipses.eclipse-java
    # Version Control Systems
    git
    # nix-shell management for building projects
    direnv

    # Build tooling for most languages
    gnumake cmake automake
    # Source code Tag system
    global

    # Debugging
    gdb

    # C/C++/C#
    gcc clang
    ccls # C/C++ Language Server
    clang-analyzer
    clang-tools clang-manpages

    # Rust
    rustc
    cargo
    rls # Rust Language Server
    rustup
    # Additional Packages
    rustracer
    rustfmt clippy

    # Java
    jdk
    gradle gradle-completion

    # Python
    python3 # Since Python 2.x is EOL, forget about it, and just have Python 3
    python37Packages.python-language-server

    # SML (Standard ML) of New Jersey
    smlnj

    # Haskell
    ghc
    hlint

    # Nix
    nixfmt
  ];

  services.lorri.enable = true;
}
