{
  config,
  pkgs,
  ...
}: {
  home.username = "emil";
  home.homeDirectory = "/home/emil";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["IosevkaTerm"];})

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    (writeShellScriptBin "setup-flatpak" ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      flatpak install -y flathub com.discordapp.Discord
      flatpak install -y flathub com.spotify.Client
    '')
    (writeShellScriptBin "hm" ''
      (cd ~/.config/home-manager && $SHELL -i)
    '')
    nextcloud-client
    syncthing
    syncthingtray
    jq

    grml-zsh-config

    gcc
    rustc
    nodejs
    gnumake

    cargo

    # Nvim deps
    python310
    python310Packages.pynvim
    nodePackages.neovim

    # Lsps and the like
    alejandra
    lua-language-server
    nil
    nodePackages.bash-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    nodePackages.prettier
    shellcheck
  ];

  programs.go.enable = true;
  programs.firefox.enable = true;
  # programs.nextcloud-client.enable = true;
  # programs.syncthing = {
  #   enable = true;
  #   tray = true;
  # };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config" = {
      recursive = true;
      source = ./dot_config;
    };
    ".gnupg/gpg-agent.conf".text = "pinentry-program /run/current-system/sw/bin/pinentry";
    ".local/bin" = {
      recursive = true;
      executable = true;
      source = ./bin;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    # syntaxHighlighting.enable = true;
    enableSyntaxHighlighting = true;
    initExtraFirst = ''
      source $HOME/.nix-profile/etc/zsh/zshrc
      prompt off
    '';
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  home.shellAliases = {
    lg = "lazygit";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.sessionPath = [
    # "$HOME/.local/npm-packages/bin"
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  xdg.enable = true;

  programs.ssh = {
    matchBlocks. "*".setEnv = "SetEnv TERM=xterm-256color";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.kitty = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "Emil Blennow";
    userEmail = "emil.blennow99@gmail.com";
    signing = {
      key = "6E04DBAAC117B125";
      signByDefault = true;
    };
    extraConfig = {init = {defaultBranch = "main";};};
  };
  programs.lazygit = {
    enable = true;
  };
}
