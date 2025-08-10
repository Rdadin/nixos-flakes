{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    # Core system
    ../../modules/common/base.nix
    ../../modules/common/boot-efi.nix
    ../../modules/common/shells.nix

    # Networking
    ../../modules/networking/core.nix
    ../../modules/networking/vpn-tun-access.nix

    # Desktop
    ../../modules/desktop/sddm.nix
    ../../modules/desktop/plasma6.nix
    ../../modules/desktop/hyprland.nix

    # Services & programs
    ../../modules/services/audio-pipewire.nix
    ../../modules/services/bluetooth.nix
    ../../modules/programs/dev-tools.nix
  ];

  # Host-specific bits & toggles
  networking.hostName = "nixos";

  common.shells.enable = true;
  common.base.enable = true;

  desktop.sddm.enable = true;
  desktop.plasma6.enable = true;
  desktop.hyprland.enable = true;

  networking.core.enable = true;
  my.vpn.tunAccess = {
    enable = true;
    interfaces = [ "tun0" ];
    rpFilterMode = "loose";
  };

  services.audio.pipewire.enable = true;
  services.bluetooth.enable = true;
  programs.devTools.enable = true;

  system.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;
}

