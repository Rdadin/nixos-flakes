{ lib, ... }:
{
  networking.wireless.iwd.enable = lib.mkDefault true;
  services.power-profiles-daemon.enable = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];
}

