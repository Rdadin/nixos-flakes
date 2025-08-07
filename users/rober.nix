{ config, pkgs, lib, ... }:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    tree
    google-chrome
    thunderbird
    ripgrep
    fzf
    neofetch
    glow
    btop
    steam
    spotify
    lazygit
  ];

  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        size = 11.0;
      };
    };
  };
 
  programs.git = {
    enable = true;
    userName = "Roberto Dadin";
    userEmail = "r.dadin94@gmail.com";
  };

  programs.fish.enable = true;

  programs.starship = {
    enable = true;
    settings = {
        add_newline = false;
        format = "$directory$git_branch$git_status$nix_shell$character ";
        character.success_symbol = "[➜](green)";
        character.error_symbol = "[✗](red)";
    };
  };

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
    bind = SUPER_SHIFT, Q, exec, pkill Hyprland


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
