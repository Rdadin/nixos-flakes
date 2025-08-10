{ pkgs, ... }:
{
  # XDG portals = file pickers, screen sharing, URL handlers, etc.
  xdg.portal = {
    enable = true;

    # Backends to have available. KDE will prefer its own; others can fall back to GTK.
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}

