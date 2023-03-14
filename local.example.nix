# Copy this file to "local.nix".

# Define local system properties.

{ ... }:
{
  # Define your hostname.
  networking.hostName = "dexter";

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}
