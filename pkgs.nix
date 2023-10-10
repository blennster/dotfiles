{pkgs, ...}: let
  java = with pkgs; [
    jdk
    maven
    gradle
    jdt-language-server
  ];
  node_js = with pkgs; [
    nodejs
    nodePackages.prettier
    nodePackages.typescript-language-server
  ];
  rust = with pkgs; [
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt
  ];
  python = with pkgs; [
    python310
    python310Packages.pynvim
    python310Packages.flake8
    python310Packages.autopep8
    nodePackages.pyright
  ];
  c = with pkgs; [
    gcc
    gdb
    gnumake
    libstdcxx5
    # clang
    clang-tools
  ];
  shell = with pkgs; [
    nodePackages.bash-language-server
    shellcheck
    shfmt
  ];
  golang = with pkgs; [go gopls];
  ziglang = with pkgs; [zig zls];
  nix = with pkgs; [alejandra nil];
in {
  # These will also be part of system configuration
  tools = with pkgs; [
    jq
    fd
    htop
    btop
    ripgrep
    neovim
    sqlite
    openssl
    unzip
    ranger
    d2
    nmap
  ];
  prog = with pkgs;
    [efm-langserver]
    ++ c
    ++ golang
    ++ java
    ++ nix
    ++ node_js
    ++ python
    ++ rust
    ++ shell
    ++ ziglang;
  nvim = with pkgs; [
    nodePackages.neovim
    # Lsps and the like
    lua-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    yamlfmt
  ];
}
