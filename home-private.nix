{lib, ...}: {
  home.username = "emil";
  home.homeDirectory = "/home/emil";
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
  programs.ssh = {
    enable = true;
    matchBlocks."*" = {setEnv = {TERM = "xterm-256color";};};
  };
  home.file = {
    ".gnupg/gpg-agent.conf".text = "pinentry-program /run/current-system/sw/bin/pinentry";
  };

  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/extensions" = {
      enabled-extensions = ["appindicatorsupport@rgcjonas.gmail.com" "gsconnect@andyholmes.github.io" "syncthing@gnome.2nv2u.com"];
    };
    "org/gtk/settings/file-chooser" = {sort-directories-first = true;};
    "org/gtk/gtk4/settings/file-chooser" = {sort-directories-first = true;};
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = ["<Super>Tab"];
      switch-applications-backward = ["<Shift><Super>Tab"];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };
    "org/gnome/desktop/background" = {
      picture-uri = "/home/emil/.local/share/wallpapers/nix-wallpaper-nineish.svg";
      picture-uri-dark = "/home/emil/.local/share/wallpapers/nix-wallpaper-nineish-dark-gray.svg";
    };
    "org/gnome/desktop/input-sources" = {
      sources = [(mkTuple ["xkb" "se"])];
    };
    "org/gnome/desktop/interface" = {
      monospace-font-name = "IosevkaTerm NFM 12";
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };
    "org/gnome/TextEditor" = {restore-session = false;};
  };
  imports = [./common.nix];
}
