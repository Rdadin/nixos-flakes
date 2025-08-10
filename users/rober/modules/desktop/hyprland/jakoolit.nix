{ hyprdots, pkgs, ... }:
let
  dots = hyprdots;  # vendor’d source tree
in {
  # Hyprland core
  xdg.configFile."hypr".source     = "${dots}/config/hypr";
  # Waybar + styles
  xdg.configFile."waybar".source   = "${dots}/config/waybar";
  # Rofi presets
  xdg.configFile."rofi".source     = "${dots}/config/rofi";
  # Logout menu
  xdg.configFile."wlogout".source  = "${dots}/config/wlogout";
  # (Optional) other pieces he ships; uncomment as you like:
  xdg.configFile."swww".source      = "${dots}/config/swww";
  xdg.configFile."wallust".source   = "${dots}/config/wallust";
  xdg.configFile."swaylock".source  = "${dots}/config/swaylock";
  xdg.configFile."kitty".source     = "${dots}/config/kitty";
  xdg.configFile."ags".source       = "${dots}/config/ags";

  # Wallpapers (repo includes a wallpapers dir)
  xdg.configFile."wallpapers".source = "${dots}/wallpapers";

  # Ensure tools his dots assume are present
  home.packages = with pkgs; [
    waybar rofi-wayland swww wallust wlogout
    # pick your terminal; he leans kitty. Keep Alacritty if you prefer:
    kitty
    # hypridle hyprlock swaynotificationcenter # (enable if you use them)
  ];
}
