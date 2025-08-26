{ inputs, pkgs, ... }:
{
  imports = [
    ../../common/base-configuration.nix
    ./homebrew.nix
  ];

  networking.hostName = "joiedevirve";
}
