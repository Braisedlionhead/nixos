# Nixpkgs policy for the hd work machine.
{ ... }:

{
  # This workstation intentionally includes proprietary applications such as
  # Steam, Chrome, VS Code, Termius and WeChat. Keep the policy centralized.
  nixpkgs.config.allowUnfree = true;
}
