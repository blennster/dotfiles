{lib, ...}: {
  home.username = "s7000033439";
  home.homeDirectory = "/home/SONY/s7000033439";

  programs.kitty = {
    settings.shell = "/usr/bin/zsh";
    font.size = lib.mkForce 12;
  };
  programs.git = {
    enable = true;
    userName = "Emil Blennow";
    userEmail = "emil.blennow@sony.com";
    extraConfig = {init = {defaultBranch = "main";};};
  };
  home.file = {
    ".ssh/conf.d/10-kitty.conf".text = "Host * \n\tSetEnv TERM=xterm-256color";
  };
  imports = [./common.nix];
}
