{ lib, pkgs, config, ... }:
{
  # GTX 1080 (Pascal) → proprietary driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;                 # Pascal doesn’t use the open kernel module
    nvidiaSettings = true;
    powerManagement.enable = false;
  };

  environment.systemPackages = with pkgs; [ nvidia-settings ];
}

