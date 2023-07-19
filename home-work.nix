{lib, ...}: {
  home.username = "s7000033439";
  home.homeDirectory = "/home/SONY/s7000033439";
  programs.kitty.settings.shell = "/usr/bin/zsh";
  programs.kitty.font.size = lib.mkForce 12;
  programs.git.signing.signByDefault = lib.mkForce false;
  imports = [./common.nix];
}
