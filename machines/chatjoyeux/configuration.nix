{ inputs, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    fish
    zsh
    bashInteractive
    cachix
    # some language servers require node
    # or cargo to be installed
    nodejs_22
    cargo
    nixfmt-rfc-style
    vim
    devenv
    direnv
    fzf
  ];
  environment.shells = with pkgs; [
    bashInteractive
    zsh
    fish
  ];
  environment.pathsToLink = [ "/share/fish" ];
  networking.hostName = "chatjoyeux";

  homebrew = {
    enable = true;
    taps = [
      # would be nice to use mongodb from devenv,
      # but it's unfree, and hella hard to
      # build with all deps on arm macs :/
      "mongodb/brew"
      "nikitabobko/tap"
    ];
    casks = [
      "amethyst"
      "bitwarden"
      "aerospace"
      "brave-browser"
      "discord"
      "docker"
      "google-cloud-sdk"
      "imageoptim"
      "slack"
      "spotify"
      "telegram"
      "whisky"
      "zoom"
    ];
    brews = [
      "mongodb-community@7.0"
    ];
  };

  # No need to enable nix since this uses determinate nix installer
  # https://determinate.systems/posts/nix-darwin-updates/#what-you-should-change
  nix.enable = false;
  nix.package = pkgs.nixVersions.latest;

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
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    # finder.AppleShowAllExtensions = true;
    # finder.FXPreferredViewStyle = "clmv";
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
    dock.autohide = true;
    dock.mru-spaces = false;
    dock.orientation = "left";
    dock.tilesize = 16;
    finder.ShowPathbar = true;
    menuExtraClock.Show24Hour = true;
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPassword = true;
    screensaver.askForPasswordDelay = 10;
    trackpad.Clicking = true;
    trackpad.TrackpadRightClick = true;
    universalaccess.reduceMotion = true;
  };
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
