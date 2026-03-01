{ pkgs, ... }:
{
  # Base homebrew configuration
  homebrew = {
    enable = true;
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
