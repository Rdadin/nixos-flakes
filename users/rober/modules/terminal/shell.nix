{...}:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake .#(hostname)";
      lg = "lazygit";
    };
    functions = {
      kitty_mark_prompt = {
        onEvent = "fish_postexec";
        body = ''echo -e "\x1b]1337;SetMark\x07"'';
      };
      copy_last_output = {
        body = ''
          # Grab full scrollback + screen as ANSI text from the focused window
          set -l dump (mktemp)
          kitty @ get-text --ansi --match=focused --extent=all > $dump

          # Keep only text after the last SetMark and copy to clipboard
          awk '
            BEGIN { mark = "\033]1337;SetMark\007" }
            {
              if (index($0, mark)) { out = ""; next }
              out = out $0 "\n"
            }
            END { printf "%s", out }
          ' $dump | kitty +kitten clipboard

          rm -f $dump
        '';
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
}
