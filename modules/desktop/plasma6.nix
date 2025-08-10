{ lib, pkgs, ... }:
with lib; {
  options.desktop.plasma6.enable = mkEnableOption "KDE Plasma 6";

  config = mkIf config.desktop.plasma6.enable {
    services.desktopManager.plasma6.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-kde ];
    };
    environment.systemPackages = with pkgs; [
      kdePackages.plasma-nm
      plasma5Packages.kdeconnect-kde
      pavucontrol
    ];
  };
}
