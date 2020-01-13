# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = [
    {
      name = "cryptsystem";
      device = "/dev/disk/by-uuid/70ca6076-c285-44e2-8acd-44d39701ecd8";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  fileSystems."/" =
    { device = "/dev/mapper/PortableNixOS1-root";
      fsType = "ext4";
      options = [ "relatime" "discard" ];
    };

  fileSystems."/home" =
    { device = "/dev/mapper/PortableNixOS1-home";
      fsType = "ext4";
      options = [ "relatime" "discard" ];
    };

  fileSystems."/nix" =
    { device = "/dev/mapper/PortableNixOS1-nix";
      fsType = "f2fs";
    };

  fileSystems."/var" =
    { device = "/dev/mapper/PortableNixOS1-var";
      fsType = "ext4";
      options = [ "relatime" "discard" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8ABE-252A";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # High-DPI console
  i18n.consoleFont = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  hardware = {
    bluetooth = {
      enable = true;
    };
  };
}
