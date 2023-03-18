# Copy this file to "users.nix".

# Define a user account or two.

{ pkgs, ... }:
{
  users.users.samir = {
    isNormalUser = true;
    description = "Samir Talwar";
    # generate with `mkpasswd` and replace this line
    hashedPassword = ".........................................................................";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
}
