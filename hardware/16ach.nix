# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  networking.hostName = "16ach"; # Define your hostname.

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = ["dm-snapshot" "amdgpu" "amd_pstate"];
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/234044b6-40a8-4448-ab9a-6701f000b8c3";
      preLVM = true;
      allowDiscards = true;
    };
  };
  boot.kernelModules = ["kvm-amd" "amd_pstate"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/45c42ab6-5288-460b-8ae8-8c047485f980";
    fsType = "ext4";
    options = ["defaults" "noatime" "nodiratime"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6A00-D4DF";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/91d66b1d-8c3b-47cf-922a-5bd904b95c43";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  services.xserver.videoDrivers = ["amdgpu"];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
