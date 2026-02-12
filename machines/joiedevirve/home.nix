{
  pkgs,
  nixpkgs,
  inputs,
  ...
}:

let
  delta_themes = pkgs.fetchFromGitHub {
    owner = "dandavison";
    repo = "delta";
    rev = "acd758f7a08df6c2ac5542a2c5a4034c664a9ed8";
    hash = "sha256-L9m5/o1I6Z5U8YdqaXsFVT3X+xvWafiz79IEAnUSLrk=";
  };
in
{
  imports = [
    ../../common/base-home.nix
  ];

  home-manager.users.alex =
    { config, pkgs, ... }:
    {
      # Add machine-specific packages to base packages
      home.packages = import ./packages.nix { inherit pkgs nixpkgs; };

      programs = {
        git = {
          enable = true;
          lfs.enable = true;
          ignores = import ../chatjoyeux/gitignore_global.nix;
          settings = {
            user = {
              name = "Alexei Mikhailov";
              email = "kblcuk@pm.me";
            };
            merge.conflictstyle = "diff3";
            pull.rebase = true;
            diff.colorMoved = "default";
            core.autocrlf = false;
            include = {
              path = "${delta_themes}/themes.gitconfig";
            };
          };
          signing = {
            key = "A983E913138CD12E";
            signByDefault = true;
          };
        };

        delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            navigate = true;
            features = "mellow-barbet";
          };
        };

        mise = {
          enable = true;
          package = inputs.nixpkgs.legacyPackages.${pkgs.system}.mise;
        };
      };
    };
}
