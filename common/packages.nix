# Common packages shared by all machines
{ pkgs, nixpkgs, ... }:

with pkgs;
[
  # Core utilities
  coreutils
  eza
  fd
  glow
  gnupg
  httpie
  lazygit
  pinentry-curses
  pinentry_mac
  ripgrep
  speedtest-cli
  statix
]
++ [
  # pure 4.15.0's test suite shells out to git, but buildFishPlugin's wrapped
  # fish strips PATH so `nativeCheckInputs = [ git ]` doesn't reach the tests.
  # On Darwin with sandbox=false (Nix's macOS default), fish then resolves
  # /usr/bin/git (the xcrun stub) which fails with "error: tool 'git' not found".
  # Upstream: https://github.com/NixOS/nixpkgs/issues/485741
  # Introduced by https://github.com/NixOS/nixpkgs/pull/467497 (4.12.0 -> 4.15.0)
  (pkgs.fishPlugins.pure.overrideAttrs (_: {
    doCheck = false;
  }))
]
++ (with nixpkgs.legacyPackages.${pkgs.system}; [
  github-cli
  nerd-fonts.jetbrains-mono
  neovim
  neovide
])
