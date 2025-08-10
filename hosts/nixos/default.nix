{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    # Core
    ../../modules/common/boot-efi.nix
    ../../modules/common/system.nix
    ../../modules/common/users-rober.nix
    ../../modules/common/fonts.nix

    # Networking
    ../../modules/networking/core.nix
    ../../modules/networking/vpn-tun-access.nix
    ../../modules/networking/openvpn.nix

    # Desktop
    ../../modules/desktop/sddm.nix
    ../../modules/desktop/plasma6.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/portals.nix

    # Services
    ../../modules/services/audio-pipewire.nix
    ../../modules/services/bluetooth.nix
  ];

  networking.hostName = "nixos";
  system.stateVersion = "25.05";

}

