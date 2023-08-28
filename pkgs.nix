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
  prog = with pkgs; [
    cargo
    gcc
    gnumake
    go
    nodejs
    rustc
    libstdcxx5
    zig
  ];
  nvim = with pkgs; [
    python310
    python310Packages.pynvim
    # python310Packages.flake8
    # python310Packages.autopep8
    # nodePackages.pyright

    nodePackages.neovim

    # Lsps and the like
    alejandra
    clang-tools
    clippy
    gopls
    lua-language-server
    nil
    nodePackages.bash-language-server
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    rust-analyzer
    rustfmt
    shellcheck
    shfmt
    yamlfmt
    zls
  ];
}
