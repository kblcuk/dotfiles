{
  description = "Darwin system @kblcuk";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      home-manager,
      wezterm,
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
          {
            # Allow unfree packages.
            nixpkgs.config.allowUnfree = true;
          }
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
