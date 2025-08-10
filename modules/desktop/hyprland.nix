# modules/desktop/hyprland.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.desktop.hyprland;
in
{
  options.desktop.hyprland.enable = lib.mkEnableOption "Hyprland desktop environment";

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        GDK_BACKEND = "wayland,x11";
        XCURSOR_SIZE = "24";
      } // lib.optionalAttrs (config.hardware.nvidia.modesetting.enable or false) {
        WLR_NO_HARDWARE_CURSORS = "1";
        __GL_GSYNC_ALLOWED = "0";
        __GL_VRR_ALLOWED = "0";
      };

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
          kdePackages.xdg-desktop-portal-kde
        ];
        configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
      };

      services.xserver.enable = true;
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };

      environment.systemPackages = with pkgs; [
        waybar rofi-wayland hyprpaper
        kitty
        grim slurp wl-clipboard wf-recorder swappy
        libnotify mako networkmanagerapplet polkit_gnome
        wlr-randr cliphist jq
      ];

      # -- replace the whole definitions with these --

      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        Unit = { Description = "Polkit GNOME Authentication Agent"; };
        Service = {
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
        };
        wantedBy = [ "graphical-session.target" ];
        after    = [ "graphical-session.target" "hyprland-session.target" ];
        partOf   = [ "graphical-session.target" ];
      };

      systemd.user.services.nm-applet = {
        Unit = { Description = "NetworkManager Applet"; };
        Service = {
          ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
          Restart = "on-failure";
          Environment = "XDG_CURRENT_DESKTOP=Hyprland";
        };
        wantedBy = [ "graphical-session.target" ];
        after    = [ "graphical-session.target" "hyprland-session.target" ];
        partOf   = [ "graphical-session.target" ];
      };

      # Tell HM the toggle is on
      home-manager.extraSpecialArgs = { hyprlandEnabled = true; };
    })

    # When disabled, still pass the flag to HM
    (lib.mkIf (!cfg.enable) {
      home-manager.extraSpecialArgs = { hyprlandEnabled = false; };
    })
  ];
}
