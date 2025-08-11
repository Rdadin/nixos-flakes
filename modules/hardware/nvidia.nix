{ lib, pkgs, config, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;   # required for GBM/Wayland
    open = false;                # GTX 1080 (Pascal) -> use the proprietary kernel module
    nvidiaSettings = true;       # optional: nvidia-settings tool
    # Pick the regular stable driver for now
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

}

