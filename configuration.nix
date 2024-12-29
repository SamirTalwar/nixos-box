# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./lix.nix
      ./local.nix
    ];

  # Enable experimental commands that aren't so experimental.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable Nix overrides for all users that can use `sudo`.
  nix.settings.trusted-users = [
    "@wheel"
  ];

  # Allow extra substituters.
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://cache.lix.systems"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
  ];

  # Optimize the store once in a while.
  nix.settings.auto-optimise-store = true;

  # Support NTFS mounts.
  boot.supportedFilesystems = [ "ntfs" ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };

    timeout = 10;
  };

  # Setup the keyfile.
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Set the hardware clock in local time to appease Windows.
  time.hardwareClockInLocalTime = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable RealtimeKit, which is used by certain services, e.g. PulseAudio
  security.rtkit.enable = true;

  # Enable xdg-desktop-portal for screen sharing
  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Enable dbus
  services.dbus.enable = true;

  # Enable audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Use GDM as the login screen
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # Set up a keyring, and connect it to the login screen
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  # Suspend when the power button is pressed
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  services.tailscale.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  environment.sessionVariables = {
    # Enable Ozone for Electron apps to improve Wayland support.
    NIXOS_OZONE_WL = "1";
  };

  environment.shells = with pkgs; [
    nushell
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.seahorse = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
    "steam-unwrapped"
  ];

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
  system.stateVersion = "22.11"; # Did you read the comment?

}
