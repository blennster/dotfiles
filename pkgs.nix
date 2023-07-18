{pkgs, ...}: {
  # These will also be part of system configuration
  tools = with pkgs; [
    jq
    fd
    htop
    btop
    ripgrep
    neovim
  ];
  prog = with pkgs; [
    cargo
    gcc
    gnumake
    go
    nodejs
    rustc
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
    gopls
    lua-language-server
    nil
    nodePackages.bash-language-server
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    yamlfmt
    rust-analyzer
    shellcheck
    shfmt
  ];
}
