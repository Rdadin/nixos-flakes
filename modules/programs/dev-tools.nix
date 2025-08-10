{ lib, pkgs, ... }:
with lib; {
  options.programs.devTools.enable = mkEnableOption "developer tools";

  config = mkIf config.programs.devTools.enable {
    environment.systemPackages = with pkgs; [
      gcc
      # add more dev toolchains here as you like
    ];
  };
}
