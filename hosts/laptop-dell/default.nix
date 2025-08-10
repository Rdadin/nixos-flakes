{ ... }:
{
  networking.hostName = "nixos-dell";
  imports = [
    ../common.nix
    ../laptop-common.nix
    ./hardware-configuration.nix
  ];

#  desktop.hyprland.enable = true;
}

