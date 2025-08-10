{ ... }:
{
  imports = [
    ../modules/common        # your boot-efi.nix, system.nix, users-rober.nix, etc.
    ../modules/networking
    ../modules/programs
    ../modules/services
    ../modules/desktop       # plasma6.nix + hyprland.nix + sddm.nix together
  ];
}
