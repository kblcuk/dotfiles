{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fish
    zsh
    bashInteractive
    # cachix
    openssl
    nixfmt-rfc-style
    vim
    fzf
    wget
  ];
}
