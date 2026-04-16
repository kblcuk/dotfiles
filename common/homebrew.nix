_: {
  # Base homebrew configuration
  homebrew = {
    enable = true;
    # Should land in 26.05
    # enableFishIntegration = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # Should land in 26.05
      # cleanup = "check";
    };
    taps = [
      "nikitabobko/tap"
    ];
    brews = [
      "gmp" # for mise-en-place ruby
      "cormacrelf/tap/dark-notify"
    ];
    casks = [
      "aerospace"
      "bitwarden"
      "brave-browser"
      "raycast"
      "telegram"
      "wezterm"
      "zen"
    ];
  };
}
