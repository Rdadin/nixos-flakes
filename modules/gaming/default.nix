{ config, pkgs, lib, ... }:
{
  # Vulkan + 32‑bit userspace for Steam/Proton
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # On NVIDIA we skip VA-API shims; add extras only if you know you need them
    extraPackages = [ ];
    extraPackages32 = [ ];
  };

  # Steam + helpers (system-level is the reliable way on NixOS)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    # Optional: shows “Gamescope Session” in the greeter
    # gamescopeSession.enable = true;
  };

  # Performance tools (system service/wrapper)
  programs.gamemode.enable = true;

  # Gamepad udev rules
  services.udev.packages = [ pkgs.game-devices-udev-rules ];
}

