{ config, pkgs, lib, ... }:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neofetch
    tree
    git
    starship
    google-chrome
    thunderbird
    alacritty
    ripgrep
    fzf
    starship
    neofetch
    glow
    btop
    steam
  ];

  programs.git = {
    enable = true;
    userName = "Roberto Dadin";
    userEmail = "r.dadin94@gmail.com";
  };

  programs.starship.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      k = "kubectl";
      ll = "ls -alh";
    };
  }; 

  xdg.configFile."hypr/hyprland.conf".text = ''
    # Monitor (Adjust to your monitor setup)
    monitor=,preferred,auto,1

    # Autostart applications
    exec-once = waybar &
    exec-once = hyprpaper &

    # Keybindings
    bind = SUPER, Return, exec, kitty
    bind = SUPER, D, exec, rofi -show drun
    bind = SUPER, Q, killactive
    bind = SUPER, F, togglefloating

    # Gaps and Borders
    general {
      gaps_in = 5
      gaps_out = 10
      border_size = 2
      col.active_border = rgba(88c0d0ee)
      col.inactive_border = rgba(4c566a88)
    }

    # Floating Rules (for things like pavucontrol)
    windowrulev2 = float,class:^(pavucontrol)$
  '';
}
