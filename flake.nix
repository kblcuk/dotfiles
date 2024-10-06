{
  description = "Darwin system @kblcuk";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wezterm = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      home-manager,
      wezterm,
      nixpkgs,
      mac-app-util,
      ...
    }:
    {
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations.joiedevirve = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs mac-app-util;
        };
        modules = [
          # Allow unfree packages.
          { nixpkgs.config.allowUnfree = true; }
          ./machines/joiedevirve/configuration.nix
          ./machines/joiedevirve/home.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
      # there is probably some way to simplify this copy-pasta
      darwinConfigurations.chatjoyeux = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs mac-app-util;
        };
        modules = [
          # Allow unfree packages.
          { nixpkgs.config.allowUnfree = true; }
          ./machines/chatjoyeux/configuration.nix
          ./machines/chatjoyeux/home.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
}
