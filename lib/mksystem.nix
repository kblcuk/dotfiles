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
    # Allow unfree packages.
    { nixpkgs.config.allowUnfree = true; }
    ../machines/${name}/configuration.nix
    ../machines/${name}/home.nix
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];
}
