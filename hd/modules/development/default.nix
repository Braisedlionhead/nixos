# Development environment for the hd work machine.
{ pkgs, ... }:

let
  vscodeWithKwallet = pkgs.vscode.override {
    # Electron cannot infer KDE's keyring from a Hyprland desktop identity.
    commandLineArgs = "--password-store=kwallet6";
  };
in

{
  # 系统默认 Java，同时设置 JAVA_HOME
  programs.java = {
    enable = true;
    package = pkgs.jdk8;
  };

  environment.systemPackages = with pkgs; [
    # IDE
    jetbrains.idea
    vscodeWithKwallet

    # Java 工具
    maven

    # 前端工具
    nodejs_22

    # Go
    go

    # 常用工具
    unzip
    zip
    jq
  ];

  programs.git.enable = true;
}
