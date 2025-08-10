{ config, lib, pkgs, ... }:
let
  cfg = config.desktop.hyprland;
in
{
  options.desktop.hyprland.enable = lib.mkEnableOption "Hyprland desktop environment";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Sensible Wayland env for mixed KDE/Hypr usage
    environment.sessionVariables = {
      # Toolkit backends
      NIXOS_OZONE_WL = "1";        # Chrome/Electron to Wayland
      MOZ_ENABLE_WAYLAND = "1";    # Firefox -> Wayland
      QT_QPA_PLATFORM = "wayland;xcb";
      GDK_BACKEND = "wayland,x11";

      # Cursor scaling consistency
      XCURSOR_SIZE = "24";
    } // lib.optionalAttrs (config.hardware.nvidia.modesetting.enable or false) {
      # NVIDIA quirks for wlroots
      WLR_NO_HARDWARE_CURSORS = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
    };

    # Portals: keep both KDE (for Plasma) and Hyprland (for Hypr)
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-kde
      ];
      # Let the session decide; both DEs work
      configPackages = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    # Login manager (you already have a module; this ensures Wayland path is good)
    services.xserver.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Useful system packages that Hypr sessions expect
    environment.systemPackages = with pkgs; [
      # bars/launchers/wallpaper
      waybar rofi-wayland hyprpaper

      # terminals/editors
      kitty

      # screenshots/clipboard/record
      grim slurp wl-clipboard wf-recorder swappy

      # notifications & tray helpers
      libnotify mako networkmanagerapplet polkit_gnome

      # other handy wayland tools
      wlr-randr cliphist jq
    ];

    # Autostart helpers that work across seats via systemd --user
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "Polkit GNOME Authentication Agent";
        After = [ "graphical-session.target" "hyprland-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    systemd.user.services.nm-applet = {
      Unit = {
        Description = "NetworkManager Applet";
        After = [ "graphical-session.target" "hyprland-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
        Restart = "on-failure";
        Environment = "XDG_CURRENT_DESKTOP=Hyprland";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    # Pass toggle to HM user modules cleanly
    home-manager.extraSpecialArgs = {
      hyprlandEnabled = true;
    };
  };

  # If disabled, tell HM explicitly so it can skip configs
  config = lib.mkIf (!cfg.enable) {
    home-manager.extraSpecialArgs = {
      hyprlandEnabled = false;
    };
  };
}

