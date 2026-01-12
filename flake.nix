{
  description = "Darwin system @kblcuk";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs-stable,
      nixpkgs,
      nix-darwin,
      neovim-nightly-overlay,
      ...
    }@inputs:
    let
      mkSystem = import ./lib/mksystem.nix {
        inherit
          inputs
          nixpkgs
          neovim-nightly-overlay
          ;
      };
    in
    {
      darwinConfigurations.joiedevirve = mkSystem "joiedevirve";
      darwinConfigurations.chatjoyeux = mkSystem "chatjoyeux";
    };
}
