{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors.primary = {
        background = "#1a1b26"; 
        foreground = "#c0caf5"; 
        };
      window = {
        opacity = 0.95;
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
}
