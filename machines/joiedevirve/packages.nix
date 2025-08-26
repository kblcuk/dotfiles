# Additional packages specific to joiedevirve
{ pkgs, nixpkgs, ... }:

with pkgs;
[
  aria2
  diffutils
  (ffmpeg.override {
    withFdkAac = true;
    withUnfree = true;
  })
  wget
]
++ (with nixpkgs.legacyPackages.${pkgs.system}; [
  nerd-fonts.hack
])
