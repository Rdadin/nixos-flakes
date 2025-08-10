{ config, lib, pkgs, hyprlandEnabled ? false, ... }:

let
  enable = hyprlandEnabled;
in
{
  config = lib.mkIf enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      # Basic, clean defaults; tweak bindings later
      settings = {
        monitor = ",preferred,auto,1";
        exec-once = [
          "hyprpaper"
          "waybar"
          "nm-applet --indicator"
          "mako"
          "cliphist wipe"  # reset on login
        ];

        # Input
        input = {
          kb_layout = "us,latam";
          kb_options = "grp:alt_shift_toggle";
          follow_mouse = 1;
          touchpad = { natural_scroll = true; tap = true; };
          sensitivity = 0;  # 0 = default
        };

        # Window rules
        misc = {
          force_default_wallpaper = 0;
          focus_on_activate = true;
        };

        general = {
          gaps_in = 6;
          gaps_out = 10;
          border_size = 2;
          layout = "dwindle";
          "col.active_border" = "rgba(89b4faee)";
          "col.inactive_border" = "rgba(313244aa)";
        };

        decoration = {
          rounding = 8;
          drop_shadow = true;
          shadow_range = 20;
          blur = { enabled = true; size = 6; passes = 2; };
        };

        animations = {
          enabled = true;
          bezier = [ "ease, 0.05, 0.9, 0.1, 1.0" ];
          animation = [
            "windows, 1, 5, ease"
            "border, 1, 5, ease"
            "fade, 1, 7, ease"
            "workspaces, 1, 5, ease"
          ];
        };

        dwindle = { preserve_split = true; };

        # Keybinds (super = $mod)
        "$mod" = "SUPER";
        bind = [
          "$mod, Return, exec, kitty"
          "$mod, Q, killactive,"
          "$mod, E, exec, rofi -show drun"
          "$mod, V, togglefloating,"
          "$mod, F, fullscreen, 0"
          "$mod, Space, exec, rofi -show drun"

          # focus
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # workspaces 1..9
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"

          # move to workspace
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"

          # screenshots
          ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
          "SHIFT, Print, exec, grim ~/Pictures/Screenshots/$(date +'%F_%T').png"
        ];
      };
    };

    # Waybar: simple, readable defaults
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [{
        layer = "top";
        height = 30;
        modules-left  = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ ];
        modules-right = [ "tray" "cpu" "memory" "pulseaudio" "clock" ];
        "clock" = { format = "{:%a %F %R}"; tooltip = true; };
        "pulseaudio" = { format = "{volume}%"; tooltip = true; };
      }];
      style = ''
        * { font-family: JetBrainsMono Nerd Font, Inter, sans-serif; font-size: 12px; }
        window#waybar { background: rgba(24,24,37,0.7); color: #cdd6f4; }
        #workspaces button.active { color: #89b4fa; }
      '';
    };

    # Wallpaper: point to a generic path; replace with your image
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ~/.config/wallpapers/default.jpg
      wallpaper = ,~/.config/wallpapers/default.jpg
    '';

    # Notifications
    services.mako.enable = true;

    # Small QoL
    home.packages = with pkgs; [ wl-clipboard cliphist jq ];

    # Create dirs we reference
    home.file.".config/wallpapers/.keep".text = "";
    home.file."Pictures/Screenshots/.keep".text = "";
  };
}

