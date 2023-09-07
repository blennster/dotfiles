# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  networking.hostName = "16ach"; # Define your hostname.

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = ["dm-snapshot" "amdgpu"];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.resumeDevice = "/dev/disk/by-uuid/91d66b1d-8c3b-47cf-922a-5bd904b95c43";

  # Luks config
  # Enroll keys in tpm with systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0 /dev/<encrypted device>
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/234044b6-40a8-4448-ab9a-6701f000b8c3";
      preLVM = true;
      allowDiscards = true;
    };
  };
  boot.initrd.systemd.enable = true;
  environment.systemPackages = [
    pkgs.tpm2-tss # for systemd-cryptenroll
  ];

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

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;
    };
  };
  services.power-profiles-daemon.enable = false;

  environment.defaultPackages = with pkgs; [
    (writeShellScriptBin "batsave" ''
      if [[ -n $1 && ($1 -eq 0 || $1 -eq 1) ]]; then
        echo "$1" | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
      else
        cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
      fi
    '')
  ];

  # From AMD GPU page on wiki
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.opengl = {
    driSupport = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}