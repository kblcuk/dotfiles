{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # cachix
    bashInteractive
    fish
    fzf
    nixfmt-rfc-style
    openssl
    vim
    wget
    zsh
    git
  ];
}
