# Steam configuration for the hd work machine.
{ ... }:

{
  programs.steam.enable = true;

  # Steam 和 Proton 中的一些组件需要 32 位图形库
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
