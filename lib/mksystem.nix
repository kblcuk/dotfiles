# This function creates a NixOS system based on our VM setup for a
# particular architecture.
# Much simpler version of
# https://github.com/mitchellh/nixos-config/blob/d6e1b26bd0f483d92d1522c7de127c16a25a351c/lib/mksystem.nix#L4
{
  nixpkgs,
  inputs,
  neovim-nightly-overlay,
  ...
}:

name:

inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    inherit
      inputs
      nixpkgs
      neovim-nightly-overlay
      ;
  };
  modules = [
    {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [
        (
          _final: prev:
          let
            unstable = nixpkgs.legacyPackages.${prev.system};
          in
          {
            fish = unstable.fish;
            fishPlugins = unstable.fishPlugins;

            # direnv's test-fish hangs on darwin with fish 4.6.0 from unstable.
            # Skip that specific test until upstream fixes it.
            # https://github.com/NixOS/nixpkgs/issues/507531
            direnv = prev.direnv.overrideAttrs (oldAttrs: {
              checkPhase = ''
                runHook preCheck
                make test-go test-bash test-zsh
                runHook postCheck
              '';
            });
          }
        )
      ];
    }
    ../machines/${name}/configuration.nix
    ../machines/${name}/home.nix
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];
}
