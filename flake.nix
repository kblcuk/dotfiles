{
  description = "Darwin system @kblcuk";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.brew-api.follows = "brew-api";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs-stable,
      nixpkgs,
      nix-darwin,
      home-manager,
      brew-nix,
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
          ;
      };
    in
    {
      darwinConfigurations.joiedevirve = mkSystem "joiedevirve";
      darwinConfigurations.chatjoyeux = mkSystem "chatjoyeux";
    };
}
