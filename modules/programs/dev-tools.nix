{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    # add other toolchains here when you need them:
    # gnumake cmake pkg-config clang go nodejs python3 rustup jq yq
  ];
}

