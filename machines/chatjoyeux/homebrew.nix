{ ... }:
{
  # Additional homebrew packages specific to chatjoyeux (development machine)
  homebrew = {
    taps = [
      "mongodb/brew"
      "redis-stack/redis-stack"
    ];
    brews = [
      "mongodb-community@8.2"
    ];
    casks = [
      "claude-code"
      "discord"
      "gcloud-cli"
      "mongodb-compass"
      "redis-insight"
      "redis-stack-server"
      "slack"
      "zed"
      "zoom"
    ];
  };
}
