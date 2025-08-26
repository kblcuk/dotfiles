# Additional packages specific to chatjoyeux (development machine)
{ pkgs, nixpkgs, ... }:

with pkgs;
[
  # Development tools
  awscli2
  claude-code
  colima
  docker
  docker-credential-helpers
  go
  k9s
  kubectl
  kubectx
  kubernetes-helm
  mas
  terraform
  # Additional utilities chatjoyeux has but joiedevirve doesn't
  age
  bat
  delta
]
++ (with nixpkgs.legacyPackages.${pkgs.system}; [
  cachix
  curl
  devenv
  direnv
  imagemagick
  jq
  (lua5_4.withPackages (
    ps: with ps; [
      busted
      luarocks
    ]
  ))
  nerd-fonts.fira-code
  neovide
  rust-analyzer
  rustfmt
  sops
  viu
  yq
])
