{ pkgs, ... }:
{
  users.groups.rober = {};

  users.users.rober = {
    isNormalUser = true;          # exactly one of these must be set

    description = "Roberto Dadin";
    home        = "/home/rober";
    group       = "rober";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell       = pkgs.fish;
  };
}

