{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    # Aggregated module folders
    ../../modules/common
    ../../modules/networking
    ../../modules/desktop
    ../../modules/services
  ];

  networking.hostName = "nixos";
  system.stateVersion = "25.05";
}
