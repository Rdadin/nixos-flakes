{ lib, pkgs, ... }:
with lib; {
  options.desktop.hyprland.enable = mkEnableOption "Hyprland compositor";

  config = mkIf config.desktop.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };

    environment.systemPackages = with pkgs; [
      waybar rofi-wayland hyprpaper kitty brightnessctl
    ];
  };
}

