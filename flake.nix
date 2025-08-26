{
  description = "Darwin system @kblcuk";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs-stable,
      nixpkgs,
      nix-darwin,
      mac-app-util,
      neovim-nightly-overlay,
      ...
    }@inputs:
    let
      mkSystem = import ./lib/mksystem.nix {
        inherit
          inputs
          nixpkgs
          mac-app-util
          neovim-nightly-overlay
          ;
      };
    in
    {
      darwinConfigurations.joiedevirve = mkSystem "joiedevirve";
      darwinConfigurations.chatjoyeux = mkSystem "chatjoyeux";
    };
}
