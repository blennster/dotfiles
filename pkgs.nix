{pkgs, ...}: {
  # These will also be part of system configuration
  tools = with pkgs; [
    jq
    fd
    htop
    btop
    ripgrep
    neovim
    sqlite
  ];
  java = with pkgs; [
    jdk
    maven
    gradle
    jdt-language-server
  ];
  nodejs = with pkgs; [
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
    # python310Packages.flake8
    # python310Packages.autopep8
    # nodePackages.pyright
  ];
  c = with pkgs; [
    gcc
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
  go = with pkgs; [go gopls];
  zig = with pkgs; [zig zls];
  nix = with pkgs; [alejandra nil];
  prog = with pkgs;
    []
    ++ java
    ++ rust
    ++ python
    ++ c
    ++ shell
    ++ zig
    ++ nodejs;
  nvim = with pkgs; [
    nodePackages.neovim
    # Lsps and the like
    lua-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    yamlfmt
  ];
}
