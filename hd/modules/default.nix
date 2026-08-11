# Module entry point for the hd work machine.
{ ... }:

{
  imports = [
    ./nixpkgs.nix
    ./nix-settings.nix
    ./input-method

    ./desktop/hyprland.nix
    ./desktop/noctalia.nix
    ./desktop/apps.nix

    ./programs/clash-verge.nix
    ./programs/nh.nix
    ./programs/steam.nix

    ./development
    ./development/ai-tools.nix

    ./system/maintenance.nix

  ];
}
