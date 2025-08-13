{ ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      allow_remote_control = "yes";
    };
    keybindings = {
      "ctrl+shift+y" = "launch --stdin-source=@last_cmd_output kitty +kitten clipboard";
      "ctrl+shift+u" = "launch --stdin-source=@screen_scrollback kitty +kitten clipboard";
      "ctrl+shift+g" = "launch --stdin-source=@last_cmd_output --stdin-add-formatting --type=overlay less +G -R";
    };
    themeFile = "tokyo_night_moon";
  };
}  
