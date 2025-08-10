{ lib, ... }:
with lib; {
  options.desktop.sddm.enable = mkEnableOption "SDDM display manager (Wayland)";

  config = mkIf config.desktop.sddm.enable {
    services.xserver.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
