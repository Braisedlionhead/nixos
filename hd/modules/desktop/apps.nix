# Graphical applications for the hd work machine.
{ dbx, pkgs, ... }:

let
  chromeWithKwallet = pkgs.google-chrome.override {
    commandLineArgs = "--password-store=kwallet6";
  };
  dbxPackage = dbx.packages.${pkgs.stdenv.hostPlatform.system}.dbx-desktop;
  dbxDesktop = pkgs.symlinkJoin {
    name = "dbx-desktop-wayland-workaround";
    paths = [ dbxPackage ];
    nativeBuildInputs = [ pkgs.makeWrapper ];

    # WebKitGTK's DMA-BUF renderer produces alternating blurry frames while
    # wheel-scrolling under native Wayland and is also implicated in the
    # renderer's Mesa/EGL shutdown crashes. Scope the workaround to DBX and its
    # child processes instead of changing the whole graphical session.
    postBuild = ''
      rm "$out/bin/dbx"
      makeWrapper "${dbxPackage}/bin/dbx" "$out/bin/dbx" \
        --set WEBKIT_DISABLE_DMABUF_RENDERER 1
    '';
  };
in

{
  environment.systemPackages = with pkgs; [
    libreoffice-qt6
    glow
    fastfetch
    macchina
    zed-editor
    featherpad
    dbxDesktop
    rustdesk-flutter
    termius
    telegram-desktop
    wechat
    chromeWithKwallet
  ];
}
