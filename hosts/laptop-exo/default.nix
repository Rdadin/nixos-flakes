{ ... }:
{
  networking.hostName = "nixos-exo";
  imports = [
    ../common.nix
    ../laptop-common.nix
    ./hardware-configuration.nix
  ];
}

