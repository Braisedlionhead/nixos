# AI tools for the hd work machine.
{ unstablePkgs, ... }:

{
  environment.systemPackages = [
    unstablePkgs.codex
#    unstablePkgs.claude-code
  ];
}
