# Additional packages specific to joiedevirve
{ pkgs, nixpkgs, ... }:

with pkgs;
[
  aria2
  diffutils
  wget
]
++ (with nixpkgs.legacyPackages.${pkgs.system}; [
  nerd-fonts.hack
])
