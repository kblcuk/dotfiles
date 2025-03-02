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
  networking.hostName = "joiedevirve";

  homebrew = {
    enable = true;
    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      "aerospace"
      "amethyst"
      "bitwarden"
      "brave-browser"
      "imageoptim"
      "telegram"
      "wezterm"
      "whisky"
      "zoom"
    ];
  };

  # Auto upgrade nix package and the daemon service.
  # nix.package = pkgs.nix;
  services.nix-daemon = {
    logFile = "/var/log/nix-daemon.log";
    enable = true;
  };

  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";
    extra-substituters = [ "https://devenv.cachix.org" ];
    extra-trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
    trusted-users = [ "@admin" ];
  };
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
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
