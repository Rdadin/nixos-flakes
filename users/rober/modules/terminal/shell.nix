{...}:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake .#nixos";
      lg = "lazygit";
    };
  };

 
  programs.bash = {
    enable = true;
    shellAliases = {
      k = "kubectl";
      ll = "ls -alh";
    };
  }; 
}
