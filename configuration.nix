# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    "${builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz"}/modules/age.nix"
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.autoUpgrade.channel = "https://nixos.org/channels/nixos-23.05";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bmon
    btop
    curl
    fd
    file
    git
    gnupg
    pinentry-qt # Remove qt for gtk version
    htop
    neovim
    ripgrep
    wget
    ffmpeg

    firefox

    (pkgs.callPackage "${builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz"}/pkgs/agenix.nix" {})
  ];
  environment.defaultPackages = with pkgs; [
    nmap
    linuxPackages_latest.cpupower

    # Kde specific
    libsForQt5.breeze-gtk
    libsForQt5.breeze-qt5
    libsForQt5.ffmpegthumbs
    libsForQt5.filelight
    libsForQt5.kde-gtk-config
    libsForQt5.kdegraphics-thumbnailers

    # Desktop
    ffmpegthumbnailer
    easyeffects
    hunspell
    hunspellDicts.sv-se
    libreoffice-qt
    power-profiles-daemon
    wl-clipboard
    wl-clipboard-x11
    (writeShellScriptBin "install-home-manager" ''
      version="release-${config.system.nixos.release}"
      if [[ "$version" = "nixos-unstable" ]]; then
        version=master
      fi
      sudo nix-channel --add https://github.com/nix-community/home-manager/archive/''${version}.tar.gz home-manager
      sudo nix-channel --update
    '')
  ];

  programs.kdeconnect.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services.flatpak.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "wl";
    GTK_THEME = "Breeze"; # KDE, also gets set with dconf
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.desktopManager.plasma5.enable = true;
  programs.dconf.enable = true;
  xdg.portal.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "se";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  environment.pathsToLink = ["/share/zsh"];
  programs.zsh.enable = true;

  systemd.units = {
    "kde-baloo.service".enable = false;
  };
  systemd.user.units = {
    "kde-baloo.service".enable = false;
  };
  services.fstrim.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.emil = {
    isNormalUser = true;
    description = "Emil Blennow";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kate
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.tailscale.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
