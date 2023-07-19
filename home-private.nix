{...}: {
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
    matchBlocks. "*".setEnv = "SetEnv TERM=xterm-256color";
  };
  home.file = {
    ".gnupg/gpg-agent.conf".text = "pinentry-program /run/current-system/sw/bin/pinentry";
  };
  imports = [./common.nix];
}
