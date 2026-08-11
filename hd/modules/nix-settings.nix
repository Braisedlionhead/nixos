# Nix daemon settings for the hd work machine.
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Official Noctalia cache. Its flake input intentionally does not follow
    # the system nixpkgs input so these substitutes remain usable.
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
