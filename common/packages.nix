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
]
++ (with nixpkgs.legacyPackages.${pkgs.system}; [
  github-cli
  nerd-fonts.jetbrains-mono
  neovim
])
