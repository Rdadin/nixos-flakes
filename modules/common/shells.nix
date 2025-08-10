{ lib, pkgs, ... }:
with lib; {
  options.common.shells.enable = mkEnableOption "shells and prompt";

  config = mkIf (config.common.shells.enable or true) {
    programs.fish.enable = true;
    users.users.rober = {
      isNormalUser = true;
      description = "Roberto Dadin";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.fish;
    };
  };
}

