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
    terraform
    ansible
#    steam
    spotify
    lazygit
    firefox
    kitty
  ];
}
