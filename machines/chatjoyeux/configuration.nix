{ inputs, pkgs, ... }:
{
  imports = [
    ../../common/base-configuration.nix
    ./homebrew.nix
  ];

  networking.hostName = "chatjoyeux";

  # Additional system packages for development
  environment.systemPackages = with pkgs; [ btop ];
}
