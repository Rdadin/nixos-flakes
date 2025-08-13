{ pkgs, lib, ... }: 

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Runs when Hyprland starts
      "exec-once" = [
        "waybar"
        "nm-applet"
        "hyprpaper"
      ];

      # Example extra settings
      monitor = [ ",preferred,auto,1" ];
      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive"
      ];
    };
  };
}
