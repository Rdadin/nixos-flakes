{ config, pkgs, ... }:
{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";  # Breeze Dark global theme
      colorScheme = "BreezeDark";                  # matching color scheme
      iconTheme   = "breeze-dark";                 # optional: dark icon theme
    };

    input = {
      mouse = {
        acceleration = "none";  # disables pointer acceleration
        speed = -0.5;           # range: -1.0 (slow) to 1.0 (fast), 0 = default
      };
    };
  };
}
