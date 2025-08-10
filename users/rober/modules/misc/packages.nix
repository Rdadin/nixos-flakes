{ pkgs, ...}:
{
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
    firefox
  ];
}
