{ inputs, lib, pkgs, ... }:
{
  networking.hostName = "nixos-desktop";

  imports = [
    ../common.nix           # small wrapper that imports your shared modules set
    ../../modules/gaming    # if you want “gaming” only on desktop, you can make
    ./hardware-configuration.nix
    ../../modules/hardware/nvidia.nix  # see section 2
  ];

  # Desktop-only toggles
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;

  # Optional: performance/power tweaks for a tower
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}

