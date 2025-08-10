{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    # no extraConfig here — JaKooLit’s files will provide the full config
  };

  # Helpers that his dots expect (safe to install for your user)
  # If you already install them system-wide, you can drop them here.
  home.packages = with pkgs; [
    waybar rofi-wayland kitty wlogout swww wallust
    # hypridle hyprlock swaynotificationcenter  # enable if you use them
  ];
}

