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
  system.primaryUser = "alex";

  homebrew = {
    enable = true;
    taps = [
      "nikitabobko/tap"
      "mongodb/brew"
      "redis-stack/redis-stack"
    ];
    brews = [
      "mongodb-community@8.0"
    ];
    casks = [
      "aerospace"
      "bitwarden"
      "brave-browser"
      "discord"
      "google-cloud-sdk"
      "imageoptim"
      "mongodb-compass"
      "redis-insight"
      "redis-stack-server"
      "slack"
      "telegram"
      "wezterm"
      "zoom"
    ];
    # onActivation.cleanup = "uninstall";
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
  security.pam.services.sudo_local.touchIdAuth = true;

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
