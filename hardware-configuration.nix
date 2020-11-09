# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [];
  boot.tmpOnTmpfs = true;

  boot.initrd.luks.devices =
    {
      cryptsystem = {
        name = "cryptsystem";
        device = "/dev/disk/by-uuid/7acea7fe-cd80-4f03-8e3c-c962f0b6ab9f";
        preLVM = true;
        allowDiscards = true;
      };
    };

  fileSystems."/" =
    {
      device = "/dev/mapper/ChenSSD-root";
      fsType = "ext4";
      options = [ "relatime" "discard" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/mapper/ChenSSD-nix";
      fsType = "f2fs";
      noCheck = true;
    };

  fileSystems."/var" =
    {
      device = "/dev/mapper/ChenSSD-var";
      fsType = "f2fs";
      options = [ "relatime" "discard" ];
    };

  fileSystems."/var/lib/docker" =
    {
      device = "/dev/mapper/ChenSSD-docker";
      fsType = "f2fs";
      options = [ "relatime" "discard" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/1A23-DAFD";
      fsType = "vfat";
    };

  fileSystems."/home" =
    {
      device = "/dev/mapper/ChenSSD-home";
      fsType = "ext4";
      options = [ "relatime" "discard" ];
    };

  swapDevices = [];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  hardware = {
    bluetooth = {
      enable = true;
    };
    opengl = {
      enable = true;
    };
  };
}
