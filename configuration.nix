# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  user = "akirakomamura";
  useDisplayManager = true;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow starting other operating systems on the machine
  boot.loader.grub.useOSProber = true;

  networking.hostName = "Chen"; # Define your hostname.

  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.resolvconf.dnsExtensionMechanism = false; # Disable edns0 in resolv.conf

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    coreutils
    gptfdisk
    unzip
    vim
    gnome3.adwaita-icon-theme
    gnome3.gnome-tweak-tool
    xorg.xinit
    # python2.7-yubikey-neo-manager
  ];

  environment.shells = with pkgs; [
    zsh
    bashInteractive
  ];

  nix = {
    useSandbox = true;
    trustedUsers = [
      "root"
      user
      "@wheel"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs = {
    dconf.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # To connect to bluetooth devices, use bluetoothctl command which is
  # installed with bluetooth module by default.

  services.xserver = {
    enable = true;
    videoDriver = "intel";
    autorun = useDisplayManager;
    exportConfiguration = false;
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    enableCtrlAltBackspace = true;
    libinput.enable = true;
    # Alternative window managers for rescue.
    desktopManager = {
      gnome3.enable = true;
    };
    windowManager.openbox.enable = true;
    # Configure the display manager.
    displayManager = {
      gdm = {
        enable = true;
        autoLogin = {
          enable = false;
          # user = "${user}";
        };
      };
      # sddm.enable = true;
      lightdm.enable = false;
      # Allow running ~/.xinitrc as an X session
      session = [
        {
          manage = "desktop";
          name = "xinitrc";
          start = ''
exec $HOME/.xinitrc
'';
        }

      ];
    };
  };

  # TODO: Use slock instead of physlock for hardened security
  # programs.slock.enable = true;

  services.gnome3 = {
    chrome-gnome-shell.enable = true;
  };

  # Configure physlock.
  services.physlock = {
    enable = ! useDisplayManager;
    lockOn = {
      suspend = true;
      hibernate = true;
    };
  };

  services.psd = {
    enable = true;
  };

  services.udev.packages = [
    pkgs.yubikey-personalization
  ];

  services.pcscd = {
    enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${user}" = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager"
      # "vboxusers"
      "docker"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  # virtualisation.virtualbox.host.enable = true;

}
