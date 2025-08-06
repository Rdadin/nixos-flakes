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
}
