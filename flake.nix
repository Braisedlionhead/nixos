{
  description = "NixOS configuration";

  # Make the Noctalia binary cache available during the first rebuild, before
  # the equivalent daemon settings from hd/modules/nix-settings.nix are
  # active.
  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Track the latest Noctalia v5 commit that is already available from the
    # project's binary cache. flake.lock keeps the selected commit reproducible.
    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    rime-kagiroi = {
      url = "github:rimeinn/rime-kagiroi";
      flake = false;
    };

    dbx.url = "github:t8y2/dbx";
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, home-manager, disko, noctalia, rime-kagiroi, dbx, ... }:
    let
      system = "x86_64-linux";
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # Expose the exact Disko installer pinned by flake.lock, so recovery does
      # not silently use a newer partitioning tool than this configuration.
      packages.${system}.disko-install = disko.packages.${system}.disko-install;

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit unstablePkgs dbx;
          rimeKagiroi = rime-kagiroi;
        };
        modules = [
          disko.nixosModules.disko
          ./hd
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup";
              users.nogami = {
                imports = [
                  noctalia.homeModules.default
                  ./hd/modules/home-manager.nix
                ];
              };
            };
          }
        ];
      };
    };
}
