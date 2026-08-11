# Input method stack for the hd work machine.
{ pkgs, rimeKagiroi, ... }:

let
  kagiroiData = pkgs.stdenvNoCC.mkDerivation {
    pname = "rime-kagiroi";
    version = rimeKagiroi.shortRev or "locked";
    src = rimeKagiroi;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/share/rime-data"
      install -m644 "$src"/kagiroi*.yaml "$out/share/rime-data/"
      install -m644 "$src"/kagiroi.ico "$out/share/rime-data/"
      install -m644 "$src"/key_bindings.yaml "$src"/punctuation.yaml "$out/share/rime-data/"
      cp -r "$src"/lua "$src"/opencc "$out/share/rime-data/"

      runHook postInstall
    '';

    meta = {
      description = "Kagiroi Japanese input schema for Rime";
      homepage = "https://github.com/rimeinn/rime-kagiroi";
      license = pkgs.lib.licenses.gpl3Only;
    };
  };

  rimeWithSchemas = pkgs.fcitx5-rime.override {
    rimeDataPkgs = [
      pkgs.rime-ice
      kagiroiData
    ];
  };
in

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
        rimeWithSchemas
        fcitx5-gtk
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    kdePackages.fcitx5-configtool
  ];

  # 在 Hyprland 这类窗口管理器中运行 XDG 自动启动项。
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
}
