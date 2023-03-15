# Copy this file to "local.nix".

# Define local system properties.

{ ... }:
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
}
