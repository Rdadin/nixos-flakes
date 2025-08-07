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
      colors.primary = {
        background = "#1a1b26"; 
        foreground = "#c0caf5"; 
        };
      window = {
        opacity = 0.9;
      };
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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.git = {
    enable = true;
    userName = "Roberto Dadin";
    userEmail = "r.dadin94@gmail.com";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake .#nixos";
      lg = "lazygit";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;
      format = lib.concatStrings [
        "[░▒▓](#a3aed2)"
        "[  ](bg:#a3aed2 fg:#090c0c)"
        "[](bg:#769ff0 fg:#a3aed2)"
        "$directory"
        "[](fg:#769ff0 bg:#394260)"
        "$git_branch"
        "$git_status"
        "[](fg:#394260 bg:#212736)"
        "$nodejs"
        "$rust"
        "$golang"
        "$php"
        "[](fg:#212736 bg:#1d2230)"
        "$time"
        "[ ](fg:#1d2230)"
        "\n$character"
      ];
      directory = {
        style = "fg:#e3e5e5 bg:#769ff0";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };
      git_branch = {
        symbol = "";
        style = "bg:#394260";
        format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
      };
      git_status = {
        style = "bg:#394260";
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
      };
      nodejs = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      php = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#1d2230";
        format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
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
