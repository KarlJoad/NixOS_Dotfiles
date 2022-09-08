{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    # Text editors
    vscode vim
    # IDEs
    jetbrains.pycharm-community
    eclipses.eclipse-java
    # Version Control Systems
    git
    # nix-shell management for building projects, to be used with Lorri
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
    glibcInfo

    # Rust
    # We only need rustup. We can then use rustup to install rustc and cargo versions that match each other.
    rustup
    rust-analyzer
    # Additional Packages
    rustfmt clippy

    # Java
    jdk11
    gradle gradle-completion

    # Python
    python3 # Since Python 2.x is EOL, forget about it, and just have Python 3

    # SML (Standard ML) of New Jersey
    smlnj

    # Haskell
    ghc
    hlint

    # Nix
    nixfmt

    # GNU Guile Scheme
    guile
    guile-fibers
    guile-lib
    guile-lint
    guile-ncurses
    guile-reader

    # Common Lisp
    sbcl
  ];

  services.lorri.enable = true;
  services.rpcbind.enable = true;
}
