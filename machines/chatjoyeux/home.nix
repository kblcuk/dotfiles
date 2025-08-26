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
        ignores = import ./gitignore_global.nix;
        userName = "Alexei Mikhailov";
        userEmail = "alexei.mikhailov@socialfirstgames.com";
        signing = {
          key = "A3CFF99E76AC8F54";
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
