# User-owned Fcitx 5 and Rime configuration for the hd work machine.
{ ... }:

{
  xdg.configFile = {
    "fcitx5/config".source = ./config;
    "fcitx5/profile".source = ./profile;
  };

  # Keep generated schemas, synchronization data and user dictionaries writable
  # beside this single declarative override.
  home.file.".local/share/fcitx5/rime/default.custom.yaml".source = ./rime/default.custom.yaml;
}
