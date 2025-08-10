{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Hyprland session helpers (install only; start them via HM/Hypr config)
  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    hyprpaper
    kitty
    brightnessctl
    # hypridle  # uncomment if you plan to use it
    # hyprlock  # idem
    # swaynotificationcenter # if you want notifications on Hyprland
    # nm-applet  # if you want a tray in Hyprland (Plasma already has plasma-nm)
  ];
}


