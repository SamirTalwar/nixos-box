{ pkgs, ... }:
{
  # Define your hostname.
  networking.hostName = "dexter";

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Set up disks.
  fileSystems."/mnt/Sync" = {
    device = "/dev/disk/by-uuid/1C3C-8D1C";
    fsType = "exfat";
    options = [
      "defaults"
      "nofail" # Prevent system from failing if this drive doesn't mount
      "gid=users"
      "dmask=0002"
      "fmask=0002"
    ];
  };

  # Set up disks.
  fileSystems."/mnt/Windows" = {
    device = "/dev/disk/by-uuid/AAC0FD9DC0FD7045";
    fsType = "ntfs";
    options = [
      "defaults"
      "nofail"
      "ro"
    ];
  };

  # Set up users.
  users.users.samir = {
    isNormalUser = true;
    description = "Samir Talwar";
    hashedPassword = "$y$j9T$2ZmzAO7jn/Afc9hCfoijx/$ol7qUo7RmrbjQAy.HhE26/FrOoC9OthYvXSV7ZRB1J9";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.nushell;
    packages = with pkgs; [ ];
  };
}
