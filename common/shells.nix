{ pkgs, ... }:
{
  environment.shells = with pkgs; [
    bashInteractive
    zsh
    fish
  ];
  environment.pathsToLink = [ "/share/fish" ];
}
