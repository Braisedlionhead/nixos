# Hyprland configuration for the hd work machine.
{ pkgs, unstablePkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;

    # Keep the compositor and its portal from the same package set. This allows
    # Hyprland to move faster without switching the rest of NixOS to unstable.
    package = unstablePkgs.hyprland;
    portalPackage = unstablePkgs.xdg-desktop-portal-hyprland;
  };

  # SDDM/UWSM supplies the desktop and session identity. Setting those values
  # globally makes Plasma applications incorrectly identify as Hyprland.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";

    # GTK applications such as Firefox need these schema locations in a
    # standalone Hyprland session. NixOS merges this list with the normal
    # profile and desktop-session XDG data paths.
    XDG_DATA_DIRS = [
      "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
      "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    ];
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Noto Sans CJK SC" "Noto Sans" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  environment.systemPackages = with pkgs; [
    foot
    fish
    btop
    trash-cli
    libnotify
    hyprpicker
    wl-clipboard
    cliphist
    grim
    slurp
    swappy
    brightnessctl
    playerctl
    pavucontrol
    adw-gtk3
  ];
}
