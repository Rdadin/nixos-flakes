{ config, lib, pkgs, ... }:
with lib; {
  options.desktop.plasma6.enable = mkEnableOption "KDE Plasma 6";

  config = mkIf config.desktop.plasma6.enable {
    services.desktopManager.plasma6.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    };
    environment.systemPackages = with pkgs; [
      pkgs.kdePackages.plasma-nm
      pkgs.kdePackages.kdeconnect-kde
      pavucontrol
    ];
  };
}
