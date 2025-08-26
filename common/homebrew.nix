{ pkgs, ... }:
{
  # Base homebrew configuration
  homebrew = {
    enable = true;
    taps = [
      "nikitabobko/tap"
    ];
    brews = [ ];
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
