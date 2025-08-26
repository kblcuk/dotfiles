{
  nixpkgs,
  ...
}:
{
  imports = [
    ../../common/base-home.nix
  ];

  home-manager.users.alex =
    { config, pkgs, ... }:
    {
      # Add machine-specific packages to base packages
      home.packages = import ./packages.nix { inherit pkgs nixpkgs; };

      programs.git = {
        enable = true;
        lfs.enable = true;
        ignores = import ../chatjoyeux/gitignore_global.nix;
        userName = "Alexei Mikhailov";
        userEmail = "kblcuk@pm.me";
        signing = {
          key = "A983E913138CD12E";
          signByDefault = true;
        };
        delta = {
          enable = true;
          options.navigate = true;
        };
        extraConfig = {
          merge.conflictstyle = "diff3";
          pull.rebase = true;
          diff.colorMoved = "default";
          core.autocrlf = false;
        };
      };
    };
}
