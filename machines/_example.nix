# Copy this file to "<hostname>.nix".

# Define local system properties.

{ pkgs, ... }:
{
  # Define your hostname.
  networking.hostName = "hostname";

  # Set your time zone.
  time.timeZone = "UTC";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  users.users.samir = {
    isNormalUser = true;
    description = "Samir Talwar";
    # generate with `mkpasswd` and replace this line
    hashedPassword = ".........................................................................";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };
}
