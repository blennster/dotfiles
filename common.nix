{pkgs, ...}: {
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs;
    [
      (nerdfonts.override {fonts = ["IosevkaTerm"];})

      (writeShellScriptBin "hm" ''
        (cd ~/.config/home-manager && zsh -i)
      '')
      (writeShellScriptBin "install-flatpak-pkgs" ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak install -y flathub com.discordapp.Discord
        flatpak install -y flathub com.spotify.Client
        flatpak install -y flathub com.github.tchx84.Flatseal
        flatpak install -y flathub us.zoom.Zoom
      '')
      (writeShellScriptBin "install-lvim" ''
        echo "Make sure to not install extensions, they are managed in hm"
        LV_BRANCH='release-1.3/neovim-0.9' \
        bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh) -- \
        --no-install-dependencies
      '')
      (writeShellScriptBin "patch-codeium" ''
        nix-shell -p patchelf --command 'fd language_server_linux_x64 ~/.local/share/.codeium -x patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)"'
      '')
      (writeShellScriptBin "install-sway" ''
        sudo pacman -S sway waybar swayidle swaylock wofi wob playerctl brightnessctl
      '')

      grml-zsh-config
      zsh-fast-syntax-highlighting
      brightnessctl
      playerctl
      bluetuith
      imv
    ]
    ++ (import ./pkgs.nix pkgs).tools
    ++ (import ./pkgs.nix pkgs).prog
    ++ (import ./pkgs.nix pkgs).nvim;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config" = {
      recursive = true;
      source = ./dot_config;
    };
    ".local" = {
      recursive = true;
      source = ./dot_local;
    };
    ".local/bin" = {
      # executable = true; # This does not work, set executable in git instead
      recursive = true;
      source = ./bin;
    };
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    # syntaxHighlighting.enable = true;
    initExtraFirst = ''
      source $HOME/.nix-profile/etc/zsh/zshrc # Load grml
      source $HOME/.nix-profile/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
      prompt off
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.kitty = {
    enable = true;
    package = pkgs.neovim; # "Dummy" package
    font = {
      package = pkgs.nerdfonts.override {fonts = ["IosevkaTerm"];};
      name = "IosevkaTerm NFM";
      size = 13;
    };
    keybindings = {
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "alt+5" = "goto_tab 5";
      "alt+6" = "goto_tab 6";
      "alt+7" = "goto_tab 7";
      "alt+8" = "goto_tab 8";
      "alt+9" = "goto_tab 9";
      "kitty_mod+t" = "new_tab_with_cwd";
      "kitty_mod+enter" = "new_window_with_cwd";
      "kitty_mod+right" = "next_window";
      "kitty_mod+down" = "next_window";
      "kitty_mod+left" = "previous_window";
      "kitty_mod+up" = "previous_window";
    };
    settings = {
      enable_audio_bell = false;
    };
    shellIntegration.enableZshIntegration = true;
  };
  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
    };
  };
}
