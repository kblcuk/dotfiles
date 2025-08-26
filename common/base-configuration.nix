{ inputs, pkgs, ... }:
{
  imports = [
    ./shells.nix
    ./system-packages.nix
    ./homebrew.nix
    ./system-defaults.nix
  ];

  system.primaryUser = "alex";

  # No need to enable nix since this uses determinate nix installer
  # https://determinate.systems/posts/nix-darwin-updates/#what-you-should-change
  nix.enable = false;
  nix.package = pkgs.nixVersions.latest;

  # Necessary for using flakes on this system.
  nix.settings = {
    substituters = [ "https://wezterm.cachix.org" ];
    trusted-public-keys = [ "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0=" ];
    extra-substituters = [ "https://devenv.cachix.org" ];
    extra-trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
    trusted-users = [ "@admin" ];
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.bash.enable = true;
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # touch id for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
